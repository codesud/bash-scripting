#!/bin/bash

set -e
COMPONENT=redis
LOGFILE="/temp/$COMPONENT.log"

source components/common.sh

echo -n "Configuring $COMPONENT repo: "
curl -L https://raw.githubusercontent.com/stans-robot-project/$COMPONENT/main/$COMPONENT.repo -o /etc/yum.repos.d/$COMPONENT.repo &>> LOGFILE
stat $?

echo -n "Installing $COMPONENT : "
yum install redis-6.2.7 -y &>> LOGFILE
stat $?

echo -n "Updating $COMPONENT Listening address: "
sed -i -e 's/127.0.0.1/0.0.0.0/' /etc/$COMPONENT.conf /etc/$COMPONENT/$COMPONENT.conf
stat $?

echo -n "Starting $COMPONENT: "
systemctl enable redis &>> LOGFILE
systemctl restart redis &>> LOGFILE
stat $?

echo -e " ___________ \e[32m $COMPONENT Configuration is completed \e[0m ___________ "
