#!/bin/bash

set -e
COMPONENT=catalogue
LOGFILE="/temp/$COMPONENT.log"
APPUSER=roboshopdirect

source components/common.sh

# Calling NODEJS function
NODEJS
