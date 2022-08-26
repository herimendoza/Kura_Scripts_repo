#!/bin/bash

# Script to automatically update system #
# ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
# DIAGNOSTIC 1: AUTOMATIC SYSTEM UPDATE SCRIPT
# Author: Heriberto Mendoza
# Description: This script will update the system repository. Then it will
# prompt the user if they want to proceed with the system upgrade. If so,
# the system upgrade will proceed. The user will need to be superuser to
# run this script.
#
# ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

# you need to be superuser to run this:
if [[ $UID != 0 ]];
    then
    echo "You need to be superuser";
    exit 1;

fi

# update the repos the apt command is aware of
while [[ $UID = 0 ]];
    do
        apt -y update;
        break;
done

# prompt if user wants to proceed
read -p "You are about to upgrade. Would you like to proceed? " ans;

ans2=$(echo $ans | cut -c 1 | tr 'A-Z' 'a-z');

# if user answers yes, system will upgrade
if [[ $ans2 = "y" ]];
    then
        apt -y upgrade;
        exit 0;
fi
