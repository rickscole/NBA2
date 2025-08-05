#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created on Mon Aug  4 13:07:28 2025

@author: rcole
"""


import os
import pandas as pd
from openai import OpenAI
from dotenv import load_dotenv
from io import BytesIO
from io import StringIO

# ===========================
# 1) Load Environment Variables
# ===========================
load_dotenv()
OPENAI_API_KEY = os.getenv("OPENAI_API_KEY")
client = OpenAI(api_key=OPENAI_API_KEY)

# Load into pandas DataFrame
df = pd.read_csv(r'/Users/rcole/Desktop/imacgration/abn/chauncey/llm-top_mantrap_player_by_team_season.csv')
df = df.fillna("")

# ===========================
# 3) Build Context for the LLM
# ===========================
context = f"""
You are Chauncey, an AI agent developed by RS Cole.
Named in honor of Chauncey Billups, you have the primary responsibility of answering user questions about the NBA, as informed by the NBA Database compiled by RS Cole.
Specifically, you will answer user questions around the table llm.top_mantrap_player_by_team_season, which gives the name of the player who had the highest MANTRAP for a team in a given season, as well as that MANTRAP value.

Outputs:
Your outputs must be returned as a JSON object with the following fields:
-- summary: A summary sentence that mentions the player name, the team, and the season, as well as volume, efficacy, and MANTRAP.




Guidelines:
SANTRAP and MANTRAP are meant to be singular metrics that evaluate a players volume and efficacy.
Higher SANTRAP and Higher MANTRAP are a good thing. 
Here are some guidelines around the various columns in this table.
-- player: Player
-- season : Season
-- team: Team for that season
-- volume: It has the alias of PNP-PRA, or Position Normalized Percentile PRA. Calculated in the following way:
    1. Find the highest and lowest PRA (Points + Rebounds + Assists) by position group and season in the NBA. (MaxPRA, and MinPRA)
    2. For a players position and season, a players PNP-PRA is (Player PRA - MinPRA) / (MaxPRA - MinPRA).
    3. The best player at a given position in a season with have a value of 1, the worst will have a value of 0.
-- efficacy: It has the alias of MNP-PAT, or Minutes Normalized Percentile, PAT. Calculated in the following way:
    1. Find the highest and lowest PAT (detailed above) by Season and Minutes Category (defined above) (MaxPAT and MinPAT)
    2. For a players position and season, a players MNP-PAT is (Player PAT - MinPAT) / (MaxPAT- MinPAT).
    3. The best player at a given position in a season with have a value of 1, the worst will have a value of 0.
-- mantrap: MANTRAP, or square root (PNP-PRA *  MNP-PAT). PNP-PRA and MNP-PAT are the same as above. So here, effectively, we take a geometric average. (The M is for multiplied, while ANTRAP is just some agglomerated alphabet soup of letters from the other metrics). SANTRAP is a bit more balanced, while MANTRAP penalizes you if you are particularly weak in either Volume or Efficacy.



Context:
-- Your task is answer questions regarding MANTRAP.
-- You are a data assistant that can ONLY answer using the data provided in the CSV. 
-- If you do not know, then answer "I don't know", and make some self-deprecating basketball pun.


SQL-esque examples:
    Question: Which player has had the highest MANTRAP for the Detroit Pistons?
    Answer: Select player_name from table b inner join (select primary_team_name, max(mantrap) as max_mantrap from table group by primary_team_name) a on a.primary_team_name = b.primary_team_name and a.max_mantrap = b.mantrap where a.primary_team_name = 'Detroit Pistons'
    Answer: Andre Drummond, 2018
    
    Question: Which player has had the highest MANTRAP for the Miami Heat?
    Answer: Select player_name from table b inner join (select primary_team_name, max(mantrap) as max_mantrap from table group by primary_team_name) a on a.primary_team_name = b.primary_team_name and a.max_mantrap = b.mantrap where a.primary_team_name = 'Detroit Pistons'
    Answer: Bam Adebayo, 2022
"""

data_context = df.to_csv(index=False)
full_context = context + "\nHere is the NBA data:\n" + data_context


# ===========================
# 4) Ask a Question
# ===========================
#question = "Which player had the highest MANTRAP score in 2023?"
#question = "Which player in what season has had the highest MANTRAP for the Detroit Pistons?"
#question = "Which player had the highest MANTRAP for the Detroit Pistons in 2019?"
#question = "How do you calculate PAT?"
#question = "How do you calculate MANTRAP?"
#question = "Which player had the highest MANTRAP for the Detroit Pistons?"
#question = "Which player had the highest MANTRAP for the Miami Heat?"
#question = "Which player had the highest MANTRAP for the Memphis Grizzlies?"
#question = "Which player had the highest MANTRAP for the Detroit Pistons in 2020?"
#question = "Which player has the highest median MANTRAP?"
#question = "Which player has the second highest median MANTRAP?"
#question = "Which player had the highest MANTRAP for the Detroit Pistons in 2020?"
#question = "What was the highest MANTRAP recorded, and by what player?"
question = "Does Luka Doncic have higher efficacy, or volume?"



response = client.chat.completions.create(
    model="gpt-4o-mini",  # or "gpt-4o" for better accuracy
    messages=[
        {"role": "system", "content": full_context},
        {"role": "user", "content": question}
    ],
    temperature=0.2
)

print("Answer:", response.choices[0].message.content)
