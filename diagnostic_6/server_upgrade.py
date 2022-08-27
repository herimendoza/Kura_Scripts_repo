import os
import subprocess

# open file to record upgrade details
# upg_file = open('file_upgrade.txt', 'r', 'w')

# subprocess.run(["ls", "-l"])
subprocess.run(["sudo", "apt", "update"])

# Ask user if they would like to upgrade
ans = input("Would you like up upgrade the server? yes/no")

# upgrade if yes
if ans == "yes":
	with open('file_upgrade.txt', 'w') as file:
		subprocess.run(["sudo", "apt", "upgrade"], stdout=file)
	


# close file
file.close()
