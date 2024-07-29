SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


create view [bi].[season] as
select 
    id = row_number() over(order by pgs.season asc)
    , pgs.season
from 
    player_game_stats pgs
group by 
    pgs.season
GO
