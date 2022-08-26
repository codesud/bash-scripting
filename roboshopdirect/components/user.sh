#!/bin/bash

set -e
COMPONENT=user
LOGFILE="/temp/$COMPONENT.log"
APPUSER=roboshopdirect

source components/common.sh

# Calling NODEJS function
NODEJS
