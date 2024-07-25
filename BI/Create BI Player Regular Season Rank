SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE view [bi].[player_regular_season_rank] as
select prsr.*
, player_season_id = concat(prsr.player_id, ' | ', prsr.season)  
from [dbo].[player_regular_season_rank] prsr
GO
