SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[create_player_stats_horizon_changes] @current_period int, @previous_period int as

-- predrop tables
if object_id('dbo.horizon_changes_00', 'U') is not null
drop table dbo.horizon_changes_00; 
if object_id('dbo.horizon_changes_01', 'U') is not null
drop table dbo.horizon_changes_01; 
if object_id('dbo.horizon_changes_02', 'U') is not null
drop table dbo.horizon_changes_02; 
if object_id('dbo.horizon_changes_03', 'U') is not null
drop table dbo.horizon_changes_03;


-- delete existing relevant records from table
delete from player_stats_horizon_changes where current_period = @current_period and previous_period = @previous_period


-- declare variables
declare @minimum_number_of_games_cutoff int = 
    case 
        when @previous_period = 5 then 4
        when @previous_period = 10 then 8
        when @previous_period = 20 then 16
        when @previous_period = 41 then 33
        when @previous_period = 82 then 66
        when @previous_period = 164 then 131
        when @previous_period = 246 then 196
        when @previous_period = 328 then 262
        when @previous_period = 410 then 328
        when @previous_period = 492 then 394
        when @previous_period = 574 then 460
        when @previous_period = 656 then 525
        else null 
        end
declare @most_recent_game int = 
    case
        when @current_period = 1 then -1 
        when @current_period = 5 then -1
        when @current_period = 10 then -1
        when @current_period = 20 then -1
        when @current_period = 41 then -2
        when @current_period = 82 then -4
        when @current_period = 164 then -12
        when @current_period = 246 then -12
        when @current_period = 328 then -12
        else null 
        end

-- the elligible game dates from which to pull data
select 
    pgs.player_id 
    , pgs.player_name
    , pgs.game_id
    , pgs.game_date
    , player_game_date_id = row_number() over(partition by pgs.player_id order by pgs.game_date desc)
into horizon_changes_00
from clean.player_game_stats pgs
inner join 
(
	select 5 as previous_period_length, -1 as horizon_changes_threshold
	union select 10, -2 
    union select 20, -6
	union select 41, -12
	union select 82, -24
	union select 164, -48
	union select 246, -60
	union select 328, -72
	union select 410, -96
	union select 492, -108
	union select 574, -120
	union select 656, -144
)
a on @previous_period = a.previous_period_length
where pgs.game_date >= dateadd(month, a.horizon_changes_threshold, sysdatetime())


-- base bloc of data
-- only players who meet the minimum game count
-- only players who have played with sufficient recency
select 
    pgs.player_id
    , pgs.player_name
    , pgs.game_id
    , pgs.game_date
    , pgs.points
    , horizon = case when b.player_game_date_id <= @current_period then @current_period else @previous_period end
    , pseudo_fantasy_score = 
        cast(coalesce(field_goals_made, 0) as float) 
        +  (cast(coalesce(free_throws_made, 0) as float)) / cast(2 as float)
        +  (cast(coalesce(free_throws_attempted, 0) as float) - cast(coalesce(free_throws_made, 0) as float))/ cast(-2 as float)
        +  (cast(coalesce(three_pointers_made, 0) as float)) / cast(2 as float)
        +  (cast(coalesce(three_pointers_attempted, 0) as float) - cast(coalesce(three_pointers_made, 0) as float))/ cast(-2 as float)
        +  (cast(coalesce(rebounds, 0) as float))
        +  (cast(coalesce(assists, 0) as float))
        +  (cast(coalesce(blocks, 0) as float))
        +  (cast(coalesce(turnovers, 0) as float))/cast(-1 as float)
        +  (cast(coalesce(points, 0) as float)) / cast(2 as float)


into dbo.horizon_changes_01
from clean.player_game_stats pgs 
inner join (select distinct player_id from horizon_changes_00 where player_game_date_id = @current_period) a on pgs.player_id = a.player_id
inner join (select player_id, number_of_games = count(*) from horizon_changes_00 group by player_id having count (*) >= @minimum_number_of_games_cutoff) c on pgs.player_id = c.player_id
inner join (select player_id, game_date as most_recent_game from horizon_changes_00 where player_game_date_id = 1) d on pgs.player_id = d.player_id
inner join dbo.horizon_changes_00 b on pgs.player_id = b.player_id and pgs.game_id = b.game_id
where 1 = 1 
    and b.player_game_date_id <= @previous_period
    and d.most_recent_game >= dateadd(month, @most_recent_game, sysdatetime())


-- current horizon stats
select 
    a.player_id
    , a.player_name
    -- , player_name = max(a.player_name)
    , min_game_id = min(a.game_id)
    , max_game_id = max(a.game_id)
    , points = sum(a.points)
    , pie_points = cast(sum(a.points) as float) / cast(max(b.points) as float)
    , rank_points = row_number() over(order by sum(a.points) desc)
    , avg_points = cast(avg(cast(a.points as float)) as float)
    , pseudo_fantasy_score = sum(a.pseudo_fantasy_score)
    , pie_pseudo_fantasy_score = cast(sum(a.pseudo_fantasy_score) as float) / cast(max(b.pseudo_fantasy_score) as float)
    , rank_pseudo_fantasy_score = row_number() over(order by sum(a.pseudo_fantasy_score) desc)
    , avg_pseudo_fantasy_score = avg(cast(a.pseudo_fantasy_score as float))
    , var_pseudo_fantasy_score = var(cast(a.pseudo_fantasy_score as float))
    , number_of_games = count(*)
into dbo.horizon_changes_02
from horizon_changes_01 a 
inner join 
(
    select 
    sum(points) as points
    , sum(pseudo_fantasy_score) as pseudo_fantasy_score
    from horizon_changes_01 
    where horizon = @current_period
) 
b on 1 = 1
where a.horizon = @current_period
group by 
    a.player_id
    , a.player_name


-- previous horizon stats
select 
    a.player_id
    , player_name = max(a.player_name)
    , min_game_id = min(a.game_id)
    , max_game_id = max(a.game_id)
    , points = sum(a.points)
    , pie_points = cast(sum(a.points) as float) / cast(max(b.points) as float)
    , rank_points = row_number() over(order by sum(a.points) desc)
    , avg_points = cast(avg(cast(a.points as float)) as float)
    , pseudo_fantasy_score = sum(a.pseudo_fantasy_score)
    , pie_pseudo_fantasy_score = cast(sum(a.pseudo_fantasy_score) as float) / cast(max(b.pseudo_fantasy_score) as float)
    , rank_pseudo_fantasy_score = row_number() over(order by sum(a.pseudo_fantasy_score) desc)
    , avg_pseudo_fantasy_score = avg(cast(a.pseudo_fantasy_score as float))
    , var_pseudo_fantasy_score = var(cast(a.pseudo_fantasy_score as float))
    , number_of_games = count(*)
into dbo.horizon_changes_03
from horizon_changes_01 a 
inner join 
(
    select 
    sum(points) as points
    , sum(pseudo_fantasy_score) as pseudo_fantasy_score
    from horizon_changes_01 
    where horizon = @previous_period
) 
b on 1 = 1
where a.horizon = @previous_period
group by 
    a.player_id
    , a.player_name


-- insert into existing table
insert into player_stats_horizon_changes
select
    ts = sysdatetime()
    , current_period = @current_period
    , previous_period = @previous_period
    , a.player_id
    , a.player_name
    , total_points = a.points + b.points
    , previous_horizon_points = a.points
    , previous_horizon_pie_points = a.pie_points
    , previous_horizon_rank_points = a.rank_points
    , previous_horizon_avg_points = a.avg_points
    , current_horizon_points = b.points
    , current_horizon_pie_points = b.pie_points
    , current_horizon_rank_points = b.rank_points
    , current_horizon_avg_points = b.avg_points
    , delta_pie_points = cast(b.pie_points as float) - cast(a.pie_points as float)
    , delta_rank = a.rank_points - b.rank_points
    , delta_points = cast(b.avg_points as float) - cast(a.avg_points as float)
    , roc_points = case when coalesce(a.avg_points, 0) = 0 then null else cast(b.avg_points as float) / cast(a.avg_points as float) - 1 end
    , total_pseudo_fantasy_score = a.pseudo_fantasy_score + b.pseudo_fantasy_score
    , previous_horizon_pseudo_fantasy_score = a.pseudo_fantasy_score
    , previous_horizon_pie_pseudo_fantasy_score = a.pie_pseudo_fantasy_score
    , previous_horizon_rank_pseudo_fantasy_score = a.rank_pseudo_fantasy_score
    , previous_horizon_avg_pseudo_fantasy_score = a.avg_pseudo_fantasy_score
    , current_horizon_pseudo_fantasy_score = b.pseudo_fantasy_score
    , current_horizon_pie_pseudo_fantasy_score = b.pie_pseudo_fantasy_score
    , current_horizon_rank_pseudo_fantasy_score = b.rank_pseudo_fantasy_score
    , current_horizon_avg_pseudo_fantasy_score = b.avg_pseudo_fantasy_score
    , delta_pie_pseudo_fantasy_score = cast(b.pie_pseudo_fantasy_score as float) - cast(a.pie_pseudo_fantasy_score as float)
    , delta_rank_pseudo_fantasy_score = a.rank_pseudo_fantasy_score - b.rank_pseudo_fantasy_score
    , delta_pseudo_fantasy_score = b.avg_pseudo_fantasy_score - a.avg_pseudo_fantasy_score
    , roc_pseudo_fantasy_score = case when coalesce(a.avg_pseudo_fantasy_score, 0) = 0 then null else cast(b.avg_pseudo_fantasy_score as float) / cast(a.avg_pseudo_fantasy_score as float) - 1 end
    , current_horizon_min_game_id = b.min_game_id
    , current_horizon_max_game_id = b.max_game_id
    , previous_horizon_min_game_id = a.min_game_id
    , previous_horizon_max_game_id = a.max_game_id
    -- , tstat = case when sqrt( winning_percent * (1 - winning_percent) / cast(games_played as float)) = 0 then null else
	-- (winning_percent - cast(.5 as float))/sqrt(winning_percent * (1 - winning_percent) / cast(games_played as float))
    , pseudo_fantasy_score_tstat = 
        case 
            when (b.var_pseudo_fantasy_score / b.number_of_games +  a.var_pseudo_fantasy_score / a.number_of_games) = 0 then null
            else (b.avg_pseudo_fantasy_score - a.avg_pseudo_fantasy_score) / sqrt(b.var_pseudo_fantasy_score / b.number_of_games +  a.var_pseudo_fantasy_score / a.number_of_games)
            end
-- into player_stats_horizon_changes
from dbo.horizon_changes_03 a 
left join dbo.horizon_changes_02 b on a.player_id = b.player_id


-- postdrop tables
if object_id('dbo.horizon_changes_00', 'U') is not null
drop table dbo.horizon_changes_00; 
if object_id('dbo.horizon_changes_01', 'U') is not null
drop table dbo.horizon_changes_01; 
if object_id('dbo.horizon_changes_02', 'U') is not null
drop table dbo.horizon_changes_02;
if object_id('dbo.horizon_changes_03', 'U') is not null
drop table dbo.horizon_changes_03;


GO
