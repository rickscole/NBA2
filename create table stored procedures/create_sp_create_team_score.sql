SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[create_team_score] as

-- drop table if exists
if object_id('dbo.team_score', 'U') is not null
drop table dbo.team_score;


-- home team
select 
[external_id]
,[season]
,[duration]
,team_name = [home_team]
,wins = [home_team_wins]
,losses = [home_team_losses]
,q1_points = [home_q1_points]
,q2_points = [home_q2_points]
,q3_points = [home_q3_points]
,q4_points = [home_q4_points]
,points_scored = [home_score]
,points_allowed = [away_score]
,[officials]
,[times_tied]
,[lead_changes]
,[game_date]
,[hours]
,[minutes]
,[duration_hours]
,[duration_minutes]
,[actual_game_date]
,did_team_win = case when [did_home_team_win] = 1 then 1 else 0 end
,was_there_overtime
,half1_points = [home_half1_points]
,half2_points = [home_half2_points]
,overtime_points = [home_overtime_points]
,[game_type]
,home_or_away = 'home'
into dbo.team_score
from [clean].[scores]

union all

-- away team
select 
[external_id]
,[season]
,[duration]
,team_name = [away_team]
,wins = [away_team_wins]
,losses = [away_team_losses]
,q1_points = [away_q1_points]
,q2_points = [away_q2_points]
,q3_points = [away_q3_points]
,q4_points = [away_q4_points]
,points_scored = [away_score]
,points_allowed = [home_score]
,[officials]
,[times_tied]
,[lead_changes]
,[game_date]
,[hours]
,[minutes]
,[duration_hours]
,[duration_minutes]
,[actual_game_date]
,did_team_win = case when [did_home_team_win] = 0 then 1 else 0 end
,was_there_overtime
,half1_points = [away_half1_points]
,half2_points = [away_half2_points]
,overtime_points = [away_overtime_points]
,[game_type]
,home_or_away = 'away'
from [clean].[scores]
GO
