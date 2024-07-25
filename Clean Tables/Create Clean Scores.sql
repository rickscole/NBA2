SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[clean_scores] as


-- drop table if exists
if object_id('clean.scores', 'U') is not null
drop table clean.scores; 


-- transfer to dbo to clean
select
    [external_id]
    ,a.[season]
    ,[duration]
    ,[away_team]
    ,[home_team]
    ,[away_team_wins]
    ,[away_team_losses]
    ,[away_q1_points]
    ,[away_q2_points]
    ,[away_q3_points]
    ,[away_q4_points]
    ,[away_score]
    ,[home_team_wins]
    ,[home_team_losses]
    ,[home_q1_points]
    ,[home_q2_points]
    ,[home_q3_points]
    ,[home_q4_points]
    ,[home_score]
    ,[officials]
    ,[times_tied]
    ,[lead_changes]
    ,[game_date]
    ,[hours] = try_convert(smallint,left([duration],1))
    ,[minutes] = try_convert(smallint,right(duration,2))
    ,[duration_hours] = cast(try_convert(smallint,left([duration],1)) as float) + cast(try_convert(smallint,right(duration,2)) as float) / 60
    ,[duration_minutes] = cast(try_convert(smallint,left([duration],1)) as float) * 60 + cast(try_convert(smallint,right(duration,2)) as float)  
    ,[actual_game_date] = dateadd(day,-1,[game_date])
    ,winning_team = case when home_score > away_score then home_team when home_score < away_score then away_team else null end
    ,winning_team_home_or_away = case when home_score > away_score then 'home' when home_score < away_score then 'away' else null end
    ,did_home_team_win = case when home_score > away_score then 1 when home_score < away_score then 0 else null end
    ,away_half1_points = away_q1_points + away_q2_points
    ,away_half2_points = away_q3_points + away_q4_points
    ,away_overtime_points =  [away_score] - ([away_q1_points] + [away_q2_points] + [away_q3_points] + [away_q4_points])
    ,home_half1_points = home_q1_points + home_q2_points
    ,home_half2_points = home_q3_points + home_q4_points
    ,home_overtime_points =  [home_score] - ([home_q1_points] + [home_q2_points] + [home_q3_points] + [home_q4_points])
    ,total_q1_points = home_q1_points + away_q1_points
    ,total_q2_points = home_q2_points + away_q2_points
    ,total_q3_points = home_q3_points + away_q3_points
    ,total_q4_points = home_q4_points + away_q4_points
    ,total_half1_points = cast(home_q1_points as smallint) + cast(away_q1_points as smallint) + cast(home_q2_points as smallint) + cast(away_q2_points as smallint)
    ,total_half2_points = cast(home_q3_points as smallint) + cast(away_q3_points as smallint) + cast(home_q4_points as smallint) + cast(away_q4_points as smallint)
    ,[total_overtime_points] = cast([home_score] as smallint) + cast([away_score] as smallint) - (cast([away_q1_points] as smallint) + cast([away_q2_points] as smallint) + cast([away_q3_points] as smallint) + cast([away_q4_points] as smallint)+ cast([home_q1_points] as smallint) + cast([home_q2_points] as smallint) + cast([home_q3_points] as smallint) + cast([home_q4_points] as smallint))
into clean.scores
from 
    [dbo].[scores] a
left join dbo.season_type st 
    on 1 = 1
    and dateadd(day,-1,[game_date]) >= st.start_date 
    and dateadd(day,-1,[game_date]) <= st.end_date


-- delete duplicates
;
with cte as 
(
  select 
  [external_id]
  ,[game_date]
  , row_number() over(partition by [external_id] order by [game_date]) AS [rn]
  from clean.scores
)
delete cte where [rn] > 1


-- add composite key to table
alter table clean.scores alter column external_id integer not null
alter table clean.scores add primary key(external_id);



GO
