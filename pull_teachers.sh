#!/bin/bash

######################################
#     Reinis Gunārs Mednis 2018		 #
# Teacher Timetable Dump version 1.0 #
######################################
# Please read the README.md file for #
#         more information!          #
######################################


# The URL's where both files exist on the server. Add more as needed.
# Example:
# skolotaji_1='http://ovt.lv/stundas/stundu_saraksts/teachers_0.swf'
# skolotaji_2='http://ovt.lv/stundas/stundu_saraksts/teachers_1.swf'
skolotaji_1=''
skolotaji_2=''


# The places where the images will be exported to. Feel free to add more if needed.
# Example:
# export_1='OVTDMP/teacher_tables/1/'
# export_2='OVTDMP/teacher_tables/2/'
export_1=''
export_2=''

# If you are using chrontab to launch this script, uncomment the next line and modify it to point t]o the script directory.
# cd /home/timetabledump/

# Removes the previous flash files, copy and modify the below string for more files.
rm skolotaji_0.swf
rm skolotaji_1.swf

# Grabbing all of the flash swf files.
# Copy and modify the below string for additional files:
wget $skolotaji_1 -O skolotaji_0.swf
wget $skolotaji_2 -O skolotaji_1.swf

# Compairing the file md5 hashes, in order to detect changes.
if md5sum -c checklist_skolotaji.chk; then # No changes detected, hashes match!
	
	# Print the non-matcing statement to the log!
	echo "All hashes match! No changes to the teacher tables found!"
	
	# Nothing more to do, let's ... 
	exit 0

else # The hashes don't match, there might be changes.
	
	# Print the detection to the log file
	echo "Changes detected, teacher timetable hashes don't match!"
	
	# Remove previous dumps, and dump the first flash file
	# Copy and modify these lines for as many files as you need!
	rm $export_1
	ffdec -export frame $export_1 skolotaji_0.swf # Export images from file 1

	# Remove previous dumps, and dump the second flash file
	rm $export_2
	ffdec -export frame $export_2 skolotaji_1.swf # Export images from file 2
	
	# Lets create a hash of these files!
	# To create sums of more files, add the filenames here:
	md5sum skolotaji_0.swf skolotaji_1.swf > checklist_skolotaji.chk 

	# Git pushing (optional)
	# cd <repository>/
	# git add -A
	# git commit -m "Extracted images on `date +'%Y-%m-%d %H:%M:%S'`";
	# git push origin master;
fi
