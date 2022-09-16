#!/bin/bash

###########################################################################################
# This script is part of Build Script 4: Football Table Generator.
# Author: Heriberto Mendoza
# 
# Description: This script will handle the json-csv conversion. At the end, the csv file
# will be printed, sorted and spaced into columns. This script must be in the same
# directory as the main script.
#
###########################################################################################

# user arguments
filename=$1

# This script will extract the appropriate data from a json file and convert it to a .csv

# create a csv file with header:
echo "position,team,points,GD,played,win,draw,lose" > "$filename.csv"

# output specific keys from json file and redirect/append to csv
jq -j '.response[].league.standings[][] | .rank, ",", .team.name, ",", .points, ",", .goalsDiff, ",", .all.played, ",", .all.win, ",", .all.draw, ",", .all.lose, "\n"' "$filename.json" >> "$filename.csv"


# sort and print generated csv file for confirmation
sort -t"," -k1n,1 "$filename.csv" | column -t -s,

