#!/bin/bash

COMPONENT=$1
SGID="sg-09566ba4e8fe56dc5"
AMI_ID=$(aws ec2 describe-images  --filters "Name=name,Values=DevOps-LabImage-CentOS7" | jq '.Images[].ImageId' | sed -e 's/"//g')
echo $AMI_ID 
aws ec2 run-instances --image-id $AMI_ID --instance-type t2.micro --security-group-id $SGID --tag-specifications "ResourceType=instance,Tags=[{Key=Name,Value=${COMPONENT}}]"  | jq