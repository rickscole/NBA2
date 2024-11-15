SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [stg].[player_game_predictions_stars_and_superstars_past_two_seasons](
	[player_id] [nvarchar](100) NULL,
	[game_id] [nvarchar](100) NULL,
	[actual] [nvarchar](100) NULL,
	[predicted] [nvarchar](100) NULL,
	[train_test_or_future] [nvarchar](100) NULL,
	[prediction_type] [nvarchar](100) NULL
) ON [PRIMARY]
GO
