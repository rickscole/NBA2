
/*
select * from [dbo].[player_primary_team_season_rank] 
where season = 2024 -- and primary_team_name = 'Detroit Pistons'
*/
-- order by percent_rebounds desc

/*
select a.* 
, cast(a.three_pointers_made as float) / cast(c.three_pointers_made as float)
from player_regular_season_rank a 
left join player_season_primary_and_concat_team b on a.player_id = b.player_id and a.season = b.season
left join team_regular_season c on b.primary_team_name = c.team_name and a.season = c.season
where 1 = 1 
    and a.season = 2024
order by 
    cast(a.three_pointers_made as float) / cast(c.three_pointers_made as float) desc

select a.* 
, cast(a.blocks as float) / cast(a.[minutes] as float)
from player_regular_season_rank a 
where 1 = 1 
    and a.season = 2024 and a.[minutes] > 1000
order by 
    cast(a.blocks as float) / cast(a.[minutes] as float) desc
*/

/*

select * from [dbo].[player_stats_horizon_changes]
select * from [dbo].[player_stats_horizon_averages]
select * from [dbo].[player_stats_horizon_changes_stretched]

select 
    a.player_name
    , a.current_period
    , a.previous_period
    , a.delta_pseudo_fantasy_score
    , a.delta_pseudo_fantasy_score_normalized
    , is_trend_positive_verbose =
    	case 
    	when a.is_trend_positive = 1 then 'Yes'
        else 'No'
        end
    , short_medium_long_term_category = 
    	case 
    	when a.current_period in (1, 5, 10, 20) then 'Short-Term'
        when a.current_period in (41, 82) then 'Medium-Term'
        when a.current_period in (164, 246, 328) then 'Long-Term'
        else 'Other'
        end
    , short_medium_long_term_category_order = 
    	case 
    	when a.current_period in (1, 5, 10, 20) then 0
        when a.current_period in (41, 82) then 1
        when a.current_period in (164, 246, 328) then 2
        else 'Other'
        end
from [dbo].[player_stats_horizon_changes] a
*/

/*
select a.*
from [dbo].[player_stats_horizon_changes] a 
inner join player_season_primary_and_concat_team b on a.player_id = b.player_id
inner join (select max(season) as max_season from dbo.season) c on b.season = c.max_season
where 1 = 1 
    and b.primary_team_name = 'Detroit Pistons'
    and b.player_name = 'Cade Cunningham'
    and a.previous_period <= 82


select
a.*
, is_trend_positive_verbose =
    	case 
    	when a.is_trend_positive = 1 then 'Yes'
        else 'No'
        end
, short_medium_long_term_category = 
    case 
    when a.current_period in (1, 5, 10, 20) then 'Short-Term'
    when a.current_period in (41, 82) then 'Medium-Term'
    when a.current_period in (164, 246, 328) then 'Long-Term'
    else 'Other'
    end
, short_medium_long_term_category_order = 
    case 
    when a.current_period in (1, 5, 10, 20) then 0
    when a.current_period in (41, 82) then 1
    when a.current_period in (164, 246, 328) then 2
    else 'Other'
    end
from detmrs.player_stats_horizon_changes a



select
a.*
, is_trend_positive_verbose =
    	case 
    	when a.is_trend_positive = 1 then 'Yes'
        else 'No'
        end
, short_medium_long_term_category = 
    case 
    when a.current_period in (1, 5, 10, 20) then 'Short-Term'
    when a.current_period in (41, 82) then 'Medium-Term'
    when a.current_period in (164, 246, 328) then 'Long-Term'
    else 'Other'
    end
, short_medium_long_term_category_order = 
    case 
    when a.current_period in (1, 5, 10, 20) then 0
    when a.current_period in (41, 82) then 1
    when a.current_period in (164, 246, 328) then 2
    else 'Other'
    end
from detmrs.player_stats_horizon_changes a
*/

-- select * from player_stats_horizon_changes




-- select * from detmrs.player_stats_horizon_changes a


-- select * from player_stats_horizon_changes



/*
-- pre drop tables
if object_id('temp.player_stats_horizon_changes_stacked_00', 'U') is not null
drop table temp.player_stats_horizon_changes_stacked_00; 


select 
    a.*
into temp.player_stats_horizon_changes_stacked_00
from [dbo].[player_stats_horizon_changes] a 
inner join player_season_primary_and_concat_team b on a.player_id = b.player_id
inner join (select max(season) as max_season from dbo.season) c on b.season = c.max_season
where 1 = 1 
    and b.primary_team_name in ('Detroit Pistons', 'Miami Heat', 'Los Angeles Lakers')
    and a.previous_period <= 82



select player_id, player_name, current_period, previous_period, previous_horizon_avg_value = previous_horizon_avg_points, current_horizon_avg_value = current_horizon_avg_points, delta_value = delta_points, roc_value = roc_points, is_trend_positive = case when delta_points > 0 then 1 else 0 end, metric_name =  'Points' from temp.player_stats_horizon_changes_stacked_00 
union all select player_id, player_name, current_period, previous_period, previous_horizon_avg_rebounds, current_horizon_avg_rebounds, delta_rebounds, roc_rebounds, case when delta_rebounds > 0 then 1 else 0 end, 'Rebounds' from temp.player_stats_horizon_changes_stacked_00
union all select player_id, player_name, current_period, previous_period, previous_horizon_avg_assists, current_horizon_avg_assists, delta_assists, roc_assists, case when delta_assists > 0 then 1 else 0 end, 'Assists' from temp.player_stats_horizon_changes_stacked_00
union all select player_id, player_name, current_period, previous_period, previous_horizon_avg_pra, current_horizon_avg_pra, delta_pra, roc_pra, case when delta_pra > 0 then 1 else 0 end, 'PRA' from temp.player_stats_horizon_changes_stacked_00
union all select player_id, player_name, current_period, previous_period, previous_horizon_avg_turnovers, current_horizon_avg_turnovers, delta_turnovers, roc_turnovers, case when delta_turnovers < 0 then 1 else 0 end, 'Turnovers' from temp.player_stats_horizon_changes_stacked_00
union all select player_id, player_name, current_period, previous_period, previous_horizon_avg_blocks, current_horizon_avg_blocks, delta_blocks, roc_blocks, case when delta_blocks > 0 then 1 else 0 end, 'Blocks' from temp.player_stats_horizon_changes_stacked_00
union all select player_id, player_name, current_period, previous_period, previous_horizon_avg_three_pointers_made, current_horizon_avg_three_pointers_made, delta_three_pointers_made, roc_three_pointers_made, case when delta_three_pointers_made > 0 then 1 else 0 end, 'Three Pointers Made' from temp.player_stats_horizon_changes_stacked_00
union all select player_id, player_name, current_period, previous_period, previous_horizon_avg_three_pointers_attempted, current_horizon_avg_three_pointers_attempted, delta_three_pointers_attempted, roc_three_pointers_attempted, case when delta_three_pointers_attempted > 0 then 1 else 0 end, 'Three Pointers Attempted' from temp.player_stats_horizon_changes_stacked_00
union all select player_id, player_name, current_period, previous_period, previous_horizon_avg_free_throws_made, current_horizon_avg_free_throws_made, delta_free_throws_made, roc_free_throws_made, case when delta_free_throws_made > 0 then 1 else 0 end, 'Free Throws Made' from temp.player_stats_horizon_changes_stacked_00
union all select player_id, player_name, current_period, previous_period, previous_horizon_avg_free_throws_attempted, current_horizon_avg_free_throws_attempted, delta_free_throws_attempted, roc_free_throws_attempted, case when delta_free_throws_attempted > 0 then 1 else 0 end, 'Free Throws Attempted' from temp.player_stats_horizon_changes_stacked_00
union all select player_id, player_name, current_period, previous_period, previous_horizon_avg_field_goals_made, current_horizon_avg_field_goals_made, delta_field_goals_made, roc_field_goals_made, case when delta_field_goals_made > 0 then 1 else 0 end, 'Field Goals Made' from temp.player_stats_horizon_changes_stacked_00
union all select player_id, player_name, current_period, previous_period, previous_horizon_avg_field_goals_attempted, current_horizon_avg_field_goals_attempted, delta_field_goals_attempted, roc_field_goals_attempted, case when delta_field_goals_attempted > 0 then 1 else 0 end, 'Field Goals Attempted' from temp.player_stats_horizon_changes_stacked_00
union all select player_id, player_name, current_period, previous_period, previous_horizon_avg_field_goals_attempted, current_horizon_avg_field_goals_attempted, delta_field_goals_attempted, roc_field_goals_attempted, case when delta_field_goals_attempted > 0 then 1 else 0 end, 'Field Goals Attempted' from temp.player_stats_horizon_changes_stacked_00
union all select player_id, player_name, current_period, previous_period, previous_horizon_avg_plus_minus, current_horizon_avg_plus_minus, delta_plus_minus, roc_plus_minus, case when delta_plus_minus > 0 then 1 else 0 end, 'Plus Minus' from temp.player_stats_horizon_changes_stacked_00
union all select player_id, player_name, current_period, previous_period, previous_horizon_avg_lift, current_horizon_avg_lift, delta_lift, roc_lift, case when delta_lift > 0 then 1 else 0 end, 'Lift' from temp.player_stats_horizon_changes_stacked_00
union all select player_id, player_name, current_period, previous_period, previous_horizon_avg_fouls, current_horizon_avg_fouls, delta_fouls, roc_fouls, case when delta_fouls > 0 then 1 else 0 end, 'Fouls' from temp.player_stats_horizon_changes_stacked_00


-- pre drop tables
if object_id('temp.player_stats_horizon_changes_stacked_00', 'U') is not null
drop table temp.player_stats_horizon_changes_stacked_00; 
*/

-- select * from [dbo].[player_primary_team_season_rank] where season = 2024 and primary_team_name = 'Detroit Pistons'

-- select * from detmrs.player_primary_team_season_rank

-- create schema miamrs

/*
select
    sc.external_id 
    , sc.season
    , opponent = case when sc.home_team = 'Los Angeles Lakers' then sc.away_team else sc.home_team end
    , home_or_away = case when sc.home_team = 'Los Angeles Lakers' then 'Home' else 'Away' end
    , team_score = case when sc.home_team = 'Los Angeles Lakers' then sc.home_score else sc.away_score end 
    , opponent_score = case when sc.home_team = 'Los Angeles Lakers' then sc.away_score else sc.home_score end
    , w_or_l = case when sc.winning_team = 'Los Angeles Lakers' then 'W' else 'L' end
    , was_there_overtime_verbose = case when sc.was_there_overtime = 1 then 'Yes' else 'No' end
    , q1_points = case when sc.home_team = 'Los Angeles Lakers' then sc.home_q1_points else sc.away_q1_points end
    , q2_points = case when sc.home_team = 'Los Angeles Lakers' then sc.home_q2_points else sc.away_q2_points end
    , q3_points = case when sc.home_team = 'Los Angeles Lakers' then sc.home_q3_points else sc.away_q3_points end
    , q4_points = case when sc.home_team = 'Los Angeles Lakers' then sc.home_q4_points else sc.away_q4_points end
    , actual_game_date
from clean.scores sc
inner join (select max(season) as max_season from bi.season) b on sc.season = b.max_season
where 1 = 1 
    and (away_team = 'Los Angeles Lakers' or home_team = 'Los Angeles Lakers')
*/

/*
select * from clean.scores where external_id = 14070
select * from [dbo].[scores] where external_id = 14070
update dbo.scores set home_score = 102 where external_id = 14070
update dbo.scores set away_score = 107 where external_id = 14070
update clean.scores set away_score = 107 where external_id = 14070
*/



/*
select 
    pgs.player_name
    , position = max(a.primary_position)
    , blocks = sum(pgs.blocks)
    , fouls = sum(pgs.personal_fouls)
    , minutes = sum(pgs.minutes)
    , fouls_per_minute = cast(sum(pgs.personal_fouls) as float)/ cast(sum(pgs.minutes) as float)
    , blocks_per_foul = cast(sum(pgs.blocks) as float)/ cast(sum(pgs.personal_fouls) as float)
from clean.player_game_stats pgs 
left join player_career_primary_and_concat_position a on pgs.player_id = a.player_id
where 1 = 1
group by    
    pgs.player_name
having sum(pgs.minutes) != 0 and sum(pgs.minutes) >= 1000
-- order by 
--    cast(sum(pgs.blocks) as float)/ cast(sum(pgs.personal_fouls) as float) desc
*/



select 
    pgs.player_name
    , position = max(a.primary_position)
    , blocks_minutes_label = max( case when pgs.player_name in ('Rudy Gobert', 'Brook Lopez', 'Myles Turner', 'Hassan Whiteside', 'Nikola Jokic', 'Bam Adebayo', 'Nikola Vucevic', 'Karl-Anthony Towns') then pgs.player_name else '' end) 
    , blocks = sum(pgs.blocks)
    , fouls = sum(pgs.personal_fouls)
    , minutes = sum(pgs.minutes)
    , log_minutes = log(sum(pgs.minutes))
    , fouls_per_minute = cast(sum(pgs.personal_fouls) as float)/ cast(sum(pgs.minutes) as float)
    , blocks_per_foul = cast(sum(pgs.blocks) as float)/ cast(sum(pgs.personal_fouls) as float)
from clean.player_game_stats pgs 
left join player_career_primary_and_concat_position a on pgs.player_id = a.player_id
where 1 = 1
group by    
    pgs.player_name
having sum(pgs.minutes) != 0 and sum(pgs.minutes) >= 1000
