/*
select *
from story.season_block_ranking_wemby a 


select
    player_season = concat(a.player_name, ', ', a.season)
    , a.player_name
    , a.season 
    , a.blocks_per_game
    , b.player_minutes_category
from player_regular_season_rank a 
left join player_regular_season_minutes_bucket b on a.player_id = b.player_id and a.season = b.season 
where 1 = 1 
    and b.player_minutes_category in ('Superstar', 'Star', 'Starter')
order by 
    a.blocks_per_game desc

select 
    pgs.*
from clean.player_game_stats pgs 
left join clean.scores sc on pgs.game_id = sc.external_id
where 1 = 1
    and pgs.season = 2024
    and sc.game_type = 'Regular'
    and pgs.team_name = 'San Antonio Spurs'

select * from team_score where team_name = 'San Antonio Spurs' and season = 2024 and game_type = 'Regular' order by game_date asc
*/




-- select * from scores where season = 2024 and home_team like '%San Antonio%' or away_team like '%San Antonio%' and id = 12275
-- select * from scores where id = 12275

/*
if object_id('temp.season_block_ranking_wemby_03', 'U') is not null
drop table temp.season_block_ranking_wemby_03; 
if object_id('temp.season_block_ranking_wemby_04', 'U') is not null
drop table temp.season_block_ranking_wemby_04;


select 
    game_date = a.actual_game_date
    , cumulative_blocks = sum(pgs.blocks) over(order by sc.actual_game_date rows between unbounded preceding and current row)
    , did_wemby_play = case when pgs.game_id is not null then 1 else 0 end 
    , game_rank_id = row_number() over(order by a.actual_game_date asc)
into temp.season_block_ranking_wemby_03
from (select distinct external_id, actual_game_date from team_score where team_name = 'San Antonio Spurs' and season = 2024) a
left join clean.player_game_stats pgs on 1 = 1 
    and a.external_id = pgs.game_id
    and pgs.team_name = 'San Antonio Spurs'
    and pgs.player_name = 'Victor Wembanyama' 
left join clean.scores sc on a.external_id = sc.external_id
where 1 = 1
    and sc.game_type = 'Regular'


declare @wemby_final_game int = (select max_game_rank_id = max(game_rank_id) from temp.season_block_ranking_wemby_03 where did_wemby_play = 1)
declare @total_blocks int = (select cumulative_blocks from temp.season_block_ranking_wemby_03 where game_rank_id = @wemby_final_game)
declare @blocks_per_game float = cast(@total_blocks as float) / cast( (select count(*) from temp.season_block_ranking_wemby_03 where did_wemby_play = 1) as float)

select a.*
, wemby_play_game_rank_id = row_number() over(partition by case when a.game_rank_id <= @wemby_final_game then 0 else 1 end order by a.game_date asc)
into temp.season_block_ranking_wemby_04
from temp.season_block_ranking_wemby_03 a


select a.*
, projected_cumulative_blocks_if_games_played_100 = 1 * (case when game_rank_id <= @wemby_final_game then null else @total_blocks + @blocks_per_game * wemby_play_game_rank_id end)
, projected_cumulative_blocks_if_games_played_095 = .95 * (case when game_rank_id <= @wemby_final_game then null else @total_blocks + @blocks_per_game * wemby_play_game_rank_id end)
, projected_cumulative_blocks_if_games_played_090 = .9 * (case when game_rank_id <= @wemby_final_game then null else @total_blocks + @blocks_per_game * wemby_play_game_rank_id end)
, projected_cumulative_blocks_if_games_played_085 = .85 * (case when game_rank_id <= @wemby_final_game then null else @total_blocks + @blocks_per_game * wemby_play_game_rank_id end)
, projected_cumulative_blocks_if_games_played_080 = .8 * (case when game_rank_id <= @wemby_final_game then null else @total_blocks + @blocks_per_game * wemby_play_game_rank_id end)
, projected_cumulative_blocks_if_games_played_075 = .75 * (case when game_rank_id <= @wemby_final_game then null else @total_blocks + @blocks_per_game * wemby_play_game_rank_id end)
, projected_cumulative_blocks_if_games_played_070 = .7 * (case when game_rank_id <= @wemby_final_game then null else @total_blocks + @blocks_per_game * wemby_play_game_rank_id end)
from temp.season_block_ranking_wemby_04 a

if object_id('temp.season_block_ranking_wemby_03', 'U') is not null
drop table temp.season_block_ranking_wemby_03;
if object_id('temp.season_block_ranking_wemby_04', 'U') is not null
drop table temp.season_block_ranking_wemby_04;
*/

/*
select * from story.wemby_block_projections
select * from team_score where season = 2024 and team_name = 'San Antonio Spurs'
select * from clean.scores where game_date = '2025-03-30'
select * from clean.player_game_stats where game_id = 15200


-- update dbo.scores set game_date = '2025-03-31' where external_id = 15200

select 
    total_points = sum(points)
    , total_rebounds = sum(rebounds)
    , total_assists = sum(assists)
    , total_blocks = sum(blocks)
from clean.player_game_stats
where season = 2024
*/



/*
if object_id('temp.season_block_ranking_wemby_05', 'U') is not null
drop table temp.season_block_ranking_wemby_05;
if object_id('temp.season_block_ranking_wemby_06', 'U') is not null
drop table temp.season_block_ranking_wemby_06;


select 
    pgs.season
    , points = sum(pgs.points)
    , rebounds = sum(pgs.rebounds)
    , assists = sum(pgs.assists)
    , blocks = sum(pgs.blocks)
into temp.season_block_ranking_wemby_05
from clean.player_game_stats pgs 
left join clean.scores sc on pgs.game_id = sc.external_id
where 1 = 1
    and pgs.season = 2024
    and pgs.game_date <= '2025-02-13'
    and sc.game_type = 'Regular'
    and pgs.team_name = 'San Antonio Spurs'
group by 
    pgs.season


select 
    pgs.player_name 
    , pgs.season
    , pie_points = cast(sum(pgs.points) as float) / cast(max(a.points) as float)
    , pie_rebounds = cast(sum(pgs.rebounds) as float) / cast(max(a.rebounds) as float)
    , pie_assists = cast(sum(pgs.assists) as float) / cast(max(a.assists) as float)
    , pie_blocks = cast(sum(pgs.blocks) as float) / cast(max(a.blocks) as float)
into temp.season_block_ranking_wemby_06
from clean.player_game_stats pgs 
left join clean.scores sc on pgs.game_id = sc.external_id
left join temp.season_block_ranking_wemby_05 a on 1 = 1 
where 1 = 1
    and pgs.season = 2024
    and pgs.game_date <= '2025-02-13'
    and sc.game_type = 'Regular'
    and pgs.team_name = 'San Antonio Spurs'
    and pgs.player_name = 'Victor Wembanyama'
group by 
    pgs.player_name
    , pgs.season
union all
select 
    a.player_name 
    , a.season 
    , pie_points 
    , pie_rebounds
    , pie_assists
    , pie_blocks
from player_primary_team_season_percentile a 
inner join 
(
    select 'Walker Kessler' as player_name, 2024 as season 
    union select 'Brook Lopez', 2024 
    union select 'Daniel Gafford', 2024
    union select 'Hassan Whiteside', 2015
    union select 'Myles Turner', 2024
    union select 'Jaren Jackson Jr.', 2022
    union select 'Victor Wembanyama', 2023
) b on a.player_name = b.player_name and a.season = b.season


select player_name, season, metric_name = 'Points', metric_value = pie_points from temp.season_block_ranking_wemby_06
union all select player_name, season, 'Rebounds', pie_rebounds from temp.season_block_ranking_wemby_06
union all select player_name, season, 'Assists', pie_assists from temp.season_block_ranking_wemby_06
union all select player_name, season, 'Blocks', pie_blocks from temp.season_block_ranking_wemby_06 

*/
/*
select 
    game_date = a.actual_game_date
    , cumulative_blocks = sum(pgs.blocks) over(order by sc.actual_game_date rows between unbounded preceding and current row)
    , did_wemby_play = case when pgs.game_id is not null then 1 else 0 end 
    , game_rank_id = row_number() over(order by a.actual_game_date asc)
-- into temp.season_block_ranking_wemby_03
from (select distinct external_id, actual_game_date from team_score where team_name = 'San Antonio Spurs' and season = 2024) a
left join clean.player_game_stats pgs on 1 = 1 
    and a.external_id = pgs.game_id
    and pgs.team_name = 'San Antonio Spurs'
    and pgs.player_name = 'Victor Wembanyama' 
left join clean.scores sc on a.external_id = sc.external_id
where 1 = 1
    and sc.game_type = 'Regular'
*/

select 
game_date 
, lift 
, blocks
from clean.player_game_stats
where player_name = 'Victor Wembanyama'
order by game_date desc
