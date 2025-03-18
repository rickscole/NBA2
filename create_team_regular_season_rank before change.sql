SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE procedure [dbo].[create_team_regular_season_rank] as

-- pre drop table
if object_id('dbo.team_regular_season_rank', 'U') is not null
drop table dbo.team_regular_season_rank; 

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
into dbo.team_regular_season_rank
from dbo.team_regular_season a
GO
