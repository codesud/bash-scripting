#!/bin/bash

ACTION=$1 

# Simple If
# if [ "$ACTION" = "start" ] ; then 
#     echo -e "Selection option is \e[32m start \e[0m"
# fi 

# If Else 
# if [ "$ACTION" = "start" ] ; then 
#     echo -e "Selected option is \e[32m start \e[0m"
# else 
#     echo -e " \e[33m Valid option is start only \e[0m"
# fi 

# Else If 
if [ "$ACTION" = "start" ] ; then 
    echo -e "Selected option is \e[32m start \e[0m"  

elif [ "$ACTION" = "stop" ] ; then 
    echo -e "Selected option is \e[32m stop \e[0m" 

elif [ "$ACTION" = "restart" ] ; then 
    echo -e "Selected option is \e[32m restart \e[0m" 

else 
    echo -e " \e[33m Valid options are start or stop or restart only \e[0m"
    exit 8
fi 