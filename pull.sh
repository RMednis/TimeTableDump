#!/bin/bash

######################################
#     Reinis Gunārs Mednis 2018		 #
# Student Timetable Dump version 2.3 #
######################################
# Please read the README.md file for #
#         more information!          #
######################################

# The path where the timetables should be extracted to.
# Example:
# PATH="/timetables/"
PATH=''


# The URL where the file is hosted on the server
# Example:
# URL='http://ovt.lv/stundas/stundu_saraksts/index.swf'
URL=''

# Removing the previous files (assuming the file is named index.swf)
rm index.swf

# Pulling the file from the webserver, saving it as index.swf
wget $URL -O index.swf

# Checking for changes using md5 hashes!
if md5sum -c checklist_students.chk; then 
	# Both old and new hashes match!
	exit
else
	# Hashes are diferent, there seem to be changes!
	rm $PATH # Removes previous timetables / their folder.
	ffdec -export frame $PATH index.swf # Uses ffdec to export all frames from the swf files.
	md5sum index.swf > checklist_students.chk # Creates md5 checksum to check for changes.
	
	# Git pushing the changes (optional)
	# cd <repository>/
	# git add -A
	# git commit -m "Extracted images on `date +'%Y-%m-%d %H:%M:%S'`";
	# git push origin master;
fi
