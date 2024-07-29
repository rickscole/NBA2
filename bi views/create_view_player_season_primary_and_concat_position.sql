SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE view [bi].[player_season_primary_and_concat_position] as 
select 
    pspp.*
    , player_season_id = concat(player_id, ' | ', season) 
from dbo.player_season_primary_and_concat_position pspp
GO
