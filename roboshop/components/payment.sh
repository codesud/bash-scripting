#!/bin/bash
set -e 
COMPONENT=payment 
LOGFILE="/tmp/$COMPONENT.log"
APPUSER="roboshop"

source components/common.sh

# Calling PYTHON Function
PYTHON

echo -e " ____________________ \e[32m $COMPONENT Configuration is completed ____________________ \e[0m"