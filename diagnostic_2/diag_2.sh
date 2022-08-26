#!/bin/bash


# ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
# DIAGNOSTIC 2 SCRIPT
# Author: Heriberto Mendoza
# Description: This dynamic script will take in user input and
# create a an account on the server with a username, group and shell
# to the user's specifications. Finally, the script will update the
# password to the account. Must be superuser to run this.
#
# Note: there is a bug with the update password command. It currently
# does not work.
# ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

# Script will only run as superuser = will exclude other users
if [[ $UID != 0 ]];
    then
    echo "You need to be superuser";
    exit 1;

fi

# ask user for first name
read -p "What is your first name? " var_fname;

# ask user for last name
read -p "What is your last name? " var_lname;

# ask user for shell e.g /bin/bash
read -p "What is your shell? " var_shell;

# ask user for group
read -p "What group would you like to be added to? " var_group;

# ask user to make a password
read -p "Please create a password: " var_passwd;

# initial of first name
f_initial=$(echo $var_fname | tr 'A-Z' 'a-z' | cut -c 1);

# make last name lowercase
var_lname=$(echo $var_lname | tr 'A-Z' 'a-z');

# inital of first + last name
var_uname="$f_initial$var_lname";

# create a group first
groupadd $var_group;

# creat username, group, and shell for user
useradd -s $var_shell -g $var_group $var_uname

# update password for user
echo "$var_uname:$var_passwd | chpasswd";


