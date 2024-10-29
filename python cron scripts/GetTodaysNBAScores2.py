## NOTES:
## error dates:

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
connection = pyodbc.connect('Driver={ODBC Driver 17 for SQL Server};TURNMUSICOFF')
cursor = connection.cursor()


## temp vars
today = datetime.today()
yesterday = today - timedelta(days=1)
dates = [str(yesterday.strftime('%Y-%m-%d'))]

for date in dates:
    
    ## throttle limits is 10 calls per minutes, so sleep with some cushion
    time.sleep(8)
    
    ## connect to api
    ## altered for security puroses
    conn = http.client.HTTPSConnection("api-nba-v1.p.rapidapi.com")
    headers = {
        'X-RapidAPI-Host': "api-nba-v1.p.rapidapi.com",
        'X-RapidAPI-Key': "TURNMUSICOFF"
        }
    
    conn.request("GET", "/games?date=" + date, headers=headers)
    res = conn.getresponse()
    data = res.read()
    
    
    ## lists
    list_game_date = []
    list_external_id = []
    list_season = []
    list_duration = []
    list_away_team = []
    list_home_team = []
    list_wins_visitor = []
    list_losses_visitor = []
    list_q1_visitor = []
    list_q2_visitor = []
    list_q3_visitor = []
    list_q4_visitor = []
    list_score_visitor = []
    list_wins_home = []
    list_losses_home = []
    list_q1_home = []
    list_q2_home = []
    list_q3_home = []
    list_q4_home = []
    list_score_home = []
    list_officials = []
    list_times_tied = []
    list_lead_changes = []
    
    
    ## the data
    my_json = data.decode('utf8').replace("'", '"')
    my_json = my_json.replace('Sha"Rae Mitchell','ShaRae Mitchell')
    my_json = my_json.replace('Pat O"Connell','Pat OConnell')
    # my_json = 'r"""' + data.decode('utf8').replace("'", '"') + '"""'
    # my_json = ('r"""' + data.decode('utf8') + '"""').replace("'", '"')
    a = json.loads(my_json)
    
    
    ## loop through games in a day
    for game in a['response']:

        ## get values
        external_id = game['id']
        season = game['season']
        duration = game['date']['duration']
        away_team = game['teams']['visitors']['name']
        home_team = game['teams']['home']['name']
        wins_visitor = game['scores']['visitors']['win']
        losses_visitor = game['scores']['visitors']['loss']
        q1_visitor = game['scores']['visitors']['linescore'][0]
        q2_visitor = game['scores']['visitors']['linescore'][1]
        q3_visitor = game['scores']['visitors']['linescore'][2]
        q4_visitor = game['scores']['visitors']['linescore'][3]
        score_visitor = game['scores']['visitors']['points']
        wins_home = game['scores']['home']['win']
        losses_home = game['scores']['home']['loss']
        q1_home = game['scores']['home']['linescore'][0]
        q2_home = game['scores']['home']['linescore'][1]
        q3_home = game['scores']['home']['linescore'][2]
        q4_home = game['scores']['home']['linescore'][3]
        score_home = game['scores']['home']['points']
        officials = ",".join(game['officials'])
        times_tied = game['timesTied']
        lead_changes = game['leadChanges']
    
        ## append to list
        list_game_date.append(str(date))
        list_external_id.append(str(external_id))
        list_season.append(str(season      ))
        list_duration.append(str(duration    ))
        list_away_team.append(str(away_team   ))
        list_home_team.append(str(home_team   ))
        list_wins_visitor.append(str(wins_visitor))
        list_losses_visitor.append(str(losses_visitor))
        list_q1_visitor.append(str(q1_visitor  ))
        list_q2_visitor.append(str(q2_visitor  ))
        list_q3_visitor.append(str(q3_visitor  ))
        list_q4_visitor.append(str(q4_visitor  ))
        list_score_visitor.append(str(score_visitor))
        list_wins_home.append(str(wins_home   ))
        list_losses_home.append(str(losses_home ))
        list_q1_home.append(str(q1_home     ))
        list_q2_home.append(str(q2_home     ))
        list_q3_home.append(str(q3_home     ))
        list_q4_home.append(str(q4_home     ))
        list_score_home.append(str(score_home))
        list_officials.append(str(officials   ))
        list_times_tied.append(str(times_tied  ))
        list_lead_changes.append(str(lead_changes))
    
    
    ## create dataframe
    GameData_DF = DataFrame({
        'game_date' : list_game_date
        ,'external_id' : list_external_id
        , 'season' : list_season
        , 'duration' : list_duration
        , 'away_team' : list_away_team
        , 'home_team' :  list_home_team
        , 'away_team_wins' : list_wins_visitor
        , 'away_team_losses' : list_losses_visitor
        , 'away_q1_points' : list_q1_visitor
        , 'away_q2_points' : list_q2_visitor
        , 'away_q3_points' : list_q3_visitor
        , 'away_q4_points' : list_q4_visitor
        , 'away_score' : list_score_visitor
        , 'home_team_wins' : list_wins_home
        , 'home_team_losses' : list_losses_home
        , 'home_q1_points' : list_q1_home
        , 'home_q2_points' : list_q2_home
        , 'home_q3_points' : list_q3_home
        , 'home_q4_points' : list_q4_home
        , 'home_score' : list_score_home
        , 'officials' : list_officials
        , 'times_tied' : list_times_tied
        , 'lead_changes' : list_lead_changes
        })
    
    
    ## transfer into temp table
    for index, row in GameData_DF.iterrows():
        cursor.execute("""
                       INSERT INTO [MBTI].[STG].[scores]
                           (
                               [game_date]
                               ,[external_id]
                               ,[season]
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
                               ) 
                        values (?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)
                        """
                        ,row['game_date']
                        ,row['external_id']
                        ,row['season']
                        ,row['duration']
                        ,row['away_team']
                        ,row['home_team']
                        ,row['away_team_wins']
                        ,row['away_team_losses']
                        ,row['away_q1_points']
                        ,row['away_q2_points']
                        ,row['away_q3_points']
                        ,row['away_q4_points']
                        ,row['away_score']
                        ,row['home_team_wins']
                        ,row['home_team_losses']
                        ,row['home_q1_points']
                        ,row['home_q2_points']
                        ,row['home_q3_points']
                        ,row['home_q4_points']
                        ,row['home_score']
                        ,row['officials']
                        ,row['times_tied']
                        ,row['lead_changes']
                        )
        connection.commit()
    
    
    ## transfer from stg to actual
    SQL = "{call [MBTI].[trf].[transfer_scores]}"
    cursor.execute(SQL)
    connection.commit()

    print(date)


## close connection
cursor.close();
connection.close();
        
