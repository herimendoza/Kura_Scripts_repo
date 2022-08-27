import os
import subprocess

# open file to record upgrade details
upg_file = open('file_upgrade_log.txt', 'w')

subprocess.run(["sudo", "apt", "update"])

# Ask user if they would like to upgrade
ans = input("Would you like up upgrade the server? yes/no ")

# upgrade if yes
if ans == "yes":
	subprocess.run(["sudo", "apt", "upgrade"], stdout=upg_file)

# close file
upg_file.close()
