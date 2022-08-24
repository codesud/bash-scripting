#!/bin/bash

set -e
COMPONENT=catalogue
LOGFILE="/temp/$COMPONENT.log"
APPUSER=roboshop

source components/common.sh

echo -n "Configuring NodeJS repo: "
curl -sL https://rpm.nodesource.com/setup_lts.x | bash &>> LOGFILE
stat $?

echo -n "Installing NodeJS repo: "
yum install nodejs -y &>> LOGFILE
stat $?

echo -n "Creating the $APPUSER user: "
id $APPUSER &>> LOGFILE || useradd $APPUSER
stat $?

echo -n "Downloading $COMPONENT repo: "
curl -s -L -o /tmp/$COMPONENT.zip "https://github.com/stans-robot-project/$COMPONENT/archive/main.zip"
stat $?

echo -n "Performing $COMPONENT cleanup: "
cd /home/$APPUSER && rm -rf $COMPONENT &>> LOGFILE
stat $?

echo -n "Extracting $COMPONENT: "
cd /home/$APPUSER
unzip -o /tmp/$COMPONENT.zip &>> LOGFILE
mv $COMPONENT-main $COMPONENT && chown -R $APPUSER:$APPUSER $COMPONENT
cd $COMPONENT
stat $?

echo -n "Installing $COMPONENT: "
npm install &>> LOGFILE 
stat $?

echo -n "Configuring $COMPONENT service: "
sed -i -e 's/MONGO_DNSNAME/mongodb.roboshopdirect.internal/' systemd.service
mv /home/$APPUSER/$COMPONENT/systemd.service  /etc/systemd/system/catalogue.service
stat $?

echo -n "Starting $COMPONENT service: "
systemctl daemon-reload
systemctl restart $COMPONENT
systemctl enable $COMPONENT &>> LOGFILE
systemctl status $COMPONENT -l &>> LOGFILE
stat $?


# NOTE: You should see the log saying `connected to MongoDB`, then only your $COMPONENT
# will work and can fetch the items from MongoDB

# Ref Log:
# {"level":"info","time":1656660782066,"pid":12217,"hostname":"ip-172-31-13-123.ec2.internal","msg":"MongoDB connected","v":1}




# 1. In order to make it work, update the proxy file in Nginx with the `$COMPONENT` server IP Address in the **`FRONTEND`** Server  

# **`Note:`** Do not do a copy and paster of IP in the proxy file, there are high chances to enter the empty space characters, which are not visible on the vim editor. Manual Typing of IP Address/ DNS Name is preferred. 


# > # vim /etc/nginx/default.d/$APPUSER.conf
# > 

# 1. Reload and restart the Nginx service.

# > # systemctl restart nginx
# >