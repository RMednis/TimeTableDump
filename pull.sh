#!/bin/bash
#  Reinis Gunārs Mednis 2017
rm index.swf #removes previous swf file
wget <url>/index.swf #Replace <url> with your own one.
if md5sum -c checklist.chk; then #checks for changes
	exit
else
	rm timetables/ #removes previous data
	wait %1 #Waits for rm to finish
	ffdec -export frame <repository>/timetables/ index.swf #uses ffdec to export all frames
	md5sum index.swf > checklist.chk #creates md5 checksum to check for changes
	cd <repository>/
	git commit -m "Extracted images on `date +'%Y-%m-%d %H:%M:%S'`";
	git push -f origin master;
fi

