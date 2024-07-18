SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [stg].[player_game_stats](
	[player_id] [nvarchar](100) NULL,
	[first_name] [nvarchar](100) NULL,
	[last_name] [nvarchar](100) NULL,
	[team_id] [nvarchar](100) NULL,
	[team_name] [nvarchar](100) NULL,
	[game_id] [nvarchar](100) NULL,
	[points] [nvarchar](100) NULL,
	[position] [nvarchar](100) NULL,
	[minutes] [nvarchar](100) NULL,
	[field_goals_made] [nvarchar](100) NULL,
	[field_goals_attempted] [nvarchar](100) NULL,
	[free_throws_made] [nvarchar](100) NULL,
	[free_throws_attempted] [nvarchar](100) NULL,
	[three_pointers_made] [nvarchar](100) NULL,
	[three_pointers_attempted] [nvarchar](100) NULL,
	[offensive_rebounds] [nvarchar](100) NULL,
	[defensive_rebounds] [nvarchar](100) NULL,
	[assists] [nvarchar](100) NULL,
	[personal_fouls] [nvarchar](100) NULL,
	[turnovers] [nvarchar](100) NULL,
	[blocks] [nvarchar](100) NULL,
	[plus_minus] [nvarchar](100) NULL,
	[comment] [nvarchar](100) NULL,
	[season] [nvarchar](100) NULL
) ON [PRIMARY]
GO
