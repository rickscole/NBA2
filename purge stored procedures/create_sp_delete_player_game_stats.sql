SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[delete_player_game_stats] as


delete from dbo.player_game_stats
where season = (select max(season) from dbo.scores)


GO
