SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


create procedure [dbo].[create_player_position_group_regular_season_rank] as


-- drop table if exists
if object_id('dbo.player_position_group_regular_season_rank', 'U') is not null
drop table dbo.player_position_group_regular_season_rank; 


-- recreate table
select 
    pgs.player_id
    , pgs.player_name
    , a.position_group
    , pgs.season
    , sum(pgs.minutes) as minutes
    , sum(pgs.points) as points
    , sum(pgs.field_goals_made) as field_goals_made
    , sum(pgs.field_goals_attempted) as field_goals_attempted
    , sum(pgs.free_throws_made) as free_throws_made
    , sum(pgs.free_throws_attempted) as free_throws_attempted
    , sum(pgs.three_pointers_made) as three_pointers_made
    , sum(pgs.three_pointers_attempted) as three_pointers_attempted
    , sum(pgs.offensive_rebounds) as offensive_rebounds
    , sum(pgs.defensive_rebounds) as defensive_rebounds
    , sum(pgs.assists) as assists
    , sum(pgs.personal_fouls) as personal_fouls
    , sum(pgs.turnovers) as turnovers
    , sum(pgs.blocks) as blocks
    , sum(pgs.plus_minus) as plus_minus
    , sum(pgs.rebounds) as rebounds
    , sum(pgs.pra) as pra
    , sum(pgs.astocs) as astocs
    , minutes_rank = dense_rank() over(partition by pgs.season, a.position_group order by sum(pgs.minutes) desc) 
    , points_rank = dense_rank() over(partition by pgs.season, a.position_group order by sum(pgs.points) desc) 
    , field_goals_made_rank = dense_rank() over(partition by pgs.season, a.position_group order by sum(pgs.field_goals_made) desc) 
    , field_goals_attempted_rank = dense_rank() over(partition by pgs.season order by sum(pgs.field_goals_attempted) desc) 
    , free_throws_made_rank = dense_rank() over(partition by pgs.season, a.position_group order by sum(pgs.free_throws_made) desc) 
    , free_throws_attempted_rank = dense_rank() over(partition by pgs.season, a.position_group order by sum(pgs.free_throws_attempted) desc) 
    , three_pointers_made_rank = dense_rank() over(partition by pgs.season, a.position_group order by sum(pgs.three_pointers_made) desc) 
    , three_pointers_attempted_rank = dense_rank() over(partition by pgs.season, a.position_group order by sum(pgs.three_pointers_attempted) desc) 
    , offensive_rebounds_rank = dense_rank() over(partition by pgs.season, a.position_group order by sum(pgs.offensive_rebounds) desc) 
    , defensive_rebounds_rank = dense_rank() over(partition by pgs.season, a.position_group order by sum(pgs.defensive_rebounds) desc) 
    , assists_rank = dense_rank() over(partition by pgs.season, a.position_group order by sum(pgs.assists) desc) 
    , personal_fouls_rank = dense_rank() over(partition by pgs.season, a.position_group order by sum(pgs.personal_fouls) asc) 
    , turnovers_rank = dense_rank() over(partition by pgs.season, a.position_group order by sum(pgs.turnovers) asc) 
    , blocks_rank = dense_rank() over(partition by pgs.season, a.position_group order by sum(pgs.blocks) desc) 
    , plus_minus_rank = dense_rank() over(partition by pgs.season, a.position_group order by sum(pgs.plus_minus) desc) 
    , rebounds_rank = dense_rank() over(partition by pgs.season, a.position_group order by sum(pgs.rebounds) desc) 
    , pra_rank = dense_rank() over(partition by pgs.season, a.position_group order by sum(pgs.pra) desc) 
    , astocs_rank = dense_rank() over(partition by pgs.season, a.position_group order by sum(pgs.astocs) desc) 
into 
    dbo.player_position_group_regular_season_rank
from 
    clean.player_game_stats pgs
left join clean.scores sc 
    on pgs.game_id = sc.external_id
left join [dbo].[player_season_primary_and_concat_position] a 
    on 1 = 1
    and pgs.player_id = a.player_id
    and pgs.season = a.season
where 1 = 1
    and sc.game_type = 'Regular'
group by 
    pgs.player_id
    , pgs.player_name
    , a.position_group
    , pgs.season    
GO
