#!/bin/bash
#  Reinis Gunārs Mednis 2017

rm index.swf #removes previous swf file
wait %1 #waits for rm to finish
rm timetables/ #removes previous data
wget <url>/index.swf #Replace <url> with your own one.
wait %1 #Waits for it to be done
ffdec -export frame timetables/ index.swf #uses ffdec to export all frames