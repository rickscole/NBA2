## import libraries
import pyodbc


## create connection to db
## altered for security purposes
connection = pyodbc.connect('Driver={ODBC Driver 17 for SQL Server};''TURNMUSICOFF;')
cursor = connection.cursor()


## clean scores
SQL = "{call [MBTI].[cln].[clean_scores]}"
cursor.execute(SQL)
connection.commit()


## clean player game stats
SQL = "{call [MBTI].[cln].[clean_player_game_stats]}"
cursor.execute(SQL)
connection.commit()


## close connection
cursor.close();
connection.close();
