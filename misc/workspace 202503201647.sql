
-- pre drop tables
if object_id('temp.team_current_season_horizon_changes_00', 'U') is not null
drop table temp.team_current_season_horizon_changes_00; 


-- add game row id
select 
    tgs.*
    , team_season_game_recency_id = dense_rank() over(partition by tgs.team_name, sc.season order by sc.game_date desc) 
into temp.team_current_season_horizon_changes_00
from team_game_stats tgs
inner join clean.scores sc on tgs.external_id = sc.external_id
inner join (select max(season) as max_season from dbo.season) b on sc.season = b.max_season
where 1 = 1
    and sc.game_type in ('Regular', 'Play-in', 'Playoffs')



select  
    a.team_name 
    , avg_point_differential_01 = avg(case when a.team_season_game_recency_id <= 1 then cast(a.point_differential as float) else null end)
    , avg_point_differential_05 = avg(case when a.team_season_game_recency_id <= 5 then cast(a.point_differential as float) else null end)
    , avg_point_differential_10 = avg(case when a.team_season_game_recency_id <= 10 then cast(a.point_differential as float) else null end)
    , avg_point_differential_20 = avg(case when a.team_season_game_recency_id <= 20 then cast(a.point_differential as float) else null end)   
    , avg_point_differential_01_05_05 = avg(case when a.team_season_game_recency_id > 1 and a.team_season_game_recency_id <= 6 then cast(a.point_differential as float) else null end)
    , avg_point_differential_01_10_10 = avg(case when a.team_season_game_recency_id > 1 and a.team_season_game_recency_id <= 11 then cast(a.point_differential as float) else null end)
    , avg_point_differential_01_20_20 = avg(case when a.team_season_game_recency_id > 1 and a.team_season_game_recency_id <= 21 then cast(a.point_differential as float) else null end)
    , avg_point_differential_01_41_41 = avg(case when a.team_season_game_recency_id > 1 and a.team_season_game_recency_id <= 42 then cast(a.point_differential as float) else null end)
    , avg_point_differential_01_82_82 = avg(case when a.team_season_game_recency_id > 1 then cast(a.point_differential as float) else null end)
    , avg_point_differential_05_05_05 = avg(case when a.team_season_game_recency_id > 5 and a.team_season_game_recency_id <= 10 then cast(a.point_differential as float) else null end)
    , avg_point_differential_05_10_10 = avg(case when a.team_season_game_recency_id > 5 and a.team_season_game_recency_id <= 15 then cast(a.point_differential as float) else null end)
    , avg_point_differential_05_20_20 = avg(case when a.team_season_game_recency_id > 5 and a.team_season_game_recency_id <= 25 then cast(a.point_differential as float) else null end)
    , avg_point_differential_05_41_41 = avg(case when a.team_season_game_recency_id > 5 and a.team_season_game_recency_id <= 46 then cast(a.point_differential as float) else null end)
    , avg_point_differential_05_82_82 = avg(case when a.team_season_game_recency_id > 5 then cast(a.point_differential as float) else null end)
    , avg_point_differential_10_10_10 = avg(case when a.team_season_game_recency_id > 10 and a.team_season_game_recency_id <= 20 then cast(a.point_differential as float) else null end)
    , avg_point_differential_10_20_20 = avg(case when a.team_season_game_recency_id > 10 and a.team_season_game_recency_id <= 30 then cast(a.point_differential as float) else null end)
    , avg_point_differential_10_41_41 = avg(case when a.team_season_game_recency_id > 10 and a.team_season_game_recency_id <= 51 then cast(a.point_differential as float) else null end)
    , avg_point_differential_10_82_82 = avg(case when a.team_season_game_recency_id > 10 then cast(a.point_differential as float) else null end)
    , avg_point_differential_20_20_20 = avg(case when a.team_season_game_recency_id > 20 and a.team_season_game_recency_id <= 40 then cast(a.point_differential as float) else null end)
    , avg_point_differential_20_41_41 = avg(case when a.team_season_game_recency_id > 20 and a.team_season_game_recency_id <= 61 then cast(a.point_differential as float) else null end)
    , avg_point_differential_20_82_82 = avg(case when a.team_season_game_recency_id > 20 then cast(a.point_differential as float) else null end)
    , avg_points_scored_01 = avg(case when a.team_season_game_recency_id <= 1 then cast(a.points_scored as float) else null end)
    , avg_points_scored_05 = avg(case when a.team_season_game_recency_id <= 5 then cast(a.points_scored as float) else null end)
    , avg_points_scored_10 = avg(case when a.team_season_game_recency_id <= 10 then cast(a.points_scored as float) else null end)
    , avg_points_scored_20 = avg(case when a.team_season_game_recency_id <= 20 then cast(a.points_scored as float) else null end)   
    , avg_points_scored_01_05_05 = avg(case when a.team_season_game_recency_id > 1 and a.team_season_game_recency_id <= 6 then cast(a.points_scored as float) else null end)
    , avg_points_scored_01_10_10 = avg(case when a.team_season_game_recency_id > 1 and a.team_season_game_recency_id <= 11 then cast(a.points_scored as float) else null end)
    , avg_points_scored_01_20_20 = avg(case when a.team_season_game_recency_id > 1 and a.team_season_game_recency_id <= 21 then cast(a.points_scored as float) else null end)
    , avg_points_scored_01_41_41 = avg(case when a.team_season_game_recency_id > 1 and a.team_season_game_recency_id <= 42 then cast(a.points_scored as float) else null end)
    , avg_points_scored_01_82_82 = avg(case when a.team_season_game_recency_id > 1 then cast(a.points_scored as float) else null end)
    , avg_points_scored_05_05_05 = avg(case when a.team_season_game_recency_id > 5 and a.team_season_game_recency_id <= 10 then cast(a.points_scored as float) else null end)
    , avg_points_scored_05_10_10 = avg(case when a.team_season_game_recency_id > 5 and a.team_season_game_recency_id <= 15 then cast(a.points_scored as float) else null end)
    , avg_points_scored_05_20_20 = avg(case when a.team_season_game_recency_id > 5 and a.team_season_game_recency_id <= 25 then cast(a.points_scored as float) else null end)
    , avg_points_scored_05_41_41 = avg(case when a.team_season_game_recency_id > 5 and a.team_season_game_recency_id <= 46 then cast(a.points_scored as float) else null end)
    , avg_points_scored_05_82_82 = avg(case when a.team_season_game_recency_id > 5 then cast(a.points_scored as float) else null end)
    , avg_points_scored_10_10_10 = avg(case when a.team_season_game_recency_id > 10 and a.team_season_game_recency_id <= 20 then cast(a.points_scored as float) else null end)
    , avg_points_scored_10_20_20 = avg(case when a.team_season_game_recency_id > 10 and a.team_season_game_recency_id <= 30 then cast(a.points_scored as float) else null end)
    , avg_points_scored_10_41_41 = avg(case when a.team_season_game_recency_id > 10 and a.team_season_game_recency_id <= 51 then cast(a.points_scored as float) else null end)
    , avg_points_scored_10_82_82 = avg(case when a.team_season_game_recency_id > 10 then cast(a.points_scored as float) else null end)
    , avg_points_scored_20_20_20 = avg(case when a.team_season_game_recency_id > 20 and a.team_season_game_recency_id <= 40 then cast(a.points_scored as float) else null end)
    , avg_points_scored_20_41_41 = avg(case when a.team_season_game_recency_id > 20 and a.team_season_game_recency_id <= 61 then cast(a.points_scored as float) else null end)
    , avg_points_scored_20_82_82 = avg(case when a.team_season_game_recency_id > 20 then cast(a.points_scored as float) else null end)
    , avg_points_allowed_01 = avg(case when a.team_season_game_recency_id <= 1 then cast(a.points_allowed as float) else null end)
    , avg_points_allowed_05 = avg(case when a.team_season_game_recency_id <= 5 then cast(a.points_allowed as float) else null end)
    , avg_points_allowed_10 = avg(case when a.team_season_game_recency_id <= 10 then cast(a.points_allowed as float) else null end)
    , avg_points_allowed_20 = avg(case when a.team_season_game_recency_id <= 20 then cast(a.points_allowed as float) else null end)   
    , avg_points_allowed_01_05_05 = avg(case when a.team_season_game_recency_id > 1 and a.team_season_game_recency_id <= 6 then cast(a.points_allowed as float) else null end)
    , avg_points_allowed_01_10_10 = avg(case when a.team_season_game_recency_id > 1 and a.team_season_game_recency_id <= 11 then cast(a.points_allowed as float) else null end)
    , avg_points_allowed_01_20_20 = avg(case when a.team_season_game_recency_id > 1 and a.team_season_game_recency_id <= 21 then cast(a.points_allowed as float) else null end)
    , avg_points_allowed_01_41_41 = avg(case when a.team_season_game_recency_id > 1 and a.team_season_game_recency_id <= 42 then cast(a.points_allowed as float) else null end)
    , avg_points_allowed_01_82_82 = avg(case when a.team_season_game_recency_id > 1 then cast(a.points_allowed as float) else null end)
    , avg_points_allowed_05_05_05 = avg(case when a.team_season_game_recency_id > 5 and a.team_season_game_recency_id <= 10 then cast(a.points_allowed as float) else null end)
    , avg_points_allowed_05_10_10 = avg(case when a.team_season_game_recency_id > 5 and a.team_season_game_recency_id <= 15 then cast(a.points_allowed as float) else null end)
    , avg_points_allowed_05_20_20 = avg(case when a.team_season_game_recency_id > 5 and a.team_season_game_recency_id <= 25 then cast(a.points_allowed as float) else null end)
    , avg_points_allowed_05_41_41 = avg(case when a.team_season_game_recency_id > 5 and a.team_season_game_recency_id <= 46 then cast(a.points_allowed as float) else null end)
    , avg_points_allowed_05_82_82 = avg(case when a.team_season_game_recency_id > 5 then cast(a.points_allowed as float) else null end)
    , avg_points_allowed_10_10_10 = avg(case when a.team_season_game_recency_id > 10 and a.team_season_game_recency_id <= 20 then cast(a.points_allowed as float) else null end)
    , avg_points_allowed_10_20_20 = avg(case when a.team_season_game_recency_id > 10 and a.team_season_game_recency_id <= 30 then cast(a.points_allowed as float) else null end)
    , avg_points_allowed_10_41_41 = avg(case when a.team_season_game_recency_id > 10 and a.team_season_game_recency_id <= 51 then cast(a.points_allowed as float) else null end)
    , avg_points_allowed_10_82_82 = avg(case when a.team_season_game_recency_id > 10 then cast(a.points_allowed as float) else null end)
    , avg_points_allowed_20_20_20 = avg(case when a.team_season_game_recency_id > 20 and a.team_season_game_recency_id <= 40 then cast(a.points_allowed as float) else null end)
    , avg_points_allowed_20_41_41 = avg(case when a.team_season_game_recency_id > 20 and a.team_season_game_recency_id <= 61 then cast(a.points_allowed as float) else null end)
    , avg_points_allowed_20_82_82 = avg(case when a.team_season_game_recency_id > 20 then cast(a.points_allowed as float) else null end)
    , avg_turnovers_01 = avg(case when a.team_season_game_recency_id <= 1 then cast(a.turnovers as float) else null end)
    , avg_turnovers_05 = avg(case when a.team_season_game_recency_id <= 5 then cast(a.turnovers as float) else null end)
    , avg_turnovers_10 = avg(case when a.team_season_game_recency_id <= 10 then cast(a.turnovers as float) else null end)
    , avg_turnovers_20 = avg(case when a.team_season_game_recency_id <= 20 then cast(a.turnovers as float) else null end)   
    , avg_turnovers_01_05_05 = avg(case when a.team_season_game_recency_id > 1 and a.team_season_game_recency_id <= 6 then cast(a.turnovers as float) else null end)
    , avg_turnovers_01_10_10 = avg(case when a.team_season_game_recency_id > 1 and a.team_season_game_recency_id <= 11 then cast(a.turnovers as float) else null end)
    , avg_turnovers_01_20_20 = avg(case when a.team_season_game_recency_id > 1 and a.team_season_game_recency_id <= 21 then cast(a.turnovers as float) else null end)
    , avg_turnovers_01_41_41 = avg(case when a.team_season_game_recency_id > 1 and a.team_season_game_recency_id <= 42 then cast(a.turnovers as float) else null end)
    , avg_turnovers_01_82_82 = avg(case when a.team_season_game_recency_id > 1 then cast(a.turnovers as float) else null end)
    , avg_turnovers_05_05_05 = avg(case when a.team_season_game_recency_id > 5 and a.team_season_game_recency_id <= 10 then cast(a.turnovers as float) else null end)
    , avg_turnovers_05_10_10 = avg(case when a.team_season_game_recency_id > 5 and a.team_season_game_recency_id <= 15 then cast(a.turnovers as float) else null end)
    , avg_turnovers_05_20_20 = avg(case when a.team_season_game_recency_id > 5 and a.team_season_game_recency_id <= 25 then cast(a.turnovers as float) else null end)
    , avg_turnovers_05_41_41 = avg(case when a.team_season_game_recency_id > 5 and a.team_season_game_recency_id <= 46 then cast(a.turnovers as float) else null end)
    , avg_turnovers_05_82_82 = avg(case when a.team_season_game_recency_id > 5 then cast(a.turnovers as float) else null end)
    , avg_turnovers_10_10_10 = avg(case when a.team_season_game_recency_id > 10 and a.team_season_game_recency_id <= 20 then cast(a.turnovers as float) else null end)
    , avg_turnovers_10_20_20 = avg(case when a.team_season_game_recency_id > 10 and a.team_season_game_recency_id <= 30 then cast(a.turnovers as float) else null end)
    , avg_turnovers_10_41_41 = avg(case when a.team_season_game_recency_id > 10 and a.team_season_game_recency_id <= 51 then cast(a.turnovers as float) else null end)
    , avg_turnovers_10_82_82 = avg(case when a.team_season_game_recency_id > 10 then cast(a.turnovers as float) else null end)
    , avg_turnovers_20_20_20 = avg(case when a.team_season_game_recency_id > 20 and a.team_season_game_recency_id <= 40 then cast(a.turnovers as float) else null end)
    , avg_turnovers_20_41_41 = avg(case when a.team_season_game_recency_id > 20 and a.team_season_game_recency_id <= 61 then cast(a.turnovers as float) else null end)
    , avg_turnovers_20_82_82 = avg(case when a.team_season_game_recency_id > 20 then cast(a.turnovers as float) else null end)
    , avg_blocks_01 = avg(case when a.team_season_game_recency_id <= 1 then cast(a.blocks as float) else null end)
    , avg_blocks_05 = avg(case when a.team_season_game_recency_id <= 5 then cast(a.blocks as float) else null end)
    , avg_blocks_10 = avg(case when a.team_season_game_recency_id <= 10 then cast(a.blocks as float) else null end)
    , avg_blocks_20 = avg(case when a.team_season_game_recency_id <= 20 then cast(a.blocks as float) else null end)   
    , avg_blocks_01_05_05 = avg(case when a.team_season_game_recency_id > 1 and a.team_season_game_recency_id <= 6 then cast(a.blocks as float) else null end)
    , avg_blocks_01_10_10 = avg(case when a.team_season_game_recency_id > 1 and a.team_season_game_recency_id <= 11 then cast(a.blocks as float) else null end)
    , avg_blocks_01_20_20 = avg(case when a.team_season_game_recency_id > 1 and a.team_season_game_recency_id <= 21 then cast(a.blocks as float) else null end)
    , avg_blocks_01_41_41 = avg(case when a.team_season_game_recency_id > 1 and a.team_season_game_recency_id <= 42 then cast(a.blocks as float) else null end)
    , avg_blocks_01_82_82 = avg(case when a.team_season_game_recency_id > 1 then cast(a.blocks as float) else null end)
    , avg_blocks_05_05_05 = avg(case when a.team_season_game_recency_id > 5 and a.team_season_game_recency_id <= 10 then cast(a.blocks as float) else null end)
    , avg_blocks_05_10_10 = avg(case when a.team_season_game_recency_id > 5 and a.team_season_game_recency_id <= 15 then cast(a.blocks as float) else null end)
    , avg_blocks_05_20_20 = avg(case when a.team_season_game_recency_id > 5 and a.team_season_game_recency_id <= 25 then cast(a.blocks as float) else null end)
    , avg_blocks_05_41_41 = avg(case when a.team_season_game_recency_id > 5 and a.team_season_game_recency_id <= 46 then cast(a.blocks as float) else null end)
    , avg_blocks_05_82_82 = avg(case when a.team_season_game_recency_id > 5 then cast(a.blocks as float) else null end)
    , avg_blocks_10_10_10 = avg(case when a.team_season_game_recency_id > 10 and a.team_season_game_recency_id <= 20 then cast(a.blocks as float) else null end)
    , avg_blocks_10_20_20 = avg(case when a.team_season_game_recency_id > 10 and a.team_season_game_recency_id <= 30 then cast(a.blocks as float) else null end)
    , avg_blocks_10_41_41 = avg(case when a.team_season_game_recency_id > 10 and a.team_season_game_recency_id <= 51 then cast(a.blocks as float) else null end)
    , avg_blocks_10_82_82 = avg(case when a.team_season_game_recency_id > 10 then cast(a.blocks as float) else null end)
    , avg_blocks_20_20_20 = avg(case when a.team_season_game_recency_id > 20 and a.team_season_game_recency_id <= 40 then cast(a.blocks as float) else null end)
    , avg_blocks_20_41_41 = avg(case when a.team_season_game_recency_id > 20 and a.team_season_game_recency_id <= 61 then cast(a.blocks as float) else null end)
    , avg_blocks_20_82_82 = avg(case when a.team_season_game_recency_id > 20 then cast(a.blocks as float) else null end)
    , avg_rebounds_01 = avg(case when a.team_season_game_recency_id <= 1 then cast(a.rebounds as float) else null end)
    , avg_rebounds_05 = avg(case when a.team_season_game_recency_id <= 5 then cast(a.rebounds as float) else null end)
    , avg_rebounds_10 = avg(case when a.team_season_game_recency_id <= 10 then cast(a.rebounds as float) else null end)
    , avg_rebounds_20 = avg(case when a.team_season_game_recency_id <= 20 then cast(a.rebounds as float) else null end)   
    , avg_rebounds_01_05_05 = avg(case when a.team_season_game_recency_id > 1 and a.team_season_game_recency_id <= 6 then cast(a.rebounds as float) else null end)
    , avg_rebounds_01_10_10 = avg(case when a.team_season_game_recency_id > 1 and a.team_season_game_recency_id <= 11 then cast(a.rebounds as float) else null end)
    , avg_rebounds_01_20_20 = avg(case when a.team_season_game_recency_id > 1 and a.team_season_game_recency_id <= 21 then cast(a.rebounds as float) else null end)
    , avg_rebounds_01_41_41 = avg(case when a.team_season_game_recency_id > 1 and a.team_season_game_recency_id <= 42 then cast(a.rebounds as float) else null end)
    , avg_rebounds_01_82_82 = avg(case when a.team_season_game_recency_id > 1 then cast(a.rebounds as float) else null end)
    , avg_rebounds_05_05_05 = avg(case when a.team_season_game_recency_id > 5 and a.team_season_game_recency_id <= 10 then cast(a.rebounds as float) else null end)
    , avg_rebounds_05_10_10 = avg(case when a.team_season_game_recency_id > 5 and a.team_season_game_recency_id <= 15 then cast(a.rebounds as float) else null end)
    , avg_rebounds_05_20_20 = avg(case when a.team_season_game_recency_id > 5 and a.team_season_game_recency_id <= 25 then cast(a.rebounds as float) else null end)
    , avg_rebounds_05_41_41 = avg(case when a.team_season_game_recency_id > 5 and a.team_season_game_recency_id <= 46 then cast(a.rebounds as float) else null end)
    , avg_rebounds_05_82_82 = avg(case when a.team_season_game_recency_id > 5 then cast(a.rebounds as float) else null end)
    , avg_rebounds_10_10_10 = avg(case when a.team_season_game_recency_id > 10 and a.team_season_game_recency_id <= 20 then cast(a.rebounds as float) else null end)
    , avg_rebounds_10_20_20 = avg(case when a.team_season_game_recency_id > 10 and a.team_season_game_recency_id <= 30 then cast(a.rebounds as float) else null end)
    , avg_rebounds_10_41_41 = avg(case when a.team_season_game_recency_id > 10 and a.team_season_game_recency_id <= 51 then cast(a.rebounds as float) else null end)
    , avg_rebounds_10_82_82 = avg(case when a.team_season_game_recency_id > 10 then cast(a.rebounds as float) else null end)
    , avg_rebounds_20_20_20 = avg(case when a.team_season_game_recency_id > 20 and a.team_season_game_recency_id <= 40 then cast(a.rebounds as float) else null end)
    , avg_rebounds_20_41_41 = avg(case when a.team_season_game_recency_id > 20 and a.team_season_game_recency_id <= 61 then cast(a.rebounds as float) else null end)
    , avg_rebounds_20_82_82 = avg(case when a.team_season_game_recency_id > 20 then cast(a.rebounds as float) else null end)
    , avg_free_throws_attempted_01 = avg(case when a.team_season_game_recency_id <= 1 then cast(a.free_throws_attempted as float) else null end)
    , avg_free_throws_attempted_05 = avg(case when a.team_season_game_recency_id <= 5 then cast(a.free_throws_attempted as float) else null end)
    , avg_free_throws_attempted_10 = avg(case when a.team_season_game_recency_id <= 10 then cast(a.free_throws_attempted as float) else null end)
    , avg_free_throws_attempted_20 = avg(case when a.team_season_game_recency_id <= 20 then cast(a.free_throws_attempted as float) else null end)   
    , avg_free_throws_attempted_01_05_05 = avg(case when a.team_season_game_recency_id > 1 and a.team_season_game_recency_id <= 6 then cast(a.free_throws_attempted as float) else null end)
    , avg_free_throws_attempted_01_10_10 = avg(case when a.team_season_game_recency_id > 1 and a.team_season_game_recency_id <= 11 then cast(a.free_throws_attempted as float) else null end)
    , avg_free_throws_attempted_01_20_20 = avg(case when a.team_season_game_recency_id > 1 and a.team_season_game_recency_id <= 21 then cast(a.free_throws_attempted as float) else null end)
    , avg_free_throws_attempted_01_41_41 = avg(case when a.team_season_game_recency_id > 1 and a.team_season_game_recency_id <= 42 then cast(a.free_throws_attempted as float) else null end)
    , avg_free_throws_attempted_01_82_82 = avg(case when a.team_season_game_recency_id > 1 then cast(a.free_throws_attempted as float) else null end)
    , avg_free_throws_attempted_05_05_05 = avg(case when a.team_season_game_recency_id > 5 and a.team_season_game_recency_id <= 10 then cast(a.free_throws_attempted as float) else null end)
    , avg_free_throws_attempted_05_10_10 = avg(case when a.team_season_game_recency_id > 5 and a.team_season_game_recency_id <= 15 then cast(a.free_throws_attempted as float) else null end)
    , avg_free_throws_attempted_05_20_20 = avg(case when a.team_season_game_recency_id > 5 and a.team_season_game_recency_id <= 25 then cast(a.free_throws_attempted as float) else null end)
    , avg_free_throws_attempted_05_41_41 = avg(case when a.team_season_game_recency_id > 5 and a.team_season_game_recency_id <= 46 then cast(a.free_throws_attempted as float) else null end)
    , avg_free_throws_attempted_05_82_82 = avg(case when a.team_season_game_recency_id > 5 then cast(a.free_throws_attempted as float) else null end)
    , avg_free_throws_attempted_10_10_10 = avg(case when a.team_season_game_recency_id > 10 and a.team_season_game_recency_id <= 20 then cast(a.free_throws_attempted as float) else null end)
    , avg_free_throws_attempted_10_20_20 = avg(case when a.team_season_game_recency_id > 10 and a.team_season_game_recency_id <= 30 then cast(a.free_throws_attempted as float) else null end)
    , avg_free_throws_attempted_10_41_41 = avg(case when a.team_season_game_recency_id > 10 and a.team_season_game_recency_id <= 51 then cast(a.free_throws_attempted as float) else null end)
    , avg_free_throws_attempted_10_82_82 = avg(case when a.team_season_game_recency_id > 10 then cast(a.free_throws_attempted as float) else null end)
    , avg_free_throws_attempted_20_20_20 = avg(case when a.team_season_game_recency_id > 20 and a.team_season_game_recency_id <= 40 then cast(a.free_throws_attempted as float) else null end)
    , avg_free_throws_attempted_20_41_41 = avg(case when a.team_season_game_recency_id > 20 and a.team_season_game_recency_id <= 61 then cast(a.free_throws_attempted as float) else null end)
    , avg_free_throws_attempted_20_82_82 = avg(case when a.team_season_game_recency_id > 20 then cast(a.free_throws_attempted as float) else null end)
    , avg_three_pointers_attempted_01 = avg(case when a.team_season_game_recency_id <= 1 then cast(a.three_pointers_attempted as float) else null end)
    , avg_three_pointers_attempted_05 = avg(case when a.team_season_game_recency_id <= 5 then cast(a.three_pointers_attempted as float) else null end)
    , avg_three_pointers_attempted_10 = avg(case when a.team_season_game_recency_id <= 10 then cast(a.three_pointers_attempted as float) else null end)
    , avg_three_pointers_attempted_20 = avg(case when a.team_season_game_recency_id <= 20 then cast(a.three_pointers_attempted as float) else null end)   
    , avg_three_pointers_attempted_01_05_05 = avg(case when a.team_season_game_recency_id > 1 and a.team_season_game_recency_id <= 6 then cast(a.three_pointers_attempted as float) else null end)
    , avg_three_pointers_attempted_01_10_10 = avg(case when a.team_season_game_recency_id > 1 and a.team_season_game_recency_id <= 11 then cast(a.three_pointers_attempted as float) else null end)
    , avg_three_pointers_attempted_01_20_20 = avg(case when a.team_season_game_recency_id > 1 and a.team_season_game_recency_id <= 21 then cast(a.three_pointers_attempted as float) else null end)
    , avg_three_pointers_attempted_01_41_41 = avg(case when a.team_season_game_recency_id > 1 and a.team_season_game_recency_id <= 42 then cast(a.three_pointers_attempted as float) else null end)
    , avg_three_pointers_attempted_01_82_82 = avg(case when a.team_season_game_recency_id > 1 then cast(a.three_pointers_attempted as float) else null end)
    , avg_three_pointers_attempted_05_05_05 = avg(case when a.team_season_game_recency_id > 5 and a.team_season_game_recency_id <= 10 then cast(a.three_pointers_attempted as float) else null end)
    , avg_three_pointers_attempted_05_10_10 = avg(case when a.team_season_game_recency_id > 5 and a.team_season_game_recency_id <= 15 then cast(a.three_pointers_attempted as float) else null end)
    , avg_three_pointers_attempted_05_20_20 = avg(case when a.team_season_game_recency_id > 5 and a.team_season_game_recency_id <= 25 then cast(a.three_pointers_attempted as float) else null end)
    , avg_three_pointers_attempted_05_41_41 = avg(case when a.team_season_game_recency_id > 5 and a.team_season_game_recency_id <= 46 then cast(a.three_pointers_attempted as float) else null end)
    , avg_three_pointers_attempted_05_82_82 = avg(case when a.team_season_game_recency_id > 5 then cast(a.three_pointers_attempted as float) else null end)
    , avg_three_pointers_attempted_10_10_10 = avg(case when a.team_season_game_recency_id > 10 and a.team_season_game_recency_id <= 20 then cast(a.three_pointers_attempted as float) else null end)
    , avg_three_pointers_attempted_10_20_20 = avg(case when a.team_season_game_recency_id > 10 and a.team_season_game_recency_id <= 30 then cast(a.three_pointers_attempted as float) else null end)
    , avg_three_pointers_attempted_10_41_41 = avg(case when a.team_season_game_recency_id > 10 and a.team_season_game_recency_id <= 51 then cast(a.three_pointers_attempted as float) else null end)
    , avg_three_pointers_attempted_10_82_82 = avg(case when a.team_season_game_recency_id > 10 then cast(a.three_pointers_attempted as float) else null end)
    , avg_three_pointers_attempted_20_20_20 = avg(case when a.team_season_game_recency_id > 20 and a.team_season_game_recency_id <= 40 then cast(a.three_pointers_attempted as float) else null end)
    , avg_three_pointers_attempted_20_41_41 = avg(case when a.team_season_game_recency_id > 20 and a.team_season_game_recency_id <= 61 then cast(a.three_pointers_attempted as float) else null end)
    , avg_three_pointers_attempted_20_82_82 = avg(case when a.team_season_game_recency_id > 20 then cast(a.three_pointers_attempted as float) else null end)
    , avg_personal_fouls_01 = avg(case when a.team_season_game_recency_id <= 1 then cast(a.personal_fouls as float) else null end)
    , avg_personal_fouls_05 = avg(case when a.team_season_game_recency_id <= 5 then cast(a.personal_fouls as float) else null end)
    , avg_personal_fouls_10 = avg(case when a.team_season_game_recency_id <= 10 then cast(a.personal_fouls as float) else null end)
    , avg_personal_fouls_20 = avg(case when a.team_season_game_recency_id <= 20 then cast(a.personal_fouls as float) else null end)   
    , avg_personal_fouls_01_05_05 = avg(case when a.team_season_game_recency_id > 1 and a.team_season_game_recency_id <= 6 then cast(a.personal_fouls as float) else null end)
    , avg_personal_fouls_01_10_10 = avg(case when a.team_season_game_recency_id > 1 and a.team_season_game_recency_id <= 11 then cast(a.personal_fouls as float) else null end)
    , avg_personal_fouls_01_20_20 = avg(case when a.team_season_game_recency_id > 1 and a.team_season_game_recency_id <= 21 then cast(a.personal_fouls as float) else null end)
    , avg_personal_fouls_01_41_41 = avg(case when a.team_season_game_recency_id > 1 and a.team_season_game_recency_id <= 42 then cast(a.personal_fouls as float) else null end)
    , avg_personal_fouls_01_82_82 = avg(case when a.team_season_game_recency_id > 1 then cast(a.personal_fouls as float) else null end)
    , avg_personal_fouls_05_05_05 = avg(case when a.team_season_game_recency_id > 5 and a.team_season_game_recency_id <= 10 then cast(a.personal_fouls as float) else null end)
    , avg_personal_fouls_05_10_10 = avg(case when a.team_season_game_recency_id > 5 and a.team_season_game_recency_id <= 15 then cast(a.personal_fouls as float) else null end)
    , avg_personal_fouls_05_20_20 = avg(case when a.team_season_game_recency_id > 5 and a.team_season_game_recency_id <= 25 then cast(a.personal_fouls as float) else null end)
    , avg_personal_fouls_05_41_41 = avg(case when a.team_season_game_recency_id > 5 and a.team_season_game_recency_id <= 46 then cast(a.personal_fouls as float) else null end)
    , avg_personal_fouls_05_82_82 = avg(case when a.team_season_game_recency_id > 5 then cast(a.personal_fouls as float) else null end)
    , avg_personal_fouls_10_10_10 = avg(case when a.team_season_game_recency_id > 10 and a.team_season_game_recency_id <= 20 then cast(a.personal_fouls as float) else null end)
    , avg_personal_fouls_10_20_20 = avg(case when a.team_season_game_recency_id > 10 and a.team_season_game_recency_id <= 30 then cast(a.personal_fouls as float) else null end)
    , avg_personal_fouls_10_41_41 = avg(case when a.team_season_game_recency_id > 10 and a.team_season_game_recency_id <= 51 then cast(a.personal_fouls as float) else null end)
    , avg_personal_fouls_10_82_82 = avg(case when a.team_season_game_recency_id > 10 then cast(a.personal_fouls as float) else null end)
    , avg_personal_fouls_20_20_20 = avg(case when a.team_season_game_recency_id > 20 and a.team_season_game_recency_id <= 40 then cast(a.personal_fouls as float) else null end)
    , avg_personal_fouls_20_41_41 = avg(case when a.team_season_game_recency_id > 20 and a.team_season_game_recency_id <= 61 then cast(a.personal_fouls as float) else null end)
    , avg_personal_fouls_20_82_82 = avg(case when a.team_season_game_recency_id > 20 then cast(a.personal_fouls as float) else null end)
from temp.team_current_season_horizon_changes_00 a
group by 
    a.team_name 


/*
select  
    a.team_name 
    , avg_point_differential_01 = avg(case when a.team_season_game_recency_id <= 1 then cast(a.point_differential as float) else null end)
    , avg_point_differential_05 = avg(case when a.team_season_game_recency_id <= 5 then cast(a.point_differential as float) else null end)
    , avg_point_differential_10 = avg(case when a.team_season_game_recency_id <= 10 then cast(a.point_differential as float) else null end)
    , avg_point_differential_20 = avg(case when a.team_season_game_recency_id <= 20 then cast(a.point_differential as float) else null end)   
    , avg_point_differential_01_05_05 = avg(case when a.team_season_game_recency_id > 1 and a.team_season_game_recency_id <= 6 then cast(a.point_differential as float) else null end)
    , avg_point_differential_01_10_10 = avg(case when a.team_season_game_recency_id > 1 and a.team_season_game_recency_id <= 11 then cast(a.point_differential as float) else null end)
    , avg_point_differential_01_20_20 = avg(case when a.team_season_game_recency_id > 1 and a.team_season_game_recency_id <= 21 then cast(a.point_differential as float) else null end)
    , avg_point_differential_01_41_41 = avg(case when a.team_season_game_recency_id > 1 and a.team_season_game_recency_id <= 42 then cast(a.point_differential as float) else null end)
    , avg_point_differential_01_82_82 = avg(case when a.team_season_game_recency_id > 1 then cast(a.point_differential as float) else null end)
    , avg_point_differential_05_05_05 = avg(case when a.team_season_game_recency_id > 5 and a.team_season_game_recency_id <= 10 then cast(a.point_differential as float) else null end)
    , avg_point_differential_05_10_10 = avg(case when a.team_season_game_recency_id > 5 and a.team_season_game_recency_id <= 15 then cast(a.point_differential as float) else null end)
    , avg_point_differential_05_20_20 = avg(case when a.team_season_game_recency_id > 5 and a.team_season_game_recency_id <= 25 then cast(a.point_differential as float) else null end)
    , avg_point_differential_05_41_41 = avg(case when a.team_season_game_recency_id > 5 and a.team_season_game_recency_id <= 46 then cast(a.point_differential as float) else null end)
    , avg_point_differential_05_82_82 = avg(case when a.team_season_game_recency_id > 5 then cast(a.point_differential as float) else null end)
    , avg_point_differential_10_10_10 = avg(case when a.team_season_game_recency_id > 10 and a.team_season_game_recency_id <= 20 then cast(a.point_differential as float) else null end)
    , avg_point_differential_10_20_20 = avg(case when a.team_season_game_recency_id > 10 and a.team_season_game_recency_id <= 30 then cast(a.point_differential as float) else null end)
    , avg_point_differential_10_41_41 = avg(case when a.team_season_game_recency_id > 10 and a.team_season_game_recency_id <= 51 then cast(a.point_differential as float) else null end)
    , avg_point_differential_10_82_82 = avg(case when a.team_season_game_recency_id > 10 then cast(a.point_differential as float) else null end)
    , avg_point_differential_20_20_20 = avg(case when a.team_season_game_recency_id > 20 and a.team_season_game_recency_id <= 40 then cast(a.point_differential as float) else null end)
    , avg_point_differential_20_41_41 = avg(case when a.team_season_game_recency_id > 20 and a.team_season_game_recency_id <= 61 then cast(a.point_differential as float) else null end)
    , avg_point_differential_20_82_82 = avg(case when a.team_season_game_recency_id > 20 then cast(a.point_differential as float) else null end)
from temp.team_current_season_horizon_changes_00 a
group by 
    a.team_name 
*/

/*
select 
tgs.external_id
, tgs.team_name
, team_season_game_recency_id = dense_rank() over(partition by tgs.team_name, sc.season order by sc.game_date desc)
from team_game_stats tgs
inner join clean.scores sc on tgs.external_id = sc.external_id
inner join (select max(season) as max_season from dbo.season) b on sc.season = b.max_season
where 1 = 1
    and sc.game_type in ('Regular', 'Play-in', 'Playoffs')
*/



-- post drop tables
if object_id('temp.team_current_season_horizon_changes_00', 'U') is not null
drop table temp.team_current_season_horizon_changes_00; 
