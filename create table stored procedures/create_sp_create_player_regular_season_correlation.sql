SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[create_player_regular_season_correlation] as


-- drop table if exists
if object_id('dbo.player_regular_season_correlation', 'U') is not null
drop table dbo.player_regular_season_correlation; 


-- insert into table
select
    pgs.player_id
    , pgs.player_name
    , pgs.season
    , minutes = sum(pgs.[minutes]) 
    

    -- MINUTES CORRELATION --------------------------------------------------------------------------------------------------------------------------------------------------------------
    
    , correlation_minutes_points = 
        case 
            when (count(*) * sum(cast(points as float) * cast(points as float)) - sum(cast(points as float)) * sum(cast(points as float)))
        * sqrt(count(*) * sum(pgs.minutes * pgs.minutes) - sum(pgs.minutes) * sum(pgs.minutes)) = 0 then null 
        else 
        (count(*) * sum(cast(points as float) * pgs.minutes) - sum(cast(points as float)) * sum(pgs.minutes)) / (sqrt(count(*) * sum(cast(points as float) * cast(points as float)) - sum(cast(points as float)) * sum(cast(points as float)))
        * sqrt(count(*) * sum(pgs.minutes * pgs.minutes) - sum(pgs.minutes) * sum(pgs.minutes)))
        end
    , correlation_minutes_field_goals_made = 
        case 
            when (count(*) * sum(cast(field_goals_made as float) * cast(field_goals_made as float)) - sum(cast(field_goals_made as float)) * sum(cast(field_goals_made as float)))
        * sqrt(count(*) * sum(pgs.minutes * pgs.minutes) - sum(pgs.minutes) * sum(pgs.minutes)) = 0 then null 
        else 
        (count(*) * sum(cast(field_goals_made as float) * pgs.minutes) - sum(cast(field_goals_made as float)) * sum(pgs.minutes)) / (sqrt(count(*) * sum(cast(field_goals_made as float) * cast(field_goals_made as float)) - sum(cast(field_goals_made as float)) * sum(cast(field_goals_made as float)))
        * sqrt(count(*) * sum(pgs.minutes * pgs.minutes) - sum(pgs.minutes) * sum(pgs.minutes)))
        end
    , correlation_minutes_field_goals_attempted = 
        case 
            when (count(*) * sum(cast(field_goals_attempted as float) * cast(field_goals_attempted as float)) - sum(cast(field_goals_attempted as float)) * sum(cast(field_goals_attempted as float)))
        * sqrt(count(*) * sum(pgs.minutes * pgs.minutes) - sum(pgs.minutes) * sum(pgs.minutes)) = 0 then null 
        else 
        (count(*) * sum(cast(field_goals_attempted as float) * pgs.minutes) - sum(cast(field_goals_attempted as float)) * sum(pgs.minutes)) / (sqrt(count(*) * sum(cast(field_goals_attempted as float) * cast(field_goals_attempted as float)) - sum(cast(field_goals_attempted as float)) * sum(cast(field_goals_attempted as float)))
        * sqrt(count(*) * sum(pgs.minutes * pgs.minutes) - sum(pgs.minutes) * sum(pgs.minutes)))
        end
    , correlation_minutes_free_throws_made = 
        case 
            when (count(*) * sum(cast(free_throws_made as float) * cast(free_throws_made as float)) - sum(cast(free_throws_made as float)) * sum(cast(free_throws_made as float)))
        * sqrt(count(*) * sum(pgs.minutes * pgs.minutes) - sum(pgs.minutes) * sum(pgs.minutes)) = 0 then null 
        else 
        (count(*) * sum(cast(free_throws_made as float) * pgs.minutes) - sum(cast(free_throws_made as float)) * sum(pgs.minutes)) / (sqrt(count(*) * sum(cast(free_throws_made as float) * cast(free_throws_made as float)) - sum(cast(free_throws_made as float)) * sum(cast(free_throws_made as float)))
        * sqrt(count(*) * sum(pgs.minutes * pgs.minutes) - sum(pgs.minutes) * sum(pgs.minutes)))
        end
    , correlation_minutes_free_throws_attempted = 
        case 
            when (count(*) * sum(cast(free_throws_attempted as float) * cast(free_throws_attempted as float)) - sum(cast(free_throws_attempted as float)) * sum(cast(free_throws_attempted as float)))
        * sqrt(count(*) * sum(pgs.minutes * pgs.minutes) - sum(pgs.minutes) * sum(pgs.minutes)) = 0 then null 
        else 
        (count(*) * sum(cast(free_throws_attempted as float) * pgs.minutes) - sum(cast(free_throws_attempted as float)) * sum(pgs.minutes)) / (sqrt(count(*) * sum(cast(free_throws_attempted as float) * cast(free_throws_attempted as float)) - sum(cast(free_throws_attempted as float)) * sum(cast(free_throws_attempted as float)))
        * sqrt(count(*) * sum(pgs.minutes * pgs.minutes) - sum(pgs.minutes) * sum(pgs.minutes)))
        end
    , correlation_minutes_three_pointers_made = 
	case 
		when (count(*) * sum(cast(three_pointers_made as float) * cast(three_pointers_made as float)) - sum(cast(three_pointers_made as float)) * sum(cast(three_pointers_made as float)))
	* sqrt(count(*) * sum(pgs.minutes * pgs.minutes) - sum(pgs.minutes) * sum(pgs.minutes)) = 0 then null 
	else 
	(count(*) * sum(cast(three_pointers_made as float) * pgs.minutes) - sum(cast(three_pointers_made as float)) * sum(pgs.minutes)) / (sqrt(count(*) * sum(cast(three_pointers_made as float) * cast(three_pointers_made as float)) - sum(cast(three_pointers_made as float)) * sum(cast(three_pointers_made as float)))
	* sqrt(count(*) * sum(pgs.minutes * pgs.minutes) - sum(pgs.minutes) * sum(pgs.minutes)))
	end
    , correlation_minutes_three_pointers_attempted = 
        case 
            when (count(*) * sum(cast(three_pointers_attempted as float) * cast(three_pointers_attempted as float)) - sum(cast(three_pointers_attempted as float)) * sum(cast(three_pointers_attempted as float)))
        * sqrt(count(*) * sum(pgs.minutes * pgs.minutes) - sum(pgs.minutes) * sum(pgs.minutes)) = 0 then null 
        else 
        (count(*) * sum(cast(three_pointers_attempted as float) * pgs.minutes) - sum(cast(three_pointers_attempted as float)) * sum(pgs.minutes)) / (sqrt(count(*) * sum(cast(three_pointers_attempted as float) * cast(three_pointers_attempted as float)) - sum(cast(three_pointers_attempted as float)) * sum(cast(three_pointers_attempted as float)))
        * sqrt(count(*) * sum(pgs.minutes * pgs.minutes) - sum(pgs.minutes) * sum(pgs.minutes)))
        end
    , correlation_minutes_offensive_rebounds = 
        case 
            when (count(*) * sum(cast(offensive_rebounds as float) * cast(offensive_rebounds as float)) - sum(cast(offensive_rebounds as float)) * sum(cast(offensive_rebounds as float)))
        * sqrt(count(*) * sum(pgs.minutes * pgs.minutes) - sum(pgs.minutes) * sum(pgs.minutes)) = 0 then null 
        else 
        (count(*) * sum(cast(offensive_rebounds as float) * pgs.minutes) - sum(cast(offensive_rebounds as float)) * sum(pgs.minutes)) / (sqrt(count(*) * sum(cast(offensive_rebounds as float) * cast(offensive_rebounds as float)) - sum(cast(offensive_rebounds as float)) * sum(cast(offensive_rebounds as float)))
        * sqrt(count(*) * sum(pgs.minutes * pgs.minutes) - sum(pgs.minutes) * sum(pgs.minutes)))
        end
    , correlation_minutes_defensive_rebounds = 
        case 
            when (count(*) * sum(cast(defensive_rebounds as float) * cast(defensive_rebounds as float)) - sum(cast(defensive_rebounds as float)) * sum(cast(defensive_rebounds as float)))
        * sqrt(count(*) * sum(pgs.minutes * pgs.minutes) - sum(pgs.minutes) * sum(pgs.minutes)) = 0 then null 
        else 
        (count(*) * sum(cast(defensive_rebounds as float) * pgs.minutes) - sum(cast(defensive_rebounds as float)) * sum(pgs.minutes)) / (sqrt(count(*) * sum(cast(defensive_rebounds as float) * cast(defensive_rebounds as float)) - sum(cast(defensive_rebounds as float)) * sum(cast(defensive_rebounds as float)))
        * sqrt(count(*) * sum(pgs.minutes * pgs.minutes) - sum(pgs.minutes) * sum(pgs.minutes)))
        end
    , correlation_minutes_assists = 
        case 
            when (count(*) * sum(cast(assists as float) * cast(assists as float)) - sum(cast(assists as float)) * sum(cast(assists as float)))
        * sqrt(count(*) * sum(pgs.minutes * pgs.minutes) - sum(pgs.minutes) * sum(pgs.minutes)) = 0 then null 
        else 
        (count(*) * sum(cast(assists as float) * pgs.minutes) - sum(cast(assists as float)) * sum(pgs.minutes)) / (sqrt(count(*) * sum(cast(assists as float) * cast(assists as float)) - sum(cast(assists as float)) * sum(cast(assists as float)))
        * sqrt(count(*) * sum(pgs.minutes * pgs.minutes) - sum(pgs.minutes) * sum(pgs.minutes)))
        end
    , correlation_minutes_personal_fouls = 
        case 
            when (count(*) * sum(cast(personal_fouls as float) * cast(personal_fouls as float)) - sum(cast(personal_fouls as float)) * sum(cast(personal_fouls as float)))
        * sqrt(count(*) * sum(pgs.minutes * pgs.minutes) - sum(pgs.minutes) * sum(pgs.minutes)) = 0 then null 
        else 
        (count(*) * sum(cast(personal_fouls as float) * pgs.minutes) - sum(cast(personal_fouls as float)) * sum(pgs.minutes)) / (sqrt(count(*) * sum(cast(personal_fouls as float) * cast(personal_fouls as float)) - sum(cast(personal_fouls as float)) * sum(cast(personal_fouls as float)))
        * sqrt(count(*) * sum(pgs.minutes * pgs.minutes) - sum(pgs.minutes) * sum(pgs.minutes)))
        end
    
    , correlation_minutes_turnovers = 
        case 
            when (count(*) * sum(cast(turnovers as float) * cast(turnovers as float)) - sum(cast(turnovers as float)) * sum(cast(turnovers as float)))
        * sqrt(count(*) * sum(pgs.minutes * pgs.minutes) - sum(pgs.minutes) * sum(pgs.minutes)) = 0 then null 
        else 
        (count(*) * sum(cast(turnovers as float) * pgs.minutes) - sum(cast(turnovers as float)) * sum(pgs.minutes)) / (sqrt(count(*) * sum(cast(turnovers as float) * cast(turnovers as float)) - sum(cast(turnovers as float)) * sum(cast(turnovers as float)))
        * sqrt(count(*) * sum(pgs.minutes * pgs.minutes) - sum(pgs.minutes) * sum(pgs.minutes)))
        end
    , correlation_minutes_blocks = 
        case 
            when (count(*) * sum(cast(blocks as float) * cast(blocks as float)) - sum(cast(blocks as float)) * sum(cast(blocks as float)))
        * sqrt(count(*) * sum(pgs.minutes * pgs.minutes) - sum(pgs.minutes) * sum(pgs.minutes)) = 0 then null 
        else 
        (count(*) * sum(cast(blocks as float) * pgs.minutes) - sum(cast(blocks as float)) * sum(pgs.minutes)) / (sqrt(count(*) * sum(cast(blocks as float) * cast(blocks as float)) - sum(cast(blocks as float)) * sum(cast(blocks as float)))
        * sqrt(count(*) * sum(pgs.minutes * pgs.minutes) - sum(pgs.minutes) * sum(pgs.minutes)))
        end
    , correlation_minutes_rebounds = 
        case 
            when (count(*) * sum(cast(rebounds as float) * cast(rebounds as float)) - sum(cast(rebounds as float)) * sum(cast(rebounds as float)))
        * sqrt(count(*) * sum(pgs.minutes * pgs.minutes) - sum(pgs.minutes) * sum(pgs.minutes)) = 0 then null 
        else 
        (count(*) * sum(cast(rebounds as float) * pgs.minutes) - sum(cast(rebounds as float)) * sum(pgs.minutes)) / (sqrt(count(*) * sum(cast(rebounds as float) * cast(rebounds as float)) - sum(cast(rebounds as float)) * sum(cast(rebounds as float)))
        * sqrt(count(*) * sum(pgs.minutes * pgs.minutes) - sum(pgs.minutes) * sum(pgs.minutes)))
        end
    , correlation_minutes_pra = 
        case 
            when (count(*) * sum(cast(pra as float) * cast(pra as float)) - sum(cast(pra as float)) * sum(cast(pra as float)))
        * sqrt(count(*) * sum(pgs.minutes * pgs.minutes) - sum(pgs.minutes) * sum(pgs.minutes)) = 0 then null 
        else 
        (count(*) * sum(cast(pra as float) * pgs.minutes) - sum(cast(pra as float)) * sum(pgs.minutes)) / (sqrt(count(*) * sum(cast(pra as float) * cast(pra as float)) - sum(cast(pra as float)) * sum(cast(pra as float)))
        * sqrt(count(*) * sum(pgs.minutes * pgs.minutes) - sum(pgs.minutes) * sum(pgs.minutes)))
        end
    , correlation_minutes_astocs = 
        case 
            when (count(*) * sum(cast(astocs as float) * cast(astocs as float)) - sum(cast(astocs as float)) * sum(cast(astocs as float)))
        * sqrt(count(*) * sum(pgs.minutes * pgs.minutes) - sum(pgs.minutes) * sum(pgs.minutes)) = 0 then null 
        else 
        (count(*) * sum(cast(astocs as float) * pgs.minutes) - sum(cast(astocs as float)) * sum(pgs.minutes)) / (sqrt(count(*) * sum(cast(astocs as float) * cast(astocs as float)) - sum(cast(astocs as float)) * sum(cast(astocs as float)))
        * sqrt(count(*) * sum(pgs.minutes * pgs.minutes) - sum(pgs.minutes) * sum(pgs.minutes)))
        end

    /*
    -- WIN / LOSS CORRELATION --------------------------------------------------------------------------------------------------------------------------------------------------------------
    , correlation_win_loss_minutes = 
        case 
            when (count(*) * sum(cast(pgs.minutes as float) * cast(pgs.minutes as float)) - sum(cast(pgs.minutes as float)) * sum(cast(pgs.minutes as float)))
        * sqrt(count(*) * sum(did_team_win * did_team_win) - sum(did_team_win) * sum(did_team_win)) = 0 then null 
        else 
        (count(*) * sum(cast(pgs.minutes as float) * did_team_win) - sum(cast(pgs.minutes as float)) * sum(did_team_win)) / (sqrt(count(*) * sum(cast(pgs.minutes as float) * cast(pgs.minutes as float)) - sum(cast(pgs.minutes as float)) * sum(cast(pgs.minutes as float)))
        * sqrt(count(*) * sum(did_team_win * did_team_win) - sum(did_team_win) * sum(did_team_win)))
        end
    , correlation_win_loss_points = 
        case 
            when (count(*) * sum(cast(points as float) * cast(points as float)) - sum(cast(points as float)) * sum(cast(points as float)))
        * sqrt(count(*) * sum(did_team_win * did_team_win) - sum(did_team_win) * sum(did_team_win)) = 0 then null 
        else 
        (count(*) * sum(cast(points as float) * did_team_win) - sum(cast(points as float)) * sum(did_team_win)) / (sqrt(count(*) * sum(cast(points as float) * cast(points as float)) - sum(cast(points as float)) * sum(cast(points as float)))
        * sqrt(count(*) * sum(did_team_win * did_team_win) - sum(did_team_win) * sum(did_team_win)))
        end
    , correlation_win_loss_field_goals_made = 
        case 
            when (count(*) * sum(cast(field_goals_made as float) * cast(field_goals_made as float)) - sum(cast(field_goals_made as float)) * sum(cast(field_goals_made as float)))
        * sqrt(count(*) * sum(did_team_win * did_team_win) - sum(did_team_win) * sum(did_team_win)) = 0 then null 
        else 
        (count(*) * sum(cast(field_goals_made as float) * did_team_win) - sum(cast(field_goals_made as float)) * sum(did_team_win)) / (sqrt(count(*) * sum(cast(field_goals_made as float) * cast(field_goals_made as float)) - sum(cast(field_goals_made as float)) * sum(cast(field_goals_made as float)))
        * sqrt(count(*) * sum(did_team_win * did_team_win) - sum(did_team_win) * sum(did_team_win)))
        end
    , correlation_win_loss_field_goals_attempted = 
        case 
            when (count(*) * sum(cast(field_goals_attempted as float) * cast(field_goals_attempted as float)) - sum(cast(field_goals_attempted as float)) * sum(cast(field_goals_attempted as float)))
        * sqrt(count(*) * sum(did_team_win * did_team_win) - sum(did_team_win) * sum(did_team_win)) = 0 then null 
        else 
        (count(*) * sum(cast(field_goals_attempted as float) * did_team_win) - sum(cast(field_goals_attempted as float)) * sum(did_team_win)) / (sqrt(count(*) * sum(cast(field_goals_attempted as float) * cast(field_goals_attempted as float)) - sum(cast(field_goals_attempted as float)) * sum(cast(field_goals_attempted as float)))
        * sqrt(count(*) * sum(did_team_win * did_team_win) - sum(did_team_win) * sum(did_team_win)))
        end
    , correlation_win_loss_free_throws_made = 
        case 
            when (count(*) * sum(cast(free_throws_made as float) * cast(free_throws_made as float)) - sum(cast(free_throws_made as float)) * sum(cast(free_throws_made as float)))
        * sqrt(count(*) * sum(did_team_win * did_team_win) - sum(did_team_win) * sum(did_team_win)) = 0 then null 
        else 
        (count(*) * sum(cast(free_throws_made as float) * did_team_win) - sum(cast(free_throws_made as float)) * sum(did_team_win)) / (sqrt(count(*) * sum(cast(free_throws_made as float) * cast(free_throws_made as float)) - sum(cast(free_throws_made as float)) * sum(cast(free_throws_made as float)))
        * sqrt(count(*) * sum(did_team_win * did_team_win) - sum(did_team_win) * sum(did_team_win)))
        end
    , correlation_win_loss_free_throws_attempted = 
        case 
            when (count(*) * sum(cast(free_throws_attempted as float) * cast(free_throws_attempted as float)) - sum(cast(free_throws_attempted as float)) * sum(cast(free_throws_attempted as float)))
        * sqrt(count(*) * sum(did_team_win * did_team_win) - sum(did_team_win) * sum(did_team_win)) = 0 then null 
        else 
        (count(*) * sum(cast(free_throws_attempted as float) * did_team_win) - sum(cast(free_throws_attempted as float)) * sum(did_team_win)) / (sqrt(count(*) * sum(cast(free_throws_attempted as float) * cast(free_throws_attempted as float)) - sum(cast(free_throws_attempted as float)) * sum(cast(free_throws_attempted as float)))
        * sqrt(count(*) * sum(did_team_win * did_team_win) - sum(did_team_win) * sum(did_team_win)))
        end
    , correlation_win_loss_three_pointers_made = 
	case 
		when (count(*) * sum(cast(three_pointers_made as float) * cast(three_pointers_made as float)) - sum(cast(three_pointers_made as float)) * sum(cast(three_pointers_made as float)))
	* sqrt(count(*) * sum(did_team_win * did_team_win) - sum(did_team_win) * sum(did_team_win)) = 0 then null 
	else 
	(count(*) * sum(cast(three_pointers_made as float) * did_team_win) - sum(cast(three_pointers_made as float)) * sum(did_team_win)) / (sqrt(count(*) * sum(cast(three_pointers_made as float) * cast(three_pointers_made as float)) - sum(cast(three_pointers_made as float)) * sum(cast(three_pointers_made as float)))
	* sqrt(count(*) * sum(did_team_win * did_team_win) - sum(did_team_win) * sum(did_team_win)))
	end
    , correlation_win_loss_three_pointers_attempted = 
        case 
            when (count(*) * sum(cast(three_pointers_attempted as float) * cast(three_pointers_attempted as float)) - sum(cast(three_pointers_attempted as float)) * sum(cast(three_pointers_attempted as float)))
        * sqrt(count(*) * sum(did_team_win * did_team_win) - sum(did_team_win) * sum(did_team_win)) = 0 then null 
        else 
        (count(*) * sum(cast(three_pointers_attempted as float) * did_team_win) - sum(cast(three_pointers_attempted as float)) * sum(did_team_win)) / (sqrt(count(*) * sum(cast(three_pointers_attempted as float) * cast(three_pointers_attempted as float)) - sum(cast(three_pointers_attempted as float)) * sum(cast(three_pointers_attempted as float)))
        * sqrt(count(*) * sum(did_team_win * did_team_win) - sum(did_team_win) * sum(did_team_win)))
        end
    */
    /*
    , minutes_win = avg(cast((case when did_team_win = 1 then pgs.minutes else null end) as float))
    , minutes_loss = avg(cast((case when did_team_win = 0 then pgs.minutes else null end) as float))
    , points_win = avg(cast((case when did_team_win = 1 then points else null end) as float))
    , points_loss = avg(cast((case when did_team_win = 0 then points else null end) as float))
    , field_goals_made_win = avg(cast((case when did_team_win = 1 then field_goals_made else null end) as float))
    , field_goals_made_loss = avg(cast((case when did_team_win = 0 then field_goals_made else null end) as float))
    , field_goals_attempted_win = avg(cast((case when did_team_win = 1 then field_goals_attempted else null end) as float))
    , field_goals_attempted_loss = avg(cast((case when did_team_win = 0 then field_goals_attempted else null end) as float))
    , free_throws_made_win = avg(cast((case when did_team_win = 1 then free_throws_made else null end) as float))
    , free_throws_made_loss = avg(cast((case when did_team_win = 0 then free_throws_made else null end) as float))
    , free_throws_attempted_win = avg(cast((case when did_team_win = 1 then free_throws_attempted else null end) as float))
    , free_throws_attempted_loss = avg(cast((case when did_team_win = 0 then free_throws_attempted else null end) as float))
    , three_pointers_made_win = avg(cast((case when did_team_win = 1 then three_pointers_made else null end) as float))
    , three_pointers_made_loss = avg(cast((case when did_team_win = 0 then three_pointers_made else null end) as float))
    , three_pointers_attempted_win = avg(cast((case when did_team_win = 1 then three_pointers_attempted else null end) as float))
    , three_pointers_attempted_loss = avg(cast((case when did_team_win = 0 then three_pointers_attempted else null end) as float))
    */
into player_regular_season_correlation
from 
    clean.player_game_stats pgs
left join clean.scores sc 
    on pgs.game_id = sc.external_id
where 1 = 1
    and pgs.points is not null
    and pgs.did_team_win is not null
    and sc.game_type = 'Regular'
group by
    pgs.player_id
    , pgs.player_name
    , pgs.season
GO
