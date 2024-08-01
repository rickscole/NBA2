SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[create_team] as

-- drop table if exists
if object_id('dbo.team', 'U') is not null
drop table dbo.team; 


-- insert into table
select
distinct
id = a.[team_id]
, name = a.team_name
, is_active = 
    case
		when a.team_name in	
			(
				'Atlanta Hawks'
				, 'Boston Celtics'
				, 'Brooklyn Nets'
				, 'Charlotte Hornets'
				, 'Chicago Bulls'
				, 'Cleveland Cavaliers'
				, 'Dallas Mavericks'
				, 'Denver Nuggets'
				, 'Detroit Pistons'
				, 'Golden State Warriors'
				, 'Houston Rockets'
				, 'Indiana Pacers'
				, 'LA Clippers'
				, 'Los Angeles Lakers'
				, 'Memphis Grizzlies'
				, 'Miami Heat'
				, 'Milwaukee Bucks'
				, 'Minnesota Timberwolves'
				, 'New Orleans Pelicans'
				, 'New York Knicks'
				, 'Oklahoma City Thunder'
				, 'Orlando Magic'
				, 'Philadelphia 76ers'
				, 'Phoenix Suns'
				, 'Portland Trail Blazers'
				, 'Sacramento Kings'
				, 'San Antonio Spurs'
				, 'Toronto Raptors'
				, 'Utah Jazz'
				, 'Washington Wizards'
			)
		then 1
		else 0
	end
, is_nba_team = 
	case
		when a.team_name in	
			(
				'Atlanta Hawks'
				, 'Boston Celtics'
				, 'Brooklyn Nets'
				, 'Charlotte Hornets'
				, 'Chicago Bulls'
				, 'Cleveland Cavaliers'
				, 'Dallas Mavericks'
				, 'Denver Nuggets'
				, 'Detroit Pistons'
				, 'Golden State Warriors'
				, 'Houston Rockets'
				, 'Indiana Pacers'
				, 'LA Clippers'
				, 'Los Angeles Lakers'
				, 'Memphis Grizzlies'
				, 'Miami Heat'
				, 'Milwaukee Bucks'
				, 'Minnesota Timberwolves'
				, 'New Orleans Pelicans'
				, 'New York Knicks'
				, 'Oklahoma City Thunder'
				, 'Orlando Magic'
				, 'Philadelphia 76ers'
				, 'Phoenix Suns'
				, 'Portland Trail Blazers'
				, 'Sacramento Kings'
				, 'San Antonio Spurs'
				, 'Toronto Raptors'
				, 'Utah Jazz'
				, 'Washington Wizards'
			)
		then 1
		else 0
	end
into dbo.team
from clean.player_game_stats a


-- delete duplicates
;
with cte as 
(
  select 
  id
  , row_number() over(partition by id order by name) AS [rn]
  from dbo.team
)
delete cte where [rn] > 1


-- enforce primary key
-- add composite key to table
alter table dbo.team alter column id integer not null
alter table dbo.team add primary key(id);

GO
