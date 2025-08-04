create view llm.top_mantrap_player_by_team_season as
select 
player = a.player_name
, a.season
, team = a.primary_team_name
, a.mantrap
, volume = a.position_percent_pra 
, efficacy = a.pat_category_percentile
from [dbo].[player_regular_season_trap_metrics] a
inner join (select season, primary_team_name, max(mantrap) as max_mantrap from [dbo].[player_regular_season_trap_metrics] group by season, primary_team_name) b on 1 = 1 
    and a.season = b.season 
    and a.primary_team_name = b.primary_team_name
    and a.mantrap = b.max_mantrap
