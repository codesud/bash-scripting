#!/bin/bash

# This script creates servers and the associated route53 internal hosted zone records.
# AMI_ID="ami-0aa718de62aea6fbe"
# Throw an error if the input is null 
# Disclaimer: This script works on CENTOS7 Only

#Throw an error if the input is null
if [ "$1" = "" ]; then 
    echo -e "\e[31m \n Valid options are component-name or all \e[0m "
    exit 1
fi 

COMPONENT=$1
SGID="sg-09566ba4e8fe56dc5"
AMI_ID=$(aws ec2 describe-images  --filters "Name=name,Values=DevOps-LabImage-CentOS7" | jq '.Images[].ImageId' | sed -e 's/"//g')
echo $AMI_ID 

create_server() {

    echo -n "$COMPONENT server creation is in progress"
    PRIVATE_IP=$(aws ec2 run-instances --image-id $AMI_ID --instance-type t2.micro --security-group-id $SGID --tag-specifications "ResourceType=instance,Tags=
    [{Key=Name,Value=${COMPONENT}}]"  | jq '.Instances[].PrivateIpAddress' | sed -e 's/"//g')

    #Changing the IPADRESS and DNS Name as per component name
    sed -e "s/IPADDRESS/${PRIVATE_IP}/" -e "s/COMPONENT/${COMPONENT}/" route53.json > /tmp/record.json
    aws route53 change-resource-record-sets --hosted-zone-id Z02995003SL9D4FIIDWN4 --change-batch file:///tmp/record.json | jq

}
if [ "$1" == "all" ]; then
    for component in catalogue cart user shipping payment frontend mongodb mysql rabbitmq redis ; do
        COMPONENT=$component
        create_server
    done
else
    create_server
fi
