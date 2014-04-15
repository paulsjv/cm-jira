#!/bin/bash

# A few different queries to run in JIRA to get data

# Get the Display teams creation date to the QA Blocked 
# project = Display AND status =  "QA Blocked" ORDER BY created DESC

# get the number of JIRA items to look at from XML export in JIRA
# the file that xmllint runs on should be named "jira.xml"
COUNT=`xmllint --xpath 'count(//rss/channel/item)' jira.xml`

while [  $COUNT -gt 0 ]; do
     # the xmllint command that will be eval'ed based on the JIRA xml.
     title="xmllint --xpath '//rss/channel/item[$COUNT]/title/text()' jira.xml"
     key="xmllint --xpath '//rss/channel/item[$COUNT]/key/text()' jira.xml"
     cDate="xmllint --xpath '//rss/channel/item[$COUNT]/created/text()' jira.xml"
     uDate="xmllint --xpath '//rss/channel/item[$COUNT]/updated/text()' jira.xml"

     # eval each command to get value
     k=`eval $key`
     t=`eval $title`
     cD=`eval $cDate`
     uD=`eval $uDate`

     # convert the dates from the above eval command
     # date -jf "format the date is currently in" "String Date" "format to go to"
     cCmd="date -jf \"%a, %e %h %Y %H:%M:%S %z\" \"$cD\" +\"%x\""
     uCmd="date -jf \"%a, %e %h %Y %H:%M:%S %z\" \"$uD\" +\"%x\""

     c=`eval $cCmd`
     u=`eval $uCmd`
     echo $k,$t,$c,$u >> out.csv

     let COUNT=COUNT-1 
 done