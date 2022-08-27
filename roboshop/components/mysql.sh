#!/bin/bash

COMPONENT=mysql  
LOGFILE="/tmp/$COMPONENT.log"
source components/common.sh 
REPO_URL="https://raw.githubusercontent.com/stans-robot-project/$COMPONENT/main/mysql.repo"
SCHEMA_URL="https://github.com/stans-robot-project/$COMPONENT/archive/main.zip"

echo -n "Configuring the $COMPONENT Repo:  "
curl -s -L -o /etc/yum.repos.d/mysql.repo $REPO_URL 
stat $? 

echo -n "Installing $COMPONENT Community Edition: "
yum install mysql-community-server -y &>> $LOGFILE
stat $? 

echo -n "Starting the $COMPONENT: "
systemctl enable mysqld &>> $LOGFILE 
systemctl restart mysqld &>> $LOGFILE 
stat $? 

# # We need to handle this only for the first time
# echo "show databases" | mysql -uroot -pRoboShop@1 &>> $LOGFILE 
# if [ 0 -ne $? ]; then 
#     echo -n "Changing the default $COMPONENT root password: "
#     echo "SET PASSWORD FOR 'root'@'localhost' = PASSWORD('RoboShop@1');" > /tmp/rootpassword_change.sql
#     DEFAULT_ROOT_PASSWORD=$(sudo grep "temporary password" /var/log/mysqld.log | awk '{print $NF}')
#     mysql  --connect-expired-password -uroot -p"$DEFAULT_ROOT_PASSWORD"  < /tmp/rootpassword_change.sql
#     stat $?
# fi 

# # We need to handle this only for the first time
# echo show plugins | mysql -uroot -pRoboShop@1 2>> $LOGFILE | grep validate_password  &>> $LOGFILE 
# if [ $? -eq 0 ]; then      
#     echo -n "Uninstalling Password Validate Plugin: "
#     echo 'uninstall plugin validate_password;' > /tmp/password-validate.sql 
#     mysql  --connect-expired-password -uroot -pRoboShop@1 </tmp/password-validate.sql &>> $LOGFILE 
#     stat $? 
# fi

# echo -n "Downloading the schema: "
# curl -s -L -o /tmp/mysql.zip $SCHEMA_URL
# stat $? 

# echo -n "Extracting the schema: "
# cd /tmp
# unzip -o mysql.zip  &>> $LOGFILE 
# stat $? 

# echo -n "Injecting the schema: "
# cd mysql-main && mysql -u root -pRoboShop@1 <shipping.sql &>> $LOGFILE 

# echo -e " ____________________ \e[32m $COMPONENT Configuration is completed ____________________ \e[0m"