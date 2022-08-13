#!/bin/bash 

# case $var in 
#     opt1)  commands ;; 
#     opt2)  commands ;; 

# esac 

ACTION=$1

case $ACTION in 
    start)  
        echo "XYZ Service Starting"
        exit 0
        ;;
    stop)  
        echo "XYZ Service Stopping"
        exit 0
        ;;
    *)
        echo -e "\e[33m Valid options are start or stop only \e[0m"
        exit 1 
esac