create procedure create_player_regular_season_rank_by_position_group as

-- drop table if exists
if object_id('dbo.player_regular_season_rank_by_position_group', 'U') is not null
drop table dbo.player_regular_season_rank_by_position_group; 


-- create table
with t00 as 
(
    select 
    a.player_id 
    , a.player_name 
    , a.position_group
    , a.season
    , a.minutes_rank
    , minutes_rank_no_ties = row_number() over(partition by a.season order by a.minutes_rank asc)
    , a.points_rank
    , points_rank_no_ties = row_number() over(partition by a.season order by a.points_rank asc)
    , a.rebounds_rank
    , rebounds_rank_no_ties = row_number() over(partition by a.season order by a.rebounds_rank asc)
    , a.assists_rank
    , assists_rank_no_ties = row_number() over(partition by a.season order by a.assists_rank asc)
    , a.plus_minus_rank
    , plus_minus_rank_no_ties = row_number() over(partition by a.season order by a.plus_minus_rank asc)
    from [dbo].[player_position_group_regular_season_rank] a 
    where 1 = 1
    and position_group = 'G'
),
t01 as 
(
    select 
    a.player_id 
    , a.player_name 
    , a.position_group
    , a.season
    , a.minutes_rank
    , minutes_rank_no_ties = row_number() over(partition by a.season order by a.minutes_rank asc)
    , a.points_rank
    , points_rank_no_ties = row_number() over(partition by a.season order by a.points_rank asc)
    , a.rebounds_rank
    , rebounds_rank_no_ties = row_number() over(partition by a.season order by a.rebounds_rank asc)
    , a.assists_rank
    , assists_rank_no_ties = row_number() over(partition by a.season order by a.assists_rank asc)
    , a.plus_minus_rank
    , plus_minus_rank_no_ties = row_number() over(partition by a.season order by a.plus_minus_rank asc)
    from [dbo].[player_position_group_regular_season_rank] a 
    where 1 = 1
    and position_group = 'F'
),
t02 as 
(
    select 
    a.player_id 
    , a.player_name 
    , a.position_group
    , a.season
    , a.minutes_rank
    , minutes_rank_no_ties = row_number() over(partition by a.season order by a.minutes_rank asc)
    , a.points_rank
    , points_rank_no_ties = row_number() over(partition by a.season order by a.points_rank asc)
    , a.rebounds_rank
    , rebounds_rank_no_ties = row_number() over(partition by a.season order by a.rebounds_rank asc)
    , a.assists_rank
    , assists_rank_no_ties = row_number() over(partition by a.season order by a.assists_rank asc)
    , a.plus_minus_rank
    , plus_minus_rank_no_ties = row_number() over(partition by a.season order by a.plus_minus_rank asc)
    from [dbo].[player_position_group_regular_season_rank] a 
    where 1 = 1
    and position_group = 'C'
)
-- insert into table
-- minutes
select 
    season = coalesce(a.season, b.season, c.season)
    , metric = 'minutes'
    , minutes_rank = coalesce(a.minutes_rank, b.minutes_rank, c.minutes_rank)
    , guard = a.player_name
    , forward = b.player_name
    , center = c.player_name
into player_regular_season_rank_by_position_group
from 
    t00 a 
full outer join t01 b 
    on 1 = 1 
    and a.minutes_rank_no_ties = b.minutes_rank_no_ties
    and a.season = b.season 
full outer join t02 c 
    on 1 = 1 
    and a.minutes_rank_no_ties = c.minutes_rank_no_ties
    and a.season = c.season 

union all

-- points
select 
    season = coalesce(a.season, b.season, c.season)
    , metric = 'points'
    , points_rank = coalesce(a.points_rank, b.points_rank, c.points_rank)
    , guard = a.player_name
    , forward = b.player_name
    , center = c.player_name
from 
    t00 a 
full outer join t01 b 
    on 1 = 1 
    and a.points_rank_no_ties = b.points_rank_no_ties
    and a.season = b.season 
full outer join t02 c 
    on 1 = 1 
    and a.points_rank_no_ties = c.points_rank_no_ties
    and a.season = c.season 

union all 

-- rebounds
select 
    season = coalesce(a.season, b.season, c.season)
    , metric = 'rebounds'
    , rebounds_rank = coalesce(a.rebounds_rank, b.rebounds_rank, c.rebounds_rank)
    , guard = a.player_name
    , forward = b.player_name
    , center = c.player_name
from 
    t00 a 
full outer join t01 b 
    on 1 = 1 
    and a.rebounds_rank_no_ties = b.rebounds_rank_no_ties
    and a.season = b.season 
full outer join t02 c 
    on 1 = 1 
    and a.rebounds_rank_no_ties = c.rebounds_rank_no_ties
    and a.season = c.season 

union all 

-- assists
select 
    season = coalesce(a.season, b.season, c.season)
    , metric = 'assists'
    , assists_rank = coalesce(a.assists_rank, b.assists_rank, c.assists_rank)
    , guard = a.player_name
    , forward = b.player_name
    , center = c.player_name
from 
    t00 a 
full outer join t01 b 
    on 1 = 1 
    and a.assists_rank_no_ties = b.assists_rank_no_ties
    and a.season = b.season 
full outer join t02 c 
    on 1 = 1 
    and a.assists_rank_no_ties = c.assists_rank_no_ties
    and a.season = c.season 

union all 

-- rebounds
select 
    season = coalesce(a.season, b.season, c.season)
    , metric = 'Rebounds'
    , rebounds_rank = coalesce(a.rebounds_rank, b.rebounds_rank, c.rebounds_rank)
    , guard = a.player_name
    , forward = b.player_name
    , center = c.player_name
from 
    t00 a 
full outer join t01 b 
    on 1 = 1 
    and a.rebounds_rank_no_ties = b.rebounds_rank_no_ties
    and a.season = b.season 
full outer join t02 c 
    on 1 = 1 
    and a.rebounds_rank_no_ties = c.rebounds_rank_no_ties
    and a.season = c.season 

union all

-- plus minus
select 
    season = coalesce(a.season, b.season, c.season)
    , metric = 'plus minus'
    , plus_minus_rank = coalesce(a.plus_minus_rank, b.plus_minus_rank, c.plus_minus_rank)
    , guard = a.player_name
    , forward = b.player_name
    , center = c.player_name
from 
    t00 a 
full outer join t01 b 
    on 1 = 1 
    and a.plus_minus_rank_no_ties = b.plus_minus_rank_no_ties
    and a.season = b.season 
full outer join t02 c 
    on 1 = 1 
    and a.plus_minus_rank_no_ties = c.plus_minus_rank_no_ties
    and a.season = c.season 
