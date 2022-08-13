#!/bin/bash 

# Functions helps you in avoiding the same set of code multiple times.
# Declare it as a function and call it whenever or whereever you want.

# We are declaring a funciton fa

# This will call / pull all the functions/ vars from the external file. So that you can call and use them.
source ./common.sh 

LOADAVG="$(uptime | awk -F : '{print $NF}' | awk -F , '{print $1}')"

sam() {
    echo "I am a Command from SAM"
}

fa () 
{ 
    echo "I am the first line in the function f";
    echo "Todays date is $(date +%F)";
    echo "Number of opened sessiosn are $(who |wc -l)"
    echo "calling SAM Function"
    sam 
    echo "Function f completed ..... BYE"
}

fa 
stat() {
    echo "Load Average from last 1 min is $LOADAVG"
    echo "Number of opened sessions are $(who |wc -l )"
    echo "Todays date is $(date +%F)"
}

echo "Calling stat function"
stat

echo -e "\e[32m Calling common_fun function from external file \e[0m"
common_fun