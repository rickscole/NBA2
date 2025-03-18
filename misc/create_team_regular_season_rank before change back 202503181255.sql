SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE procedure [dbo].[create_team_regular_season_rank] as

-- pre drop tables
if object_id('temp.team_regular_season_rank_00', 'U') is not null
drop table temp.team_regular_season_rank_00; 
if object_id('dbo.team_regular_season_rank', 'U') is not null
drop table dbo.team_regular_season_rank; 


-- get rankings
select
a.team_name 
, a.season 
, points_scored_rank = dense_rank() over(partition by a.season order by points_scored desc) 
, points_allowed_rank = dense_rank() over(partition by a.season order by points_allowed asc) 
, plus_minus_rank = dense_rank() over(partition by a.season order by plus_minus desc) 
, wins_rank = dense_rank() over(partition by a.season order by wins desc) 
, losses_rank = dense_rank() over(partition by a.season order by losses asc) 
, q1_points_rank = dense_rank() over(partition by a.season order by q1_points desc) 
, q2_points_rank = dense_rank() over(partition by a.season order by q2_points desc) 
, q3_points_rank = dense_rank() over(partition by a.season order by q3_points desc) 
, q4_points_rank = dense_rank() over(partition by a.season order by q4_points desc) 
, half1_points_rank = dense_rank() over(partition by a.season order by half1_points desc) 
, half2_points_rank = dense_rank() over(partition by a.season order by half2_points desc) 
, overtime_points_rank = dense_rank() over(partition by a.season order by overtime_points desc) 
, lead_changes_rank = dense_rank() over(partition by a.season order by lead_changes desc) 
, overtime_games_rank = dense_rank() over(partition by a.season order by overtime_games desc) 
, field_goals_made_rank = dense_rank() over(partition by a.season order by field_goals_made desc) 
, field_goals_attempted_rank = dense_rank() over(partition by a.season order by field_goals_attempted desc) 
, free_throws_made_rank = dense_rank() over(partition by a.season order by free_throws_made desc) 
, free_throws_attempted_rank = dense_rank() over(partition by a.season order by free_throws_attempted desc) 
, three_pointers_made_rank = dense_rank() over(partition by a.season order by three_pointers_made desc) 
, three_pointers_attempted_rank = dense_rank() over(partition by a.season order by three_pointers_attempted desc) 
, offensive_rebounds_rank = dense_rank() over(partition by a.season order by offensive_rebounds desc) 
, defensive_rebounds_rank = dense_rank() over(partition by a.season order by defensive_rebounds desc) 
, rebounds_rank = dense_rank() over(partition by a.season order by rebounds desc) 
, assists_rank = dense_rank() over(partition by a.season order by assists desc) 
, personal_fouls_rank = dense_rank() over(partition by a.season order by personal_fouls asc) 
, turnovers_rank = dense_rank() over(partition by a.season order by turnovers asc) 
, blocks_rank = dense_rank() over(partition by a.season order by blocks desc) 
, field_goals_percent_rank = dense_rank() over(partition by a.season order by field_goals_percent desc) 
, free_throws_percent_rank = dense_rank() over(partition by a.season order by free_throws_percent desc) 
, three_pointers_percent_rank = dense_rank() over(partition by a.season order by three_pointers_percent desc)
, win_percent_rank = dense_rank() over(partition by a.season order by win_percent desc) 
into temp.team_regular_season_rank_00
from dbo.team_regular_season a


-- attach ordinal descriptions
select 
a.*
, points_scored_rank_verbose = concat(points_scored_rank, case when points_scored_rank % 100 > 10 and points_scored_rank % 100 < 20 then 'th' when points_scored_rank % 10 in (1) then 'st' when points_scored_rank % 10 in (2) then 'nd' when points_scored_rank % 10 in (3) then 'rd' when points_scored_rank % 10 in (0, 4, 5, 6, 7, 8, 9) then 'th' else null end)
, points_allowed_rank_verbose = concat(points_allowed_rank, case when points_allowed_rank % 100 > 10 and points_allowed_rank % 100 < 20 then 'th' when points_allowed_rank % 10 in (1) then 'st' when points_allowed_rank % 10 in (2) then 'nd' when points_allowed_rank % 10 in (3) then 'rd' when points_allowed_rank % 10 in (0, 4, 5, 6, 7, 8, 9) then 'th' else null end)
, plus_minus_rank_verbose = concat(plus_minus_rank, case when plus_minus_rank % 100 > 10 and plus_minus_rank % 100 < 20 then 'th' when plus_minus_rank % 10 in (1) then 'st' when plus_minus_rank % 10 in (2) then 'nd' when plus_minus_rank % 10 in (3) then 'rd' when plus_minus_rank % 10 in (0, 4, 5, 6, 7, 8, 9) then 'th' else null end)
, lead_changes_rank_verbose = concat(lead_changes_rank, case when lead_changes_rank % 100 > 10 and lead_changes_rank % 100 < 20 then 'th' when lead_changes_rank % 10 in (1) then 'st' when lead_changes_rank % 10 in (2) then 'nd' when lead_changes_rank % 10 in (3) then 'rd' when lead_changes_rank % 10 in (0, 4, 5, 6, 7, 8, 9) then 'th' else null end)
, free_throws_attempted_rank_verbose = concat(free_throws_attempted_rank, case when free_throws_attempted_rank % 100 > 10 and free_throws_attempted_rank % 100 < 20 then 'th' when free_throws_attempted_rank % 10 in (1) then 'st' when free_throws_attempted_rank % 10 in (2) then 'nd' when free_throws_attempted_rank % 10 in (3) then 'rd' when free_throws_attempted_rank % 10 in (0, 4, 5, 6, 7, 8, 9) then 'th' else null end)
, three_pointers_made_rank_verbose = concat( three_pointers_made_rank, case when  three_pointers_made_rank % 100 > 10 and  three_pointers_made_rank % 100 < 20 then 'th' when  three_pointers_made_rank % 10 in (1) then 'st' when  three_pointers_made_rank % 10 in (2) then 'nd' when  three_pointers_made_rank % 10 in (3) then 'rd' when  three_pointers_made_rank % 10 in (0, 4, 5, 6, 7, 8, 9) then 'th' else null end)
, three_pointers_attempted_rank_verbose = concat( three_pointers_attempted_rank, case when  three_pointers_attempted_rank % 100 > 10 and  three_pointers_attempted_rank % 100 < 20 then 'th' when  three_pointers_attempted_rank % 10 in (1) then 'st' when  three_pointers_attempted_rank % 10 in (2) then 'nd' when  three_pointers_attempted_rank % 10 in (3) then 'rd' when  three_pointers_attempted_rank % 10 in (0, 4, 5, 6, 7, 8, 9) then 'th' else null end)
, offensive_rebounds_rank_verbose = concat( offensive_rebounds_rank, case when  offensive_rebounds_rank % 100 > 10 and  offensive_rebounds_rank % 100 < 20 then 'th' when  offensive_rebounds_rank % 10 in (1) then 'st' when  offensive_rebounds_rank % 10 in (2) then 'nd' when  offensive_rebounds_rank % 10 in (3) then 'rd' when  offensive_rebounds_rank % 10 in (0, 4, 5, 6, 7, 8, 9) then 'th' else null end)
, defensive_rebounds_rank_verbose = concat( defensive_rebounds_rank, case when  defensive_rebounds_rank % 100 > 10 and  defensive_rebounds_rank % 100 < 20 then 'th' when  defensive_rebounds_rank % 10 in (1) then 'st' when  defensive_rebounds_rank % 10 in (2) then 'nd' when  defensive_rebounds_rank % 10 in (3) then 'rd' when  defensive_rebounds_rank % 10 in (0, 4, 5, 6, 7, 8, 9) then 'th' else null end)
, rebounds_rank_verbose = concat( rebounds_rank, case when  rebounds_rank % 100 > 10 and  rebounds_rank % 100 < 20 then 'th' when  rebounds_rank % 10 in (1) then 'st' when  rebounds_rank % 10 in (2) then 'nd' when  rebounds_rank % 10 in (3) then 'rd' when  rebounds_rank % 10 in (0, 4, 5, 6, 7, 8, 9) then 'th' else null end)
, personal_fouls_rank_verbose = concat( personal_fouls_rank, case when  personal_fouls_rank % 100 > 10 and  personal_fouls_rank % 100 < 20 then 'th' when  personal_fouls_rank % 10 in (1) then 'st' when  personal_fouls_rank % 10 in (2) then 'nd' when  personal_fouls_rank % 10 in (3) then 'rd' when  personal_fouls_rank % 10 in (0, 4, 5, 6, 7, 8, 9) then 'th' else null end)
, turnovers_rank_verbose = concat( turnovers_rank, case when  turnovers_rank % 100 > 10 and  turnovers_rank % 100 < 20 then 'th' when  turnovers_rank % 10 in (1) then 'st' when  turnovers_rank % 10 in (2) then 'nd' when  turnovers_rank % 10 in (3) then 'rd' when  turnovers_rank % 10 in (0, 4, 5, 6, 7, 8, 9) then 'th' else null end)
, blocks_rank_verbose = concat( blocks_rank, case when  blocks_rank % 100 > 10 and  blocks_rank % 100 < 20 then 'th' when  blocks_rank % 10 in (1) then 'st' when  blocks_rank % 10 in (2) then 'nd' when  blocks_rank % 10 in (3) then 'rd' when  blocks_rank % 10 in (0, 4, 5, 6, 7, 8, 9) then 'th' else null end)
, field_goals_percent_rank_verbose = concat( field_goals_percent_rank, case when  field_goals_percent_rank % 100 > 10 and  field_goals_percent_rank % 100 < 20 then 'th' when  field_goals_percent_rank % 10 in (1) then 'st' when  field_goals_percent_rank % 10 in (2) then 'nd' when  field_goals_percent_rank % 10 in (3) then 'rd' when  field_goals_percent_rank % 10 in (0, 4, 5, 6, 7, 8, 9) then 'th' else null end)
, free_throws_percent_rank_verbose = concat( free_throws_percent_rank, case when  free_throws_percent_rank % 100 > 10 and  free_throws_percent_rank % 100 < 20 then 'th' when  free_throws_percent_rank % 10 in (1) then 'st' when  free_throws_percent_rank % 10 in (2) then 'nd' when  free_throws_percent_rank % 10 in (3) then 'rd' when  free_throws_percent_rank % 10 in (0, 4, 5, 6, 7, 8, 9) then 'th' else null end)
, three_pointers_percent_rank_verbose = concat( three_pointers_percent_rank, case when  three_pointers_percent_rank % 100 > 10 and  three_pointers_percent_rank % 100 < 20 then 'th' when  three_pointers_percent_rank % 10 in (1) then 'st' when  three_pointers_percent_rank % 10 in (2) then 'nd' when  three_pointers_percent_rank % 10 in (3) then 'rd' when  three_pointers_percent_rank % 10 in (0, 4, 5, 6, 7, 8, 9) then 'th' else null end)
, win_percent_rank_verbose = concat(win_percent_rank, case when win_percent_rank % 100 > 10 and win_percent_rank % 100 < 20 then 'th' when win_percent_rank % 10 in (1) then 'st' when win_percent_rank % 10 in (2) then 'nd' when win_percent_rank % 10 in (3) then 'rd' when win_percent_rank % 10 in (0, 4, 5, 6, 7, 8, 9) then 'th' else null end)
, assists_rank_verbose = concat(assists_rank, case when assists_rank % 100 > 10 and assists_rank % 100 < 20 then 'th' when assists_rank % 10 in (1) then 'st' when assists_rank % 10 in (2) then 'nd' when assists_rank % 10 in (3) then 'rd' when assists_rank % 10 in (0, 4, 5, 6, 7, 8, 9) then 'th' else null end)
, wins_rank_verbose = concat(wins_rank, case when wins_rank % 100 > 10 and wins_rank % 100 < 20 then 'th' when wins_rank % 10 in (1) then 'st' when wins_rank % 10 in (2) then 'nd' when wins_rank % 10 in (3) then 'rd' when wins_rank % 10 in (0, 4, 5, 6, 7, 8, 9) then 'th' else null end)
, overtimes_games_rank_verbose = concat(overtime_games_rank, case when overtime_games_rank % 100 > 10 and overtime_games_rank % 100 < 20 then 'th' when overtime_games_rank % 10 in (1) then 'st' when overtime_games_rank % 10 in (2) then 'nd' when overtime_games_rank % 10 in (3) then 'rd' when overtime_games_rank % 10 in (0, 4, 5, 6, 7, 8, 9) then 'th' else null end)
into dbo.team_regular_season_rank
from [dbo].[team_regular_season_rank] a
inner join (select max(season) as max_season from dbo.season) b on a.season = b.max_season
where a.team_name = 'Detroit Pistons'


-- post drop tables
if object_id('temp.team_regular_season_rank_00', 'U') is not null
drop table temp.team_regular_season_rank_00; 
-- if object_id('dbo.team_regular_season_rank', 'U') is not null
-- drop table dbo.team_regular_season_rank; 


GO
