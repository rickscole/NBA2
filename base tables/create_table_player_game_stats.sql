SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[player_game_stats](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[ts] [datetime2](7) NULL,
	[player_id] [int] NULL,
	[first_name] [nvarchar](100) NULL,
	[last_name] [nvarchar](100) NULL,
	[team_id] [int] NULL,
	[team_name] [nvarchar](100) NULL,
	[game_id] [int] NULL,
	[points] [smallint] NULL,
	[position] [nvarchar](100) NULL,
	[minutes] [smallint] NULL,
	[field_goals_made] [tinyint] NULL,
	[field_goals_attempted] [tinyint] NULL,
	[free_throws_made] [tinyint] NULL,
	[free_throws_attempted] [tinyint] NULL,
	[three_pointers_made] [tinyint] NULL,
	[three_pointers_attempted] [tinyint] NULL,
	[offensive_rebounds] [tinyint] NULL,
	[defensive_rebounds] [tinyint] NULL,
	[assists] [tinyint] NULL,
	[personal_fouls] [tinyint] NULL,
	[turnovers] [tinyint] NULL,
	[blocks] [tinyint] NULL,
	[plus_minus] [smallint] NULL,
	[comment] [nvarchar](100) NULL,
	[season] [smallint] NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[player_game_stats] ADD PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
