#!/bin/bash

# +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
# BUILD SCRIPT 3
# Author: Heriberto Mendoza
# Date: 18.8.2022
# 
# Description:
# Create a user and place the user in a GitAcc group
# Once user is ready to ADD and commit, script should to that for the user
# check file for sensitive information like phone numbers and ssn before pushing
# This is a dynamic script, and as such will prompt the user at various steps.
# 
# Instructions: put this script in the folder where your target file is located.
#
# ASSUMPTIONS: 
# SCRIPT ASSUMES THAT USER HAS ALREADY INITIALIZED A LOCAL REPO
# SCRIPT ASSUMES THAT USER HAS ALREADY SET UP GITHUB SSH ETC.
# SCRIPT ASSUMES USER IS ALREADY WORKING AND EDITING IN A BRANCH (NOT MAIN)
# 
# break notes:
# 1- did not code for possibility that the user exists but is not already in the GitAcc group
# 2- assumes the default config of naming the main branch is "main"
# 3- The command to replace phone numbers does not cover numbers formatted at (xxx)xxx-xxxx,
# only xxx-xxx-xxxx and xxxxxxxxxx
# 4- inputs like filenames, directory paths, etc must be entered precisely.
# 5- this script will only work if it is placed in the directory where the target file is located
# +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++


# Check if group GitAcc exists.
# if not, make it
if [[ -z $(cat /etc/group | grep "GitAcc") ]];
    then
    echo "No GitAcc group found. Creating one.";
    sudo groupadd GitAcc;
else
    echo "GitAcc group already exists!"
fi


# ask user for first name
read -p "What is your first name? " var_fname;
var_fname=$(echo $var_fname | tr 'A-Z' 'a-z');
# ask user for last name
read -p "What is your last name? " var_lname;
var_lname=$(echo $var_lname | tr 'A-Z' 'a-z' );


# make username with initial of first name and last name
var_initial=$(echo $var_fname | cut -c 1 );
var_uname=$var_initial$varlname;

# check if username exists
# if it doesnt exist, make user and add to GitAcc group
if [[ -z $(cat /etc/passwd | grep $var_uname) ]];
    then
    echo "User does not exist. Making new user...";
    sudo useradd -s /bin/bash -g GitAcc $var_uname;
else
    echo "User already exists!"
fi

# What directory do you want to work in?
read -p "What directory do you want to work in? Enter path: " var_dir;
#cd $var_dir

# What branch do you want to work in?
echo "Branches available:";
git branch
read -p "What branch do you want to work in? Enter branch name: " var_branch;
while [ $var_branch == "main" ]
do 
    echo "Not allowed to work in main branch."
    read -p "Enter the name of the branch you want to push to: " var_branch;
done
# switch to a branch
git checkout $var_branch;

# Show available files
ls

# ask user what file they want to update -- file
read -p "Enter the name of the file you want to update: " var_file


# checks for sensitive info

# check for SSN in xxxxxxxxx, xxx-xx-xxxx or xxx.xx.xxxx format
sed -i 's/[0-9]\{3\}-\{0,1\}\.\{0,1\}[0-9]\{2\}-\{0,1\}\.\{0,1\}[0-9]\{4\}/XXX-XX-XXXX/g' $var_file;
    
# check for phone numbers: format xxx-xxx-xxxx, xxxxxxxxxx, NOT (xxx) xxx-xxxx, 
sed -i 's/[0-9]\{3\}-\{0,1\}\s\{0,1\}[0-9]\{3\}-\{0,1\}[0-9]\{4\}/XXX-XXX-XXXX/g' $var_file;

# git commit message
read -p "Enter a short message about your new commit: " var_msg;
# git ADD changes
git add $var_file;
echo "File was added to staging";
# git COMMIT changes
git commit -m "'$var_msg'";
echo "File was committed.";

# READY TO PUSH?
read -p "Are you ready to push to Github? [y/n] " ans
ans=$(echo $ans | tr 'A-Z' 'a-z');
if [[ $ans == "n" ]];
    then
    echo "Not ready to push. Goodbye."
    exit 0;
elif [[ $ans == "y" ]];
    then
    echo "Proceeding to push...";
    git push origin $var_branch;
    echo "$varbranch was updated. Goodbye"
fi

# To use filepaths: Use $HOME instead of ~/!!!!!!!!
