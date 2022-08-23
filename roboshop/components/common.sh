#!/bin/bash

USER_ID=$(id -u)
if [ $USER_ID -ne 0 ] ; then 
    echo -e "\e[13m You need to run this as root user \e[0m"
    exit 1  
fi