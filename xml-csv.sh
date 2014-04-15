#!/bin/bash

COUNT=`xmllint --xpath 'count(//rss/channel/item)' jira.xml`
let COUNT=COUNT-1
echo $COUNT
CMD="xmllint --xpath '//rss/channel/item[$COUNT]/title/text()' jira.xml"
title=`eval $CMD`
echo $title
while [  $COUNT -gt 0 ]; do
     title="xmllint --xpath '//rss/channel/item[$COUNT]/title/text()' jira.xml"
     key="xmllint --xpath '//rss/channel/item[$COUNT]/key/text()' jira.xml"
     cDate="xmllint --xpath '//rss/channel/item[$COUNT]/created/text()' jira.xml"
     uDate="xmllint --xpath '//rss/channel/item[$COUNT]/updated/text()' jira.xml"

     k=`eval $key`
     t=`eval $title`
     cD=`eval $cDate`
     uD=`eval $uDate`

     cCmd="date -jf \"%a, %e %h %Y %H:%M:%S %z\" \"$cD\" +\"%x\""
     uCmd="date -jf \"%a, %e %h %Y %H:%M:%S %z\" \"$cD\" +\"%x\""
     # echo $cCmd
     c=`eval $cCmd`
     u=`eval $uCmd`
     echo $k,$t,$c,$u >> out.csv
     # echo $COUNT
     let COUNT=COUNT-1 
 done