SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


create procedure [trf].[transfer_scores] as

-- insert into staging table
insert into [NBA].[dbo].[scores]
select 
    sysdatetime()
    , external_id = try_convert(int, external_id)
    , season = try_convert(int, season)
    , duration
    , away_team
    , home_team
    , away_team_wins = try_convert(tinyint, away_team_wins)
    , away_team_losses = try_convert(tinyint, away_team_losses)
    , away_q1_points = try_convert(tinyint, away_q1_points)
    , away_q2_points = try_convert(tinyint, away_q2_points)
    , away_q3_points = try_convert(tinyint, away_q3_points)
    , away_q4_points = try_convert(tinyint, away_q4_points)
    , away_score = try_convert(smallint, away_score)
    , home_team_wins = try_convert(tinyint, home_team_wins)
    , home_team_losses = try_convert(tinyint, home_team_losses)
    , home_q1_points = try_convert(tinyint, home_q1_points)
    , home_q2_points = try_convert(tinyint, home_q2_points)
    , home_q3_points = try_convert(tinyint, home_q3_points)
    , home_q4_points = try_convert(tinyint, home_q4_points)
    , home_score = try_convert(smallint, home_score)
    , officials
    , times_tied = try_convert(tinyint, times_tied)
    , lead_changes = try_convert(tinyint, lead_changes)
    , game_date = try_convert(date, game_date)
from 
    [NBA].[STG].[scores]


-- delete from staging table
delete from [NBA].[STG].[scores]
GO
