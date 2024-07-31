SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[create_regular_season_min_max_player_position_group_stats] as


-- drop table if exists
if object_id('dbo.regular_season_min_max_player_position_group_stats', 'U') is not null
drop table dbo.regular_season_min_max_player_position_group_stats; 


-- insert into table
with t00 as
(
select 
    [season]
    , [position_group]
	-- min
	,min([minutes]                                      ) as min_minutes
    ,min([points]                                       ) as min_points
    ,min([field_goals_made]                             ) as min_field_goals_made
    ,min([field_goals_attempted]                        ) as min_field_goals_attempted
    ,min([free_throws_made]                             ) as min_free_throws_made
    ,min([free_throws_attempted]                        ) as min_free_throws_attempted
    ,min([three_pointers_made]                          ) as min_three_pointers_made
    ,min([three_pointers_attempted]                     ) as min_three_pointers_attempted
    ,min([offensive_rebounds]                           ) as min_offensive_rebounds
    ,min([defensive_rebounds]                           ) as min_defensive_rebounds
    ,min([assists]                                      ) as min_assists
    ,min([personal_fouls]                               ) as min_personal_fouls
    ,min([turnovers]                                    ) as min_turnovers
    ,min([blocks]                                       ) as min_blocks
    ,min([plus_minus]                                   ) as min_plus_minus
    ,min([rebounds]                                     ) as min_rebounds
    ,min([pra]                                          ) as min_pra
    ,min([astocs]                                       ) as min_astocs
    ,min([minutes_rank]                                 ) as min_minutes_rank
    ,min([points_rank]                                  ) as min_points_rank
    ,min([field_goals_made_rank]                        ) as min_field_goals_made_rank
    ,min([field_goals_attempted_rank]                   ) as min_field_goals_attempted_rank
    ,min([free_throws_made_rank]                        ) as min_free_throws_made_rank
    ,min([free_throws_attempted_rank]                   ) as min_free_throws_attempted_rank
    ,min([three_pointers_made_rank]                     ) as min_three_pointers_made_rank
    ,min([three_pointers_attempted_rank]                ) as min_three_pointers_attempted_rank
    ,min([offensive_rebounds_rank]                      ) as min_offensive_rebounds_rank
    ,min([defensive_rebounds_rank]                      ) as min_defensive_rebounds_rank
    ,min([assists_rank]                                 ) as min_assists_rank
    ,min([personal_fouls_rank]                          ) as min_personal_fouls_rank
    ,min([turnovers_rank]                               ) as min_turnovers_rank
    ,min([blocks_rank]                                  ) as min_blocks_rank
    ,min([plus_minus_rank]                              ) as min_plus_minus_rank
    ,min([rebounds_rank]                                ) as min_rebounds_rank
    ,min([pra_rank]                                     ) as min_pra_rank
    ,min([astocs_rank]									) as min_astocs_rank
	-- max
	,max([minutes]									    ) as max_minutes
    ,max([points]                                       ) as max_points
    ,max([field_goals_made]                             ) as max_field_goals_made
    ,max([field_goals_attempted]                        ) as max_field_goals_attempted
    ,max([free_throws_made]                             ) as max_free_throws_made
    ,max([free_throws_attempted]                        ) as max_free_throws_attempted
    ,max([three_pointers_made]                          ) as max_three_pointers_made
    ,max([three_pointers_attempted]                     ) as max_three_pointers_attempted
    ,max([offensive_rebounds]                           ) as max_offensive_rebounds
    ,max([defensive_rebounds]                           ) as max_defensive_rebounds
    ,max([assists]                                      ) as max_assists
    ,max([personal_fouls]                               ) as max_personal_fouls
    ,max([turnovers]                                    ) as max_turnovers
    ,max([blocks]                                       ) as max_blocks
    ,max([plus_minus]                                   ) as max_plus_minus
    ,max([rebounds]                                     ) as max_rebounds
    ,max([pra]                                          ) as max_pra
    ,max([astocs]                                       ) as max_astocs
    ,max([minutes_rank]                                 ) as max_minutes_rank
    ,max([points_rank]                                  ) as max_points_rank
    ,max([field_goals_made_rank]                        ) as max_field_goals_made_rank
    ,max([field_goals_attempted_rank]                   ) as max_field_goals_attempted_rank
    ,max([free_throws_made_rank]                        ) as max_free_throws_made_rank
    ,max([free_throws_attempted_rank]                   ) as max_free_throws_attempted_rank
    ,max([three_pointers_made_rank]                     ) as max_three_pointers_made_rank
    ,max([three_pointers_attempted_rank]                ) as max_three_pointers_attempted_rank
    ,max([offensive_rebounds_rank]                      ) as max_offensive_rebounds_rank
    ,max([defensive_rebounds_rank]                      ) as max_defensive_rebounds_rank
    ,max([assists_rank]                                 ) as max_assists_rank
    ,max([personal_fouls_rank]                          ) as max_personal_fouls_rank
    ,max([turnovers_rank]                               ) as max_turnovers_rank
    ,max([blocks_rank]                                  ) as max_blocks_rank
    ,max([plus_minus_rank]                              ) as max_plus_minus_rank
    ,max([rebounds_rank]                                ) as max_rebounds_rank
    ,max([pra_rank]                                     ) as max_pra_rank
    ,max([astocs_rank]									) as max_astocs_rank
from 
	[dbo].[player_position_group_regular_season_rank]
group by
	[season]
    , [position_group]
)
select 
t00.*
,case when min_minutes								=       max_minutes								then 1 else 0 end as are_min_and_max_equal_minutes							
,case when min_points                               =       max_points                              then 1 else 0 end as are_min_and_max_equal_points                          
,case when min_field_goals_made                     =       max_field_goals_made                    then 1 else 0 end as are_min_and_max_equal_field_goals_made                
,case when min_field_goals_attempted                =       max_field_goals_attempted               then 1 else 0 end as are_min_and_max_equal_field_goals_attempted           
,case when min_free_throws_made                     =       max_free_throws_made                    then 1 else 0 end as are_min_and_max_equal_free_throws_made                
,case when min_free_throws_attempted                =       max_free_throws_attempted               then 1 else 0 end as are_min_and_max_equal_free_throws_attempted           
,case when min_three_pointers_made                  =       max_three_pointers_made                 then 1 else 0 end as are_min_and_max_equal_three_pointers_made             
,case when min_three_pointers_attempted             =       max_three_pointers_attempted            then 1 else 0 end as are_min_and_max_equal_three_pointers_attempted        
,case when min_offensive_rebounds                   =       max_offensive_rebounds                  then 1 else 0 end as are_min_and_max_equal_offensive_rebounds              
,case when min_defensive_rebounds                   =       max_defensive_rebounds                  then 1 else 0 end as are_min_and_max_equal_defensive_rebounds              
,case when min_assists                              =       max_assists                             then 1 else 0 end as are_min_and_max_equal_assists                         
,case when min_personal_fouls                       =       max_personal_fouls                      then 1 else 0 end as are_min_and_max_equal_personal_fouls                  
,case when min_turnovers                            =       max_turnovers                           then 1 else 0 end as are_min_and_max_equal_turnovers                       
,case when min_blocks                               =       max_blocks                              then 1 else 0 end as are_min_and_max_equal_blocks                          
,case when min_plus_minus                           =       max_plus_minus                          then 1 else 0 end as are_min_and_max_equal_plus_minus                      
,case when min_rebounds                             =       max_rebounds                            then 1 else 0 end as are_min_and_max_equal_rebounds                        
,case when min_pra                                  =       max_pra                                 then 1 else 0 end as are_min_and_max_equal_pra                             
,case when min_astocs                               =       max_astocs                              then 1 else 0 end as are_min_and_max_equal_astocs                          
,case when min_minutes_rank                         =       max_minutes_rank                        then 1 else 0 end as are_min_and_max_equal_minutes_rank                    
,case when min_points_rank                          =       max_points_rank                         then 1 else 0 end as are_min_and_max_equal_points_rank                     
,case when min_field_goals_made_rank                =       max_field_goals_made_rank               then 1 else 0 end as are_min_and_max_equal_field_goals_made_rank           
,case when min_field_goals_attempted_rank           =       max_field_goals_attempted_rank          then 1 else 0 end as are_min_and_max_equal_field_goals_attempted_rank      
,case when min_free_throws_made_rank                =       max_free_throws_made_rank               then 1 else 0 end as are_min_and_max_equal_free_throws_made_rank           
,case when min_free_throws_attempted_rank           =       max_free_throws_attempted_rank          then 1 else 0 end as are_min_and_max_equal_free_throws_attempted_rank      
,case when min_three_pointers_made_rank             =       max_three_pointers_made_rank            then 1 else 0 end as are_min_and_max_equal_three_pointers_made_rank        
,case when min_three_pointers_attempted_rank        =       max_three_pointers_attempted_rank       then 1 else 0 end as are_min_and_max_equal_three_pointers_attempted_rank   
,case when min_offensive_rebounds_rank              =       max_offensive_rebounds_rank             then 1 else 0 end as are_min_and_max_equal_offensive_rebounds_rank         
,case when min_defensive_rebounds_rank              =       max_defensive_rebounds_rank             then 1 else 0 end as are_min_and_max_equal_defensive_rebounds_rank         
,case when min_assists_rank                         =       max_assists_rank                        then 1 else 0 end as are_min_and_max_equal_assists_rank                    
,case when min_personal_fouls_rank                  =       max_personal_fouls_rank                 then 1 else 0 end as are_min_and_max_equal_personal_fouls_rank             
,case when min_turnovers_rank                       =       max_turnovers_rank                      then 1 else 0 end as are_min_and_max_equal_turnovers_rank                  
,case when min_blocks_rank                          =       max_blocks_rank                         then 1 else 0 end as are_min_and_max_equal_blocks_rank                     
,case when min_plus_minus_rank                      =       max_plus_minus_rank                     then 1 else 0 end as are_min_and_max_equal_plus_minus_rank                 
,case when min_rebounds_rank                        =       max_rebounds_rank                       then 1 else 0 end as are_min_and_max_equal_rebounds_rank                   
,case when min_pra_rank                             =       max_pra_rank                            then 1 else 0 end as are_min_and_max_equal_pra_rank                        
,case when min_astocs_rank                          =		max_astocs_rank                         then 1 else 0 end as are_min_and_max_equal_astocs_rank                     
into dbo.regular_season_min_max_player_position_group_stats
from t00
GO
