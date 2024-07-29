SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE view [bi].[game_season] as 
select external_id, season, game_type from clean.scores
GO
