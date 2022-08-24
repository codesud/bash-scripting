#!/bin/bash

set -e
COMPONENT=catalogue
LOGFILE="/temp/$COMPONENT.log"
APPUSER=roboshopdirect

source components/common.sh

# Calling NODEJS function
NODEJS





# 1. In order to make it work, update the proxy file in Nginx with the `$COMPONENT` server IP Address in the **`FRONTEND`** Server  

# **`Note:`** Do not do a copy and paster of IP in the proxy file, there are high chances to enter the empty space characters, which are not visible on the vim editor. Manual Typing of IP Address/ DNS Name is preferred. 


# > # vim /etc/nginx/default.d/$APPUSER.conf
# > 

# 1. Reload and restart the Nginx service.

# > # systemctl restart nginx
# >