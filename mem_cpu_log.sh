#!/bin/bash

# +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
# Diagnostic 5: System Monitoring Script
# Author: Heriberto Mendoza 
#
# Description: This script will take a snapshot of the system processes, memory
# and cpu usage. A timestamped file will be created, and this script will 
# push said file to a repository and then push to the Github repo.

# This script will take a snapshot of the system, create a timestamped file,
# and then push said file to the repository when run. This script can be added to
# the crontab file to run automatically depending on user needs.
#
# Notes:
# 1- This script assumes that the user has created a directory named
# <diagnostic_5>.
# 2- This script assumes that the user has already initiated a repository with
# multiple branches and has pushed the local repository to github.
# 
# +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

# variable that stores current date
now_date=$(date +"%d_%m_%Y_%T");

# var stores absolute filepath of log file
new_log="$HOME/Desktop/diagnostic_5/syslog_$now_date.txt";

#redirect ps info to new file
ps -e -o pid,ppid,uname,pmem,pcpu,comm > $new_log;

#navigate to correct folder
cd $HOME/Desktop/diagnostic_5;

#make sure you are in 2branch
git checkout 2branch;

#add and commit changes
git add $new_log;
git commit -m "mem + cpu usg log update"

# push to github repo
git push origin 2branch;
