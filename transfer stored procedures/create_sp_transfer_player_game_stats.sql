SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


create procedure [trf].[transfer_player_game_stats] as


-- insert into staging table
insert into [MBTI].[dbo].[player_game_stats]
select 
    sysdatetime()
    , [player_id] = try_convert(int,[player_id])
    , [first_name]
    , [last_name]
    , [team_id] = try_convert(int, [team_id])
    , [team_name]
    , [game_id] = try_convert(int,[game_id])
    , [points] = try_convert(smallint,[points])
    , [position]
    , [minutes]
    , [field_goals_made] = try_convert(tinyint,[field_goals_made])
    , [field_goals_attempted] = try_convert(tinyint,[field_goals_attempted])
    , [free_throws_made] = try_convert(tinyint,[free_throws_made])
    , [free_throws_attempted] = try_convert(tinyint,[free_throws_attempted])
    , [three_pointers_made] = try_convert(tinyint,[three_pointers_made])
    , [three_pointers_attempted] = try_convert(tinyint,[three_pointers_attempted])
    , [offensive_rebounds] = try_convert(tinyint,[offensive_rebounds])
    , [defensive_rebounds] = try_convert(tinyint,[defensive_rebounds])
    , [assists] = try_convert(tinyint,[assists])
    , [personal_fouls] = try_convert(tinyint,[personal_fouls])
    , [turnovers] = try_convert(tinyint,[turnovers])
    , [blocks] = try_convert(tinyint,[blocks])
    , [plus_minus] = try_convert(smallint,[plus_minus])
    , [comment]
    , [season] = try_convert(smallint,[season])
from 
    [MBTI].[STG].[player_game_stats]


-- delete from staging table
delete from [MBTI].[STG].[player_game_stats]
GO
