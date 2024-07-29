SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE procedure [dbo].[create_player_season_primary_and_concat_position] as


-- drop table if exists
if object_id('dbo.player_season_primary_and_concat_position', 'U') is not null
drop table dbo.player_season_primary_and_concat_position; 


-- create table
with t00 as 
(
    select 
    pgs.player_id 
    , pgs.player_name
    , pgs.season 
    , pgs.position
    , player_season_position_rank = row_number() over(partition by pgs.player_id, pgs.player_name, pgs.season order by count(*) desc)
    , number_of_games = count(*)
    from [clean].[player_game_stats] pgs
    where 1 = 1 
    and pgs.position is not null
    group by 
    pgs.player_id 
    , pgs.player_name
    , pgs.season 
    , pgs.position
),
t01 as 
(
    select 
    a.player_id 
    , a.player_name
    , a.season 
    , player_season_position_rank
    , primary_position = a.position
    , position_or_positions = STUFF((
            select ',' + b.position
            from t00 b
            where b.player_id = a.player_id and b.player_name = a.player_name and b.season = a.season
            for xml path(''), type).value('.', 'NVARCHAR(MAX)'), 1, 1, '')
    from t00 a
)
select a.*, b.position_group
into player_season_primary_and_concat_position
from t01 a
left join position_group b
on a.primary_position = b.position
where 1 = 1
and player_season_position_rank = 1

GO
