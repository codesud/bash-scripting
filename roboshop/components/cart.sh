#!/bin/bash
set -e 
COMPONENT=cart 
LOGFILE="/tmp/$COMPONENT.log"
APPUSER="roboshop"

source components/common.sh

# Calling NodeJS Function
NODEJS 

echo -e "\e[32m ____________________ $COMPONENT Configuration is completed ____________________ \e[0m"