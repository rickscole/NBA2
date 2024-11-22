SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

create procedure [dbo].[create_player_regular_season_pat_percentile] as


-- drop table if exists
if object_id('dbo.player_regular_season_pat_percentile', 'U') is not null
drop table dbo.player_regular_season_pat_percentile; 


with t00 as 
(
    select
    a.season
    , max(a.plus_minus_per_minute) as max_plus_minus_per_minute
    , min(a.plus_minus_per_minute) as min_plus_minus_per_minute
    , max(a.pat) as max_pat
    , min(a.pat) as min_pat
    , are_min_and_max_equal_plus_minus_per_minute = case when max(a.plus_minus_per_minute) = min(a.plus_minus_per_minute) then 1 else 0 end
    , are_min_and_max_equal_pat = case when max(a.pat) = min(a.pat) then 1 else 0 end
    from 
    [dbo].[player_regular_season_pat_stats] a
    inner join regular_season_minutes_buckets b
    on a.season = b.season
    where 1 = 1
    and a.minutes >= b.star_minutes
    group by a.season
)
select
    a.player_id
    , a.player_name
    , a.season
    ,case when [are_min_and_max_equal_plus_minus_per_minute] = 1 then .5 else (1-0)*(cast([plus_minus_per_minute]	as float) -	cast([min_plus_minus_per_minute] as float)) /	(cast([max_plus_minus_per_minute] as float) - cast([min_plus_minus_per_minute]as float))+(0+0) end as [percent_plus_minus_per_minute]
    ,case when [are_min_and_max_equal_pat] = 1 then .5 else (1-0)*(cast([pat] as float) - cast([min_pat] as float)) / (cast([max_pat] as float) - cast([min_pat] as float))+(0+0) end as [percent_pat] 
into player_regular_season_pat_percentile
from 
    [dbo].[player_regular_season_pat_stats] a
inner join t00 b
    on a.season = b.season
inner join regular_season_minutes_buckets c
    on a.season = c.season
where 1 = 1
    and a.minutes >= c.star_minutes 
GO
