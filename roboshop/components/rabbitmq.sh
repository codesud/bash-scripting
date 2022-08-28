#!/bin/bash

COMPONENT=rabbitmq  
LOGFILE="/tmp/$COMPONENT.log"
source components/common.sh 
APPUSER=roboshop


echo -n "Configuring repo: "
curl -s https://packagecloud.io/install/repositories/rabbitmq/rabbitmq-server/script.rpm.sh | sudo bash &>> $LOGFILE
stat $? 

echo -n "Installing $PAYMENT Depenency Package Erlang and $COMPONENT"
yum install https://github.com/rabbitmq/erlang-rpm/releases/download/v23.2.6/erlang-23.2.6-1.el7.x86_64.rpm rabbitmq-server -y &>> $LOGFILE
stat $? 

echo -n "Starting $COMPONENT: "
systemctl enable rabbitmq-server &>> $LOGFILE 
systemctl start rabbitmq-server &>> $LOGFILE
stat $? 

systemctl status rabbitmq-server -l &>> $LOGFILE

rabbitmqctl list_users |grep $APPUSER &>> $LOGFILE
if [ $? -ne 0 ] ; then 
echo -n "Creating $APPUSER user for rabbitmq: "
rabbitmqctl add_user $APPUSER roboshop123 &>> $LOGFILE
stat $? 
fi 

echo -n "Configuring $APPUSER permissions for $COMPONENT"
rabbitmqctl set_user_tags $APPUSER administrator  &>> $LOGFILE 
rabbitmqctl set_permissions -p / $APPUSER ".*" ".*" ".*"  &>> $LOGFILE
stat $?

# #We are good with rabbitmq.Next component is PAYMENT

echo -e "\e[32m ____________________ $COMPONENT Configuration is completed ____________________ \e[0m"