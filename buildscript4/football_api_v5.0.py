#######################################################################################
# Build Script 4: Football Table Generator
# Author: Heriberto Mendoza
#
# Description: This Python script is an interactive script built around an API that
# collects statistic and data related to Assocation Football. Once initiated,
# the script will ask for user input (year and league) to generate the table.
# Once parameters have been collected, the modified api request will be sent out.
# The data will be stored as a .json file and then converted (through a bash script)
# to a .csv file and it will be displayed at the end.
#
# Notes:
# 1-Before running this python script, user must ensure that the accompanying
# bash script is in the same directory. The Python script will call on the bash
# script to perform the conversion
# 2-Although the csv file will be printed sorted by league positon at the end, 
# the generated csv file mayb be out of order (acccording to league position).
# 3-This Script requires a rapidapi-key to work.
#
#
#######################################################################################


import requests
import json
import os
import subprocess
import time

intro_message = '''
This program will display the domestic football league table
for a league and season the user selects.
'''
print(intro_message)

time.sleep(2)

# create a dictionary with league:code
avail_leagues = {'bundesliga': 78, 'la liga': 140, 'premier league': 39, 'ligue 1': 61, 'serie a': 135, 'primeira liga': 94, 'eredivisie': 88, 'premiership': 179}

# dict of possible years
avail_szn = {'2010': 2010, '2011': 2011, '2012': 2012, '2013': 2013, '2014': 2014, '2015': 2015, '2016': 2016, '2017': 2017, '2018': 2018, '2019': 2019, '2020': 2020, '2021': 2021, '2022': 2022}

# display available leagues
print("Available Leagues:")
for key in avail_leagues:
    print(key)
usr_lg = input('Please select a league: ').lower()

# Error case for input
while usr_lg not in avail_leagues:
    usr_lg = input('Please select a league: ').lower()

# return code for api request
usr_lg_code = avail_leagues[usr_lg]

time.sleep(2)

# Print available years:
print('Available Seasons:')
for year in avail_szn:
    print(year)

# Select a year
usr_szn = input('Please Select a Season: ')

# Error case for wrong input:
while usr_szn not in avail_szn:
    usr_szn = input('Please Select a Season: ')

# get season from dict (str to int)
usr_szn_code = avail_szn[usr_szn]

print(f'You have chosen to display the {usr_szn} {usr_lg} season table...')
print("...one moment...")


# API REQUEST

# api endpoint
url = "https://api-football-v1.p.rapidapi.com/v3/standings?"

# authentication headers
headers = {
    'x-rapidapi-host': 'api-football-v1.p.rapidapi.com/v3/',
    'x-rapidapi-key': "e190fa2807msh42f035528709dcep102915jsn2fd9747f92cf"
}

# parameters for api request
parameters = {
    "league": usr_lg_code,
    "season": usr_szn_code
}

# request w url, parameters, and headers
response = requests.get(url, params=parameters, headers=headers)

# create json file
with open(f'{usr_szn_code}_{usr_lg}_table.json', 'w') as json_file_table:
    json.dump(response.json(), json_file_table)

json_file_table.close()

filename = f'{usr_szn_code}_{usr_lg}_table'

# run bash script to convert to csv
subprocess.run(["./json_csv_converter.sh", filename])
