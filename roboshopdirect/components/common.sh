#!/bin/bash

USER_ID=$(id -u)
if [ $USER_ID -ne 0 ] ; then 
    echo -e "\e[13m You need to run this as root user \e[0m"
    exit 1  
fi

stat() {
    if [ $1 -eq 0 ] ; then
        echo -e "\e[32m SUCCESS \e[0m"
    else 
        echo -e "\e[31m FAILURE \e[0m"
    fi
}

NODEJS() {
    echo -n "Configuring NodeJS repo: "
    curl -sL https://rpm.nodesource.com/setup_lts.x | bash &>> LOGFILE
    stat $?

    echo -n "Installing NodeJS repo: "
    yum install nodejs -y &>> LOGFILE
    stat $?

    # Calling CREATE_USER function
    CREATE_USER

    # Calling DOWNLOAD_AND_EXTRACT function
    DOWNLOAD_AND_EXTRACT

    echo -n "Installing $COMPONENT: "
    npm install &>> LOGFILE 
    stat $?

    # Calling CONFIG_SERVICE function
    CONFIG_SERVICE

    # Calling CONFIG_SERVICE function

}

CREATE_USER() {
    echo -n "Creating the $APPUSER user: "
    id $APPUSER &>> LOGFILE || useradd $APPUSER
    stat $?
}

DOWNLOAD_AND_EXTRACT() {
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

}

CONFIG_SERVICE() {
    echo -n "Configuring $COMPONENT service: "
    sed -i -e "s/REDIS_ENDPOINT/redis.$APPUSER.internal/" -e "s/MONGO_ENDPOINT/mongodb.$APPUSER.internal/" -e "s/MONGO_DNSNAME/mongodb.$APPUSER.internal/" systemd.service
    mv /home/$APPUSER/$COMPONENT/systemd.service  /etc/systemd/system/$COMPONENT.service
    stat $?

}

START_SERVICE() {
    echo -n "Starting $COMPONENT service: "
    systemctl daemon-reload
    systemctl restart $COMPONENT
    systemctl enable $COMPONENT &>> LOGFILE
    systemctl status $COMPONENT -l &>> LOGFILE
    stat $?
}

