#!/bin/bash

set -e
COMPONENT=frontend
LOGFILE="/temp/$COMPONENT.log"
APPUSER=roboshop
APPUSER_RECORD=roboshopdirect

source components/common.sh

echo -n "Installing Nginx : "
yum install nginx -y &>> LOGFILE
stat $? 

systemctl enable nginx &>> LOGFILE

echo -n "Starting Nginx : "
systemctl start nginx &>> LOGFILE
stat $? 

echo -n "Downloading $COMPONENT: "
curl -s -L -o /tmp/frontend.zip "https://github.com/stans-robot-project/frontend/archive/main.zip"
stat $? 

echo -n "Clearing the old contents: "
cd /usr/share/nginx/html
rm -rf *
stat $? 

echo -n "Extracting $COMPONENT: "
unzip /tmp/frontend.zip &>> LOGFILE
stat $? 

echo -n "Updating the PROXY file: "
mv frontend-main/* .
mv static/* .
rm -rf frontend-main README.md
mv localhost.conf /etc/nginx/default.d/$APPUSER.conf
stat $? 

echo -n "Configuring the proxy file: "
sed -i  -e "/payment/s/localhost/payment.$APPUSER_RECORD.internal/" -e "/shipping/s/localhost/shipping.$APPUSER_RECORD.internal/" -e "/user/s/localhost/user.$APPUSER_RECORD.internal/" -e "/cart/s/localhost/cart.$APPUSER_RECORD.internal/" -e "/catalogue/s/localhost/catalogue.$APPUSER_RECORD.internal/' /etc/nginx/default.d/$APPUSER.conf
stat $?

echo -n "Retarting Nginx: "
systemctl restart nginx
stat $?

echo -e " ____________________ \e[32m $COMPONENT Configuration is completed ____________________ \e[0m"
