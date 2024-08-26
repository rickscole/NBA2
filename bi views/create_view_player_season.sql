SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create view [bi].[player_season] as
select 
    distinct 
    pgs.player_id
    , pgs.season
    , player_season_id = concat(pgs.player_id, ' | ', pgs.season)
    , pgs.player_name
    , player_name_season = concat(player_name, ', ', season)
from 
    clean.player_game_stats pgs
GO


