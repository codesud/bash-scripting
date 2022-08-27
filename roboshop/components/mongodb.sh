#!/bin/bash

set -e
COMPONENT=mongodb
LOGFILE="/temp/$COMPONENT.log"
MONGODB_REPO_URL="https://raw.githubusercontent.com/stans-robot-project/mongodb/main/mongo.repo"
COMPONENT_REPO="https://github.com/stans-robot-project/mongodb/archive/main.zip"

source components/common.sh

echo -n "Downloading $COMPONENT repo: "
curl -s -o /etc/yum.repos.d/mongodb.repo $MONGODB_REPO_URL
stat $? 


echo -n "Installing $COMPONENT: "
yum install -y mongodb-org &>> LOGFILE
stat $? 

echo -n "Updating $COMPONENT Listening address: "
sed -i -e 's/127.0.0.1/0.0.0.0/' /etc/mongod.conf
stat $?

echo -n "Starting $COMPONENT: "
systemctl enable mongod &>> LOGFILE
systemctl restart mongod &>> LOGFILE
stat $?

echo -n "Downloading $COMPONENT code: "
curl -s -L -o /tmp/mongodb.zip "$COMPONENT_REPO" 
stat $?

cd /tmp

echo -n "Extracting $COMPONENT code: "
unzip -o mongodb.zip &>> LOGFILE
stat $?

cd mongodb-main

echo -n "Injecting $COMPONENT schema: "
mongo < catalogue.js &>> LOGFILE
mongo < users.js &>> LOGFILE
stat $?

echo -e "\e[32m ____________________ $COMPONENT Configuration is completed ____________________ \e[0m"