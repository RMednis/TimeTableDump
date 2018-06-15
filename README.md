# TimeTableDump
Automatically dumps time table .png images from asctimetables flash applets .swf file using JPESX Free Flash Decompiler.

TimeTableDump has 3 diferent scripts. These were made with the particular setup that Ogres Valsts Tehnikums has, but they should be easily adoptable to other setups aswell!

The scripts are:
 - pull.sh - The main script that we use to pull the student timetables. This is meant only if the required site has a single .swf flash file.
 - pull_teachers.sh - We use this script to pull down the teacher timetables, it's meant for use with sites that use the combination of multiple swf files for a single category. (We have about 130 teachers, and there seems to be a 89 table limit per file.)
 - pull_next.sh - This is an experimental script that is meant to automatically calculate the first and last dates of next week, and attempt to pull the timetable. This isn't beeing used in production and will most likely need to be compleatly rewritten.

These scripts are being used to serve .png files to the webserver at [OVTDMP](https://mednis.id.lv/OVTDMP/), as well as serving for the [OVTDMP github repository](https://github.com/RMednis/OVTDMP).

This is (as far as i know) the only way to  extract these timetables from the software without buying the seemingly expensive HTML5 upgrade from asc. The main use for this is to view school timetables on mobile devices that don't have/support flash player, as well as older computers that seem to have troubles loading the flash content. 

## Requirements
- Linux/Unix based OS (Tested only on Ubuntu 16.10/18.10)
- [JPESX Free Flash Decompiler (ffdec)](https://github.com/jindrapetrik/jpexs-decompiler)
- wget
- md5sum
- date

## Setup
The overall configuration of these scripts should be pretty straight forward. Each script includes comments about what each line is doing.

The setup is as follows:
1. Install all required software. (See requirements above)
2. Pull this git repo.
3. 1. For the pull.sh script add the url to the flash (.swf) file in the URL parameter, and add the path to where you want to extract said file in the PATH veriable. If needed uncoment and add the git repo path.
   2. For te pull_teachers.sh script you need to specify the URLS for each of the .swf files, aswell as where to export each of them. If you need to extract more files, copy and modify the specified lines acordingly!
4. Setup chron tasks to launch each script based on your preferences.
