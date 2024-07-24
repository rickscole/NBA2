SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE procedure [dbo].[clean_player_game_stats] as

-- drop table if exists
if object_id('clean.player_game_stats', 'U') is not null
drop table clean.player_game_stats; 


-- transfer to dbo to clean
select
    [player_id]
    ,[game_id]
    ,[first_name]
    ,[last_name]
    ,[team_id]
    ,[team_name]
    ,[points]
    ,[position]
    ,[minutes]
    ,[field_goals_made]
    ,[field_goals_attempted]
    ,[free_throws_made]
    ,[free_throws_attempted]
    ,[three_pointers_made]
    ,[three_pointers_attempted]
    ,[offensive_rebounds]
    ,[defensive_rebounds]
    ,[assists]
    ,[personal_fouls]
    ,[turnovers]
    ,[blocks]
    ,[plus_minus]
    ,[comment]
    ,[season]
    , rebounds = coalesce(offensive_rebounds, 0) + coalesce(defensive_rebounds, 0)
    , pra = coalesce([points], 0) + coalesce(offensive_rebounds, 0) + coalesce(defensive_rebounds, 0) + coalesce([assists], 0)
    , astocs = coalesce([assists], 0) + coalesce([turnovers], 0) + coalesce([blocks], 0)
    , player_name = concat([first_name], ' ', [last_name])
into clean.player_game_stats
from [dbo].[player_game_stats]
where 1 = 1
    and [player_id] is not null
    and [game_id] is not null


-- delete duplicates
;
with cte as 
(
  select 
  [player_id]
  ,[first_name]
  ,[last_name]
  ,[team_id]
  ,[team_name]
  ,[game_id]
  , row_number() over(partition by [player_id],[first_name],[last_name],[team_id],[team_name],[game_id] order by [player_id]) AS [rn]
  from clean.player_game_stats
)
delete cte where [rn] > 1


-- add composite key to table
alter table clean.player_game_stats alter column player_id integer not null
alter table clean.player_game_stats alter column game_id integer not null
alter table clean.player_game_stats add primary key(player_id, game_id);

GO
