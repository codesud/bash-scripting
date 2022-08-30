#!/bin/bash

COMPONENT=$1
SGID="sg-09566ba4e8fe56dc5"
AMI_ID=$(aws ec2 describe-images  --filters "Name=name,Values=DevOps-LabImage-CentOS7" | jq '.Images[].ImageId' | sed -e 's/"//g')
echo $AMI_ID 

PRIVATE_IP=$(aws ec2 run-instances --image-id $AMI_ID --instance-type t2.micro --security-group-id $SGID --tag-specifications "ResourceType=instance,Tags=
[{Key=Name,Value=${COMPONENT}}]"  | jq '.Instances[].PrivateIpAddress' | sed -e 's/"//g')


echo $PRIVATE_IP

#Changing the IPADRESS and DNS Name as per component name
sed -e "s/IPADDRESS/${PRIVATE_IP}/" -e "s/COMPONENT/${COMPONENT}/" route53.json > /tmp/record.json
aws route53 change-resource-record-sets --hosted-zone-id Z02995003SL9D4FIIDWN4  --change-batch file:///tmp/record.json | jq