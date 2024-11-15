SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE procedure [trf].[transfer_player_game_predictions_stars_and_superstars_past_two_seasons] as 


-- drop table if exists
if object_id('dbo.player_game_predictions_stars_and_superstars_past_two_seasons', 'U') is not null
drop table dbo.player_game_predictions_stars_and_superstars_past_two_seasons;


-- recreate table
select
    ts = sysdatetime()
    , player_id = try_convert(int, player_id)
    , game_id = try_convert(int, game_id)
    , actual = case when train_test_or_future is null then null else try_convert(float, actual) end
    , predicted = try_convert(float, predicted)
    , train_test_or_future
    , prediction_type
into player_game_predictions_stars_and_superstars_past_two_seasons 
from stg.player_game_predictions_stars_and_superstars_past_two_seasons


-- delete from stg table
delete from mbti.stg.player_game_predictions_stars_and_superstars_past_two_seasons
GO
