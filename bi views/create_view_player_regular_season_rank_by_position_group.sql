SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create view [bi].[player_regular_season_rank_by_position_group] as 
select 
    a.*
from player_regular_season_rank_by_position_group a
GO
