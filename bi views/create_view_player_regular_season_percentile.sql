SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE view [bi].[player_regular_season_percentile] as
select prsp.*
, concat(player_id, ' | ', season) as player_season_id 
from dbo.player_regular_season_percentile prsp
GO
