select * from story.game_three_point_percentages_team order by three_pointers_percentage desc
select * from team_score where actual_game_date = '2024-10-26' and team_name = 'Oklahoma City Thunder'
select * from team_score where actual_game_date = '2024-10-28' and team_name = 'Dallas Mavericks'
select * from team_score where actual_game_date = '2025-03-08' and team_name = 'New Orleans Pelicans'
select * from team_score where actual_game_date = '2025-03-19' and team_name = 'New York Knicks'
select * from team_score where actual_game_date = '2025-03-10' and team_name = 'Indiana Pacers'
select * from team_score where actual_game_date = '2025-03-07' and team_name = 'Charlotte Hornets'

/*
update dbo.scores set game_date = '2024-10-28' where external_id = 14154
update dbo.scores set game_date = '2025-04-10' where external_id = 15273
update dbo.scores set game_date = '2025-04-12' where external_id = 15285
update dbo.scores set game_date = '2025-01-06' where external_id = 14604
update dbo.scores set game_date = '2024-10-30' where external_id = 14168
update dbo.scores set game_date = '2025-03-10' where external_id = 15037
update dbo.scores set game_date = '2025-03-21' where external_id = 15124
update dbo.scores set game_date = '2025-03-12' where external_id = 15056
update dbo.scores set game_date = '2025-03-09' where external_id = 15026
exec cln.clean_scores
exec create_team_score
*/
