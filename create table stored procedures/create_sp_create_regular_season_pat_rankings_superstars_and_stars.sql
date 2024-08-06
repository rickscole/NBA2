SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

create procedure [dbo].[create_regular_season_pat_rankings_superstars_and_stars] as


-- drop table if exists
if object_id('dbo.regular_season_pat_rankings_superstars_and_stars', 'U') is not null
drop table dbo.regular_season_pat_rankings_superstars_and_stars; 


-- recreate table
with t00 as
(
	select
	a.player_id
	, a.player_name
	, a.season
	, plus_minus_per_minute_rank = dense_rank() over(partition by a.season order by a.plus_minus_per_minute desc)
	, pat_rank = row_number() over(partition by a.season order by a.pat desc)
	from 
	[dbo].[player_regular_season_pat_stats] a
	inner join regular_season_minutes_buckets b
	on a.season = b.season
	where 1 = 1
	and a.minutes >= b.star_minutes
)
select 
	rank = a.pat_rank
	, [2015] = b.player_name
	, [2016] = c.player_name
	, [2017] = d.player_name
	, [2018] = e.player_name
	, [2019] = f.player_name
	, [2020] = g.player_name
	, [2021] = h.player_name
	, [2022] = i.player_name
	, [2023] = j.player_name
into regular_season_pat_rankings_superstars_and_stars
from (select distinct pat_rank from t00) a
left join (select * from t00 where season = 2015) b on a.pat_rank = b.pat_rank
left join (select * from t00 where season = 2016) c on a.pat_rank = c.pat_rank
left join (select * from t00 where season = 2017) d on a.pat_rank = d.pat_rank
left join (select * from t00 where season = 2018) e on a.pat_rank = e.pat_rank
left join (select * from t00 where season = 2019) f on a.pat_rank = f.pat_rank
left join (select * from t00 where season = 2020) g on a.pat_rank = g.pat_rank
left join (select * from t00 where season = 2021) h on a.pat_rank = h.pat_rank
left join (select * from t00 where season = 2022) i on a.pat_rank = i.pat_rank
left join (select * from t00 where season = 2023) j on a.pat_rank = j.pat_rank
GO
