SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE procedure [dbo].[create_player_season_primary_and_concat_team] as


-- drop table if exists
if object_id('dbo.player_season_primary_and_concat_team', 'U') is not null
drop table dbo.player_season_primary_and_concat_team; 


-- create table
with t00 as 
(
    select 
    pgs.player_id 
    , pgs.player_name
    , pgs.season 
    , pgs.team_id
    , pgs.team_name
    , player_season_team_rank = row_number() over(partition by pgs.player_id, pgs.player_name, pgs.season order by count(*) desc)
    , number_of_games = count(*)
    from [clean].[player_game_stats] pgs
    where 1 = 1 
    group by 
    pgs.player_id 
    , pgs.player_name
    , pgs.season 
    , pgs.team_id
    , pgs.team_name
),
t01 as 
(
    select 
    a.player_id 
    , a.player_name
    , a.season 
    , player_season_team_rank
    , primary_team_id = a.team_id
    , primary_team_name = a.team_name
    , team_or_teams = STUFF((
            select ',' + b.team_name
            from t00 b
            where b.player_id = a.player_id and b.player_name = a.player_name and b.season = a.season
            for xml path(''), type).value('.', 'NVARCHAR(MAX)'), 1, 1, '')
    from t00 a
)
select *
into dbo.player_season_primary_and_concat_team
from t01
where 1 = 1
and player_season_team_rank = 1


GO
