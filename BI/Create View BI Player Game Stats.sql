SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE view [bi].[player_game_stats] as
select 
    pgs.* 
    , player_season_id = concat(pgs.player_id, ' | ', pgs.season)
from 
    clean.player_game_stats pgs
GO
