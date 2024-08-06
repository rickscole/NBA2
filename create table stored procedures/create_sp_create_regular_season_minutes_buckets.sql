SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE procedure [dbo].[create_regular_season_minutes_buckets] as

-- drop table if exists
if object_id('dbo.regular_season_minutes_buckets', 'U') is not null
drop table dbo.regular_season_minutes_buckets; 


with t00 as
(
	select 
	a.season
	, minutes = sum(a.minutes)
	from [dbo].[player_regular_season_rank] a
	group by
	a.season
),
t01 as
(
	select
	a.player_id
	, a.player_name
	, a.season
	, a.minutes
	-- , plus_minus_per_minute_rank = dense_rank() over(partition by a.season order by a.plus_minus_per_minute desc)
	-- , pat_rank = row_number() over(partition by a.season order by a.pat desc)
	-- , thing = sum(a.minutes) over(order by a.minutes desc rows between unbounded preceding and current row)
	, cum_pareto_percent = cast(sum(a.minutes) over(partition by a.season order by a.minutes desc rows between unbounded preceding and current row) as float)/cast(max(b.minutes) as float) 
	from 
	[dbo].[player_regular_season_rank] a
	inner join t00 b
	on a.season = b.season
	where 1 = 1
	-- and a.season = 2023
	group by
	a.player_id
	, a.player_name
	, a.season
	, a.minutes
)
select
x.season
, superstar_minutes = a.minutes
, star_minutes = b.minutes
, starter_minutes = c.minutes
, rotation_minutes = d.minutes
, all_players_minutes = 0
into dbo.regular_season_minutes_buckets
from (select distinct season from t01) x
left join (select season, min(minutes) as minutes from t01 where cum_pareto_percent <= .2 group by season) a on x.season = a.season
left join (select season, min(minutes) as minutes from t01 where cum_pareto_percent <= .4 group by season) b on x.season = b.season
left join (select season, min(minutes) as minutes from t01 where cum_pareto_percent <= .6 group by season) c on x.season = c.season
left join (select season, min(minutes) as minutes from t01 where cum_pareto_percent <= .8 group by season) d on x.season = d.season
GO
