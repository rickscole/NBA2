SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


alter procedure [detmrs].[create_mart_tables] as 


-- pre drop tables
if object_id('detmrs.team_regular_season_select_window_performance', 'U') is not null
drop table detmrs.team_regular_season_select_window_performance; 
if object_id('detmrs.team_regular_season', 'U') is not null
drop table detmrs.team_regular_season;
if object_id('detmrs.team_regular_season_rank', 'U') is not null
drop table detmrs.team_regular_season_rank;
if object_id('detmrs.player_primary_team_season_rank', 'U') is not null
drop table detmrs.player_primary_team_season_rank;
if object_id('detmrs.scores', 'U') is not null
drop table detmrs.scores;
if object_id('detmrs.player_game_stats', 'U') is not null
drop table detmrs.player_game_stats;
if object_id('detmrs.team_score', 'U') is not null
drop table detmrs.team_score;


-- team select window performance
select 
    a.* 
into detmrs.team_regular_season_select_window_performance
from bi.team_regular_season_select_window_performance a
where 1 = 1 
    and a.team_name = 'Detroit Pistons'
    and a.is_most_current_season = 1


-- team regular season stats
select 
    a.* 
into detmrs.team_regular_season  
from dbo.team_regular_season a
inner join (select max(season) as max_season from dbo.season) b on a.season = b.max_season
where 1 = 1 
    and a.team_name = 'Detroit Pistons'


-- team regular season rankings
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
into [detmrs].[team_regular_season_rank]
from [dbo].[team_regular_season_rank] a
inner join (select max(season) as max_season from dbo.season) b on a.season = b.max_season
where team_name = 'Detroit Pistons'


-- player rankings within the team
select
	a.*
    , primary_position_group = c.position_group
    , minutes_bucket = d.player_minutes_category
into detmrs.player_primary_team_season_rank
from dbo.player_primary_team_season_rank a 
inner join (select max(season) as max_season from bi.season) b on a.season = b.max_season
left join [dbo].[player_season_primary_and_concat_position] c on a.player_name = c.player_name and a.season = c.season
left join [dbo].[player_regular_season_minutes_bucket] d on a.player_name = d.player_name and a.season = d.season
where a.primary_team_name = 'Detroit Pistons'


-- scores
select
    sc.external_id 
    , sc.season
    , opponent = case when sc.home_team = 'Detroit Pistons' then sc.away_team else sc.home_team end
    , home_or_away = case when sc.home_team = 'Detroit Pistons' then 'Home' else 'Away' end
    , team_score = case when sc.home_team = 'Detroit Pistons' then sc.home_score else sc.away_score end 
    , opponent_score = case when sc.home_team = 'Detroit Pistons' then sc.away_score else sc.home_score end
    , w_or_l = case when sc.winning_team = 'Detroit Pistons' then 'W' else 'L' end
    , was_there_overtime_verbose = case when sc.was_there_overtime = 1 then 'Yes' else 'No' end
    , q1_points = case when sc.home_team = 'Detroit Pistons' then sc.home_q1_points else sc.away_q1_points end
    , q2_points = case when sc.home_team = 'Detroit Pistons' then sc.home_q2_points else sc.away_q2_points end
    , q3_points = case when sc.home_team = 'Detroit Pistons' then sc.home_q3_points else sc.away_q3_points end
    , q4_points = case when sc.home_team = 'Detroit Pistons' then sc.home_q4_points else sc.away_q4_points end
    , actual_game_date
into detmrs.scores
from clean.scores sc
inner join (select max(season) as max_season from bi.season) b on sc.season = b.max_season
where 1 = 1 
    and (away_team = 'Detroit Pistons' or home_team = 'Detroit Pistons')


-- player game stats
select 
    pgs.*
    , primary_position_group = c.position_group
    , minutes_bucket = d.player_minutes_category
into detmrs.player_game_stats
from bi.player_game_stats pgs 
inner join (select max(season) as max_season from bi.season) b on pgs.season = b.max_season
left join [dbo].[player_season_primary_and_concat_position] c on pgs.player_name = c.player_name and pgs.season = c.season
left join [dbo].[player_regular_season_minutes_bucket] d on pgs.player_name = d.player_name and pgs.season = d.season
where 1 = 1 
    and pgs.team_name = 'Detroit Pistons'
    and pgs.game_date is not null


-- team scores
select 
    a.external_id
    , a.season 
    , a.team_name 
    , a.wins 
    , a.losses
    , points_scored = cast(a.points_scored as float)
    , points_allowed = cast(a.points_allowed as float)
    , a.game_date
    , a.duration_minutes
    , a.actual_game_date
    , a.did_team_win
    , a.game_type 
    , a.home_or_away
    , did_team_win_verbose = case when a.did_team_win = 1 then 'Win' else 'Loss' end
into detmrs.team_score
from dbo.team_score a
inner join (select max(season) as max_season from dbo.season) b on a.season = b.max_season
where 1 = 1 
    and a.team_name = 'Detroit Pistons'
GO


select * from scores where game_date >= '2025-03-01'
select * from stg.scores
select * from [MBTI].[dbo].[scores] order by ts desc
select top 100 * from clean.scores order by actual_game_date desc


select 
   points_allowed
   , points_scored 
from detmrs.team_score a
order by game_date desc



select 
    a.*
from detmrs.team_score a
where game_type = 'Regular'
order by game_date desc


select * from [MBTI].[dbo].[scores] where season = 2024 and (home_team = 'Detroit Pistons' or away_team = 'Detroit Pistons')

select * from [MBTI].[dbo].[scores] where game_date = '2025-03-04'
select * from [MBTI].[dbo].[scores] where game_date = '2025-03-03'
select * from [MBTI].[clean].[scores] where game_date = '2025-03-04'



select * from mbti.dbo.team_score where season = 2024


select team_name, sum(points_scored - points_allowed) 
from mbti.dbo.team_score
where season = 2024
group by team_name
