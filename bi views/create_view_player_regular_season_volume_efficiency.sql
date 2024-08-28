SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE view [bi].[player_regular_season_volume_efficiency] as
select
    a.player_id
    , a.player_name
    , a.season
    , player_season_id = concat(a.player_id, ' | ', a.season)
    , a.percent_pat
    , percent_average_points_rebounds_assists = (coalesce(b.[percent_points], 0) + coalesce(b.[percent_rebounds], 0) + coalesce(b.[percent_assists], 0))/3
    , volume_and_efficiency_addition = (a.percent_pat + (coalesce(b.[percent_points], 0) + coalesce(b.[percent_rebounds], 0) + coalesce(b.[percent_assists], 0))/3)/(2)
    , volume_and_efficiency_addition_order_mechanism = (a.percent_pat + (coalesce(b.[percent_points], 0) + coalesce(b.[percent_rebounds], 0) + coalesce(b.[percent_assists], 0))/3)/(2*1000)
    , volume_and_efficiency_multiply = a.percent_pat * (coalesce(b.[percent_points], 0) + coalesce(b.[percent_rebounds], 0) + coalesce(b.[percent_assists], 0))/3
from dbo.player_regular_season_pat_percentile a
inner join player_position_group_regular_season_percentile b 
    on 1 = 1
    and a.player_id = b.player_id
    and a.season = b.season
GO
