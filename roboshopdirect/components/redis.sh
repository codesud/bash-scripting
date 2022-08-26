#!/bin/bash

set -e
COMPONENT=redis
LOGFILE="/temp/$COMPONENT.log"

source components/common.sh

echo -n "Downloading $COMPONENT repo: "
# curl -L https://raw.githubusercontent.com/stans-robot-project/redis/main/redis.repo -o /etc/yum.repos.d/redis.repo
stat $?

echo -n "Installing $COMPONENT : "
# yum install redis-6.2.7 -y
stat $?

echo -n "Updating $COMPONENT Listening address: "
sed -i -e 's/127.0.0.1/0.0.0.0/' /etc/redis/redis.conf
stat $?

echo -n "Starting $COMPONENT: "
systemctl enable redis &>> LOGFILE
systemctl restart redis &>> LOGFILE
stat $?

echo -e " ___________ \e[32m $COMPONENT Configuration is completed \e[0m ___________ "
