SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


create procedure [dbo].[create_team_regular_season] as


-- drop table if exists
if object_id('dbo.team_regular_season', 'U') is not null
drop table dbo.team_regular_season; 


-- insert into table
select 
    a.team_name
    , a.season
    , points_scored = sum(a.points_scored) 
    , points_allowed = sum(a.points_allowed) 
    , plus_minus = sum(a.points_scored) - sum(a.points_allowed) 
    , wins = sum(a.did_team_win)
    , losses = count(*) - sum(a.did_team_win)
    , games = count(distinct a.external_id)
    , minutes = sum(48 + case when a.was_there_overtime = 1 then 5 else 0 end)
into dbo.team_regular_season
from 
    dbo.team_score a
left join dbo.team b 
    on a.team_name = b.name
where 1 = 1
    and a.game_type = 'Regular'
    and b.is_nba_team = 1
group by 
    a.team_name
    , a.season

GO
