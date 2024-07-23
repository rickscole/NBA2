SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE view [bi].[player_season] as
select 
    distinct 
    pgs.player_id
    , pgs.season
    , player_season_id = concat(pgs.player_id, ' | ', pgs.season)
from 
    clean.player_game_stats pgs
GO
