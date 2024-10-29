
## import libraries
import pyodbc
import http.client
import json
import pandas as pd
from pandas import DataFrame
import time
from datetime import datetime
from datetime import timedelta



## create connection to db
## altered for security purposes
connection = pyodbc.connect('Driver={ODBC Driver 17 for SQL Server};''TURNMUSICOFF')
cursor = connection.cursor()


## transfer from stg to actual
SQL = "{call [MBTI].[dbo].[delete_player_game_stats]}"
cursor.execute(SQL)
connection.commit()


## temp vars
seasons = [2024]
team_ids = range(1, 41 + 1)

for team in team_ids:
    for season in seasons:

        print(season)

        ## 202205011938
        time.sleep(8)

        ## get data
        ## altered for security purposes
        conn = http.client.HTTPSConnection("api-nba-v1.p.rapidapi.com")
        headers = {
            'X-RapidAPI-Host': "api-nba-v1.p.rapidapi.com",
            'X-RapidAPI-Key': "TURNMUSICOFF"
            }
        
        conn.request("GET", "/players/statistics?team=" + str(team) + "&season=" + str(season), headers=headers)
        res = conn.getresponse()
        data = res.read()
        my_json = data.decode('utf8').replace("'", '"')
        my_json = my_json.replace('De"Andre','DeAndre')
        my_json = my_json.replace('St.Mary"s','St.Marys')
        my_json = my_json.replace('DeAndre"','DeAndre')
        my_json = my_json.replace('St. Joseph"s','St. Josephs')
        my_json = my_json.replace('Day"Ron','DayRon')
        my_json = my_json.replace('Jae"Sean','JaeSean')
        my_json = my_json.replace('St. Mary"s','St. Marys')
        my_json = my_json.replace('"DeAndre,"','"DeAndre","')
        my_json = my_json.replace('De"Anthony','DeAnthony')
        my_json = my_json.replace('O"Bryant','OBryant')
        my_json = my_json.replace('D"Angelo','DAngelo')
        my_json = my_json.replace('Devonte"','Devonte')
        my_json = my_json.replace('E"Twaun','ETwaun')
        my_json = my_json.replace('"Devonte,"','"Devonte","')
        my_json = my_json.replace('De"Aaron','DeAaron')
        my_json = my_json.replace('Jahmi"us','Jahmius')
        my_json = my_json.replace('St. John"s','St. Johns')
        my_json = my_json.replace('St.John"s','St.Johns')
        my_json = my_json.replace('Sir"Dominic','SirDominic')
        my_json = my_json.replace('Pe"Shon','PeShon')
        my_json = my_json.replace('O"Quinn','OQuinn')
        my_json = my_json.replace('D"Vauntes','DVauntes')
        my_json = my_json.replace('O"Brien','OBrien')
        my_json = my_json.replace('Toure"','Toure')
        my_json = my_json.replace('Amar"e','Amare')
        my_json = my_json.replace('DNP - Coach"s Decision','DNP - Coachs Decision')
        my_json = my_json.replace('NWT - Coach"s Decision','NWT - Coachs Decision')
        my_json = my_json.replace('DND - Coach"s Decision','DND - Coachs Decision')
        my_json = my_json.replace('O"Neale','ONeale')
        my_json = my_json.replace('Tre"Shaun','TreShaun')
        my_json = my_json.replace('D"Moi','Dmoi')
        my_json = my_json.replace('Sir"Jabari','SirJabari')
        my_json = my_json.replace('N"Faly','NFaly')
        my_json = my_json.replace('Saint Mary"s','Saint Marys')
        my_json = my_json.replace('Saint John"s','Saint Johns')
        my_json = my_json.replace('De"Andre','DeAndre')
        my_json = my_json.replace('Ja"Kobe','JaKobe')
        my_json = my_json.replace('Kel"el','Kelel')
        a = json.loads(my_json)


        ## lists
        list_player_id = []
        list_first_name = []
        list_last_name = []
        list_team_id = []
        list_team_name = []
        list_game_id = []
        list_points = []
        list_position = []
        list_minutes = []
        list_field_goals_made = []
        list_field_goals_attempted = []
        list_free_throws_made = []
        list_free_throws_attempted = []
        list_three_pointers_made = []
        list_three_pointers_attempted = []
        list_offensive_rebounds = []
        list_defensive_rebounds = []
        list_assists = []
        list_personal_fouls = []
        list_steals = []
        list_turnovers = []
        list_blocks = []
        list_plus_minus = []
        list_comment = []
        list_season = []


        ## loop through players / games
        for player_game in a['response']:

            ## get fields
            player_id = player_game['player']['id']
            first_name = player_game['player']['firstname']
            last_name = player_game['player']['lastname']
            team_id = player_game['team']['id']
            team_name = player_game['team']['name']
            game_id = player_game['game']['id']
            points = player_game['points']
            position = player_game['pos']
            minutes = player_game['min']
            field_goals_made = player_game['fgm']
            field_goals_attempted = player_game['fga']
            free_throws_made = player_game['ftm']
            free_throws_attempted = player_game['fta']
            three_pointers_made = player_game['tpm']
            three_pointers_attempted = player_game['tpa']
            offensive_rebounds = player_game['offReb']
            defensive_rebounds = player_game['defReb']
            assists = player_game['assists']
            personal_fouls = player_game['pFouls']
            steals = player_game['steals']
            turnovers = player_game['turnovers']
            blocks = player_game['blocks']
            plus_minus = player_game['plusMinus']
            comment = player_game['comment']


            ## append to list
            list_player_id.append(str(player_id))
            list_first_name.append(str(first_name))
            list_last_name.append(str(last_name))
            list_team_id.append(str(team_id))
            list_team_name.append(str(team_name))
            list_game_id.append(str(game_id))
            list_points.append(str(points))
            list_position.append(str(position))
            list_minutes.append(str(minutes))
            list_field_goals_made.append(str(field_goals_made))
            list_field_goals_attempted.append(str(field_goals_attempted))
            list_free_throws_made.append(str(free_throws_made))
            list_free_throws_attempted.append(str(free_throws_attempted))
            list_three_pointers_made.append(str(three_pointers_made))
            list_three_pointers_attempted.append(str(three_pointers_attempted))
            list_offensive_rebounds.append(str(offensive_rebounds))
            list_defensive_rebounds.append(str(defensive_rebounds))
            list_assists.append(str(assists))
            list_personal_fouls.append(str(personal_fouls))
            list_turnovers.append(str(turnovers))
            list_blocks.append(str(blocks))
            list_plus_minus.append(str(plus_minus))
            list_comment.append(str(comment))
            list_season.append(str(season))


        ## create dataframe
        PlayerGameStats_DF = DataFrame({
            'player_id' : list_player_id
            ,'first_name' : list_first_name
            ,'last_name' : list_last_name
            ,'team_id' : list_team_id
            ,'team_name' : list_team_name
            ,'game_id' : list_game_id
            ,'points' : list_points
            ,'position' : list_position
            ,'minutes' : list_minutes
            ,'field_goals_made' : list_field_goals_made
            ,'field_goals_attempted' : list_field_goals_attempted
            ,'free_throws_made' : list_free_throws_made
            ,'free_throws_attempted' : list_free_throws_attempted
            ,'three_pointers_made' : list_three_pointers_made
            ,'three_pointers_attempted' : list_three_pointers_attempted
            ,'offensive_rebounds' : list_offensive_rebounds
            ,'defensive_rebounds' : list_defensive_rebounds
            ,'assists' : list_assists
            ,'personal_fouls' : list_personal_fouls
            ,'turnovers' : list_turnovers
            ,'blocks' : list_blocks
            ,'plus_minus' : list_plus_minus
            ,'comment' : list_comment
            ,'season' : list_season
            })


        ## transfer into temp table
        for index, row in PlayerGameStats_DF.iterrows():
        	cursor.execute("""
                           insert into [MBTI].[STG].[player_game_stats]
                            (
                                [player_id]
                                ,[first_name]
                                ,[last_name]
                                ,[team_id]
                                ,[team_name]
                                ,[game_id]
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
                            )

                            values (?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)
                            """
                            ,row['player_id']
                            ,row['first_name']
                            ,row['last_name']
                            ,row['team_id']
                            ,row['team_name']
                            ,row['game_id']
                            ,row['points']
                            ,row['position']
                            ,row['minutes']
                            ,row['field_goals_made']
                            ,row['field_goals_attempted']
                            ,row['free_throws_made']
                            ,row['free_throws_attempted']
                            ,row['three_pointers_made']
                            ,row['three_pointers_attempted']
                            ,row['offensive_rebounds']
                            ,row['defensive_rebounds']
                            ,row['assists']
                            ,row['personal_fouls']
                            ,row['turnovers']
                            ,row['blocks']
                            ,row['plus_minus']
                            ,row['comment']
                            ,row['season']
                            )


        ## transfer from stg to actual
        SQL = "{call [MBTI].[trf].[transfer_player_game_stats]}"
        cursor.execute(SQL)
        connection.commit()

## close connection
cursor.close();
connection.close();
