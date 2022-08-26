#!/bin/bash

set -e
COMPONENT=user
LOGFILE="/temp/$COMPONENT.log"
APPUSER=roboshop
APPUSER_RECORD=roboshopdirect

source components/common.sh

# Calling NODEJS function
NODEJS

echo -e " ___________ \e[32m $COMPONENT Configuration is completed \e[0m ___________ "