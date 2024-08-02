-- select top 100 * from clean.player_game_stats

select 
a.player_id
, a.first_name
, a.last_name
, a.season
, plus_minus = sum(a.plus_minus)
, team_plus_minus = sum(a.team_plus_minus)
, minutes = sum(a.[minutes])
, plus_minus_per_minute = case when sum(a.[minutes]) = 0 then null else sum(a.plus_minus) / sum(a.[minutes]) end
, team_plus_minus_per_minute = case when sum(a.[game_length]) = 0 then null else sum(a.team_plus_minus) / sum(a.game_length) end
, pat = case when sum(a.[minutes]) = 0 or sum(a.team_plus_minus) = 0 then null else sum(a.plus_minus) / sum(a.[minutes]) - sum(a.team_plus_minus) / sum(a.game_length) end
from
(
select 
    a.player_id
    , a.game_id
    , a.first_name
    , a.last_name
    , a.team_id
    , a.team_name
    , a.season
    , plus_minus = cast(a.plus_minus as float)
    , team_plus_minus = cast((b.points_scored - b.points_allowed) as float)
    , minutes = cast(a.[minutes] as float)
    , game_length = cast(48 + case when was_there_overtime = 1 then 5 else 0 end as float)
from 
    clean.player_game_stats a 
left join team_score b 
    on 1 = 1
    and a.game_id = b.external_id
    and a.team_name = b.team_name
where 1 = 1
    -- and a.season = 2023
    and a.player_name = 'Stephen Curry'
)
a
group by 
    a.player_id
    , a.first_name
    , a.last_name
    , a.season
order by 
    a.season asc 
