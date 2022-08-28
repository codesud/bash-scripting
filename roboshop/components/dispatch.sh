#!/bin/bash

yum install golang -y

useradd roboshop

sudo su - roboshop

curl -L -s -o /tmp/dispatch.zip https://github.com/stans-robot-project/dispatch/archive/refs/heads/main.zip
unzip /tmp/dispatch.zip 
mv dispatch-main dispatch 
cd dispatch 
go mod init dispatch
go get 
go build

sudo su -
mv /home/roboshop/dispatch/systemd.service /etc/systemd/system/dispatch.service
systemctl daemon-reload
systemctl enable dispatch 
systemctl start dispatch