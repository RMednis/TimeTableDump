###################################
#                                 #
#  MedsNET Internal Data Scraper  #
#                                 #
###################################

# This script will parse the Data from timetables.xml on the asctimetables server and
# insert it into the TimeTableDump web applet.

import urllib.request, urllib.error
import xml.etree.ElementTree as ET
from bs4 import BeautifulSoup

########################
#      Variables       #
########################
# Changeable #
url = 'http://ovt.lv/stundas/stundu_saraksts/timetable.xml' # The URL point to the xml file on the asctimetables server
teachers = 'index.html' # The location of the TimeTableDump html file that needs to be updated


# Do not change these variables #
website = urllib.request.urlopen(url) # Opens the website
data = website.read() # Pulls the raw data from the opened site/xml
root = ET.fromstring(data) # Puts the in the xml element tree

########################
#        Code          #
########################
with open(teachers) as inf: # Opens the teacher html file
    txt = inf.read() # Reads the data from the file
    soup = BeautifulSoup(txt, "html.parser") # Parses the data and drops it into BeutifulSoup

firstoption = soup.find("option", {"value": "0"}) # Gets the first option item, which should be kept

for option in soup.find_all('option'): # Goes over each currently existing option
    if option is firstoption: # Checks to see if the currently selected option is the 1st one
        continue # Skips it, since it has to be kept and doesn't change
    else: # If the currently selected option is any other option
       option.extract() # Removes it

# Scraping the teacher timetables
for teacher in root.iter('teacher'): # Goes over each teacher listed under the teacher tag
    name = teacher.get('name') # Pulls the teacher name from the xml
    timetable = teacher.get('id').replace("*", "") # Gets the teacher timetable id and removes the * character
    #print('<option value="' + timetable + '">' + name + '</option>')

    # Web Applet Editing
    opcija = soup.new_tag("option", value=timetable) # Creates the option tag with the correct image id
    opcija.append(name) # Adds the teacher name in between the tags

    for option in soup.find_all('option'): # Gets the previous option obejct/tag
        option.insert_after(opcija) # Adds the current option tag after it



for option in soup.find_all('option'): # Cycles over all the option tags in the file
    option.insert_after("\n") # Adds a newline after each to improve readability



# Scraping the class timetables
#for kurss in root.iter("class"):
#    name = kurss.get('name')
#    timetable = kurss.get('id').replace("*", "")
#
#    print('<option value="' + timetable + '">' + name + '</option>')
#

with open(teachers, "w") as file: # Opens the teacher html file
    file.write(str(soup)) # Writes all the changes we made in beutifullsoup
