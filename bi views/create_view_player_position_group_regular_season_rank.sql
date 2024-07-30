SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE view [bi].[player_position_group_regular_season_rank] as
select a.*
, player_season_id = concat(a.player_id, ' | ', a.season)  
from [dbo].[player_position_group_regular_season_rank] a
GO
