create view bi.player_full_season_rank as
select 
    pfsr.* 
    , player_season_id = concat(pfsr.player_id, ' | ', pfsr.season)
from 
    dbo.player_full_season_rank pfsr
