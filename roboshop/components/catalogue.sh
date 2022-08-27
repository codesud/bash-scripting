#!/bin/bash

set -e
COMPONENT=catalogue
LOGFILE="/temp/$COMPONENT.log"
APPUSER=roboshop

source components/common.sh

# Calling NODEJS function
NODEJS

echo -e "\e[32m ____________________ $COMPONENT Configuration is completed ____________________ \e[0m"