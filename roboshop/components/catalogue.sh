#!/bin/bash

set -e
COMPONENT=catalogue
LOGFILE="/temp/$COMPONENT.log"
APPUSER=roboshop

source components/common.sh

# Calling NODEJS function
NODEJS

echo -e " ___________ \e[32m $COMPONENT Configuration is completed \e[0m ___________ "