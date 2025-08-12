SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create view [llm].[top_mantrap_player_by_team_season] as
select 
player = a.player_name
, a.season
, team = a.primary_team_name
, a.mantrap
, volume = a.position_percent_pra 
, efficacy = a.pat_category_percentile
-- ancillary elements to VOLUME calculation
, d.points_per_game
, d.rebounds_per_game
, d.assists_per_game
, d.pra_per_game
, a.pie_pra
-- ancially elements to EFFICACY calculation
, a.plus_minus
, c.plus_minus_per_minute
, c.team_plus_minus_per_minute
, a.pat
from [dbo].[player_regular_season_trap_metrics] a
inner join (select season, primary_team_name, max(mantrap) as max_mantrap from [dbo].[player_regular_season_trap_metrics] group by season, primary_team_name) b on 1 = 1 
    and a.season = b.season 
    and a.primary_team_name = b.primary_team_name
    and a.mantrap = b.max_mantrap
left join [dbo].[player_regular_season_pat_stats] c on 1 = 1
    and a.season = c.season
    and a.player_id = c.player_id
left join [dbo].[player_regular_season_rank] d on 1 = 1 
    and a.season = d.season
    and a.player_id = d.player_id


GO
