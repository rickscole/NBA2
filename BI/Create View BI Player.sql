SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE view [bi].[player] as 
select 
    distinct 
    pgs.player_id
    , player_name = coalesce(a.player_name, pgs.player_name) 
from 
    clean.player_game_stats pgs
left join 
(
    select 732 as id, 'OG Anunoby' as player_name
)
a 
on pgs.player_id = a.id
where 1 = 1
    and pgs.player_id is not null
GO
