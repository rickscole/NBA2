SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[scores](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[ts] [datetime2](7) NULL,
	[external_id] [int] NULL,
	[season] [int] NULL,
	[duration] [nvarchar](10) NULL,
	[away_team] [nvarchar](100) NULL,
	[home_team] [nvarchar](100) NULL,
	[away_team_wins] [tinyint] NULL,
	[away_team_losses] [tinyint] NULL,
	[away_q1_points] [tinyint] NULL,
	[away_q2_points] [tinyint] NULL,
	[away_q3_points] [tinyint] NULL,
	[away_q4_points] [tinyint] NULL,
	[away_score] [smallint] NULL,
	[home_team_wins] [tinyint] NULL,
	[home_team_losses] [tinyint] NULL,
	[home_q1_points] [tinyint] NULL,
	[home_q2_points] [tinyint] NULL,
	[home_q3_points] [tinyint] NULL,
	[home_q4_points] [tinyint] NULL,
	[home_score] [smallint] NULL,
	[officials] [nvarchar](1000) NULL,
	[times_tied] [tinyint] NULL,
	[lead_changes] [tinyint] NULL,
	[game_date] [date] NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[scores] ADD PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
