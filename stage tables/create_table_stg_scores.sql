SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [stg].[scores](
	[external_id] [nvarchar](100) NULL,
	[season] [nvarchar](100) NULL,
	[duration] [nvarchar](100) NULL,
	[away_team] [nvarchar](100) NULL,
	[home_team] [nvarchar](100) NULL,
	[away_team_wins] [nvarchar](100) NULL,
	[away_team_losses] [nvarchar](100) NULL,
	[away_q1_points] [nvarchar](100) NULL,
	[away_q2_points] [nvarchar](100) NULL,
	[away_q3_points] [nvarchar](100) NULL,
	[away_q4_points] [nvarchar](100) NULL,
	[away_score] [nvarchar](100) NULL,
	[home_team_wins] [nvarchar](100) NULL,
	[home_team_losses] [nvarchar](100) NULL,
	[home_q1_points] [nvarchar](100) NULL,
	[home_q2_points] [nvarchar](100) NULL,
	[home_q3_points] [nvarchar](100) NULL,
	[home_q4_points] [nvarchar](100) NULL,
	[home_score] [nvarchar](100) NULL,
	[officials] [nvarchar](1000) NULL,
	[times_tied] [nvarchar](100) NULL,
	[lead_changes] [nvarchar](100) NULL,
	[game_date] [nvarchar](100) NULL
) ON [PRIMARY]
GO
