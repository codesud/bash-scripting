#!/bin/bash 

DATE_COMMAND=$(date +%F) 
echo "Good Morning, Todays date is $DATE_COMMAND"
echo "Total number of opened sessions are $(who |wc -l)"
