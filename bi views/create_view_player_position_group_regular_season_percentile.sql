SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE view [bi].[player_position_group_regular_season_percentile] as
select prsp.*
, concat(player_id, ' | ', season) as player_season_id 
, concat(player_id, ' | ', position_group, ' | ', season) as player_position_group_season_id 
from dbo.player_position_group_regular_season_percentile prsp
GO
