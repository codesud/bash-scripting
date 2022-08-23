#!/bin/bash

set -e
COMPONENT=mongodb
LOGFILE="/temp/$COMPONENT.log"
MONGODB_REPO_URL="https://raw.githubusercontent.com/stans-robot-project/mongodb/main/mongo.repo"

source components/common.sh

echo -n "Downloading $COMPONENT repo :"
curl -s -o /etc/yum.repos.d/mongodb.repo $MONGODB_REPO_URL
stat $? 


echo -n "Installing $COMPONENT :"
yum install -y mongodb-org &>> LOGFILE
stat $? 

echo -n "Updating $COMPONENT Listening address :"
sed -i -e 's/127.0.0.1/0.0.0.0/' /etc/mongod.conf
stat $?

echo -n "Starting $COMPONENT :"
systemctl enable mongod &>> LOGFILE
systemctl restart mongod &>> LOGFILE
stat $?

echo -e " ___________ \e[32m $COMPONENT Configuration is completed \e[0m ___________ "


# Update Listen IP address from 127.0.0.1 to 0.0.0.0 in the config file, so that MongoDB can be accessed by other services.
# Config file:   # vim /etc/mongod.conf


# systemctl restart mongod &>> LOGFILE


# curl -s -L -o /tmp/mongodb.zip "https://github.com/stans-robot-project/mongodb/archive/main.zip"

# cd /tmp
# unzip mongodb.zip &>> LOGFILE
# cd mongodb-main
# mongo < catalogue.js
# mongo < users.js