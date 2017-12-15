#!/bin/bash

# This script is used for dumping future "archived" timetables.
# The URL has 3 parts, the first part, which points to the archive,
# the second part, which contains the 2 dates, between which the 
# timetable applies, and the ending, which is the filename (index.swf).
# Example:
# url='http://ovt.lv/stundas/arhivs/'$nexttable_start'_'$nexttable_add'/index.swf'

# Sets first part/date of URL
nexttable_start=$(date -dnext-monday +%d.%m.%Y)
# Sets second part/date of URL
nexttable_add=$(date -d 'next-monday + 6 days' +%d.%m.%Y)
# Generates the final URL
url='<URL first part>'$nexttable_start'_'$nexttable_add'/index.swf'

# Uncomment the lines below to enable test printing of veriables
#printf "$nexttable_start"'_'"$nexttable_add"
#printf "$url"

rm index_next.swf 			# Removes previous file
wget $url -O index_next.swf # Gets file from server
# Checks MD5 Hash
if md5sum -c checklist_next.chk;

then # No changes detected, md5 matches.
	echo "No changes detected"
	exit
else # Changes detected, md5 doesn't match.
	echo "Changes detected"	
	rm timetables_next/ # Removes previous data
	wait %1 			# Waits for rm to finish
	ffdec -export frame timetables_next/ index_next.swf # Uses ffdec to export all frames
	md5sum index_next.swf > checklist_next.chk # Creates md5 checksum to check for 
fi
