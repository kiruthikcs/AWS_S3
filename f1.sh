#!/bin/bash

# Installing AWS-CLI

wget https://s3.amazonaws.com/aws-cli/awscli-bundle.zip
unzip awscli-bundle.zip
sudo ./awscli-bundle/install -i /usr/local/aws -b /usr/local/bin/aws
./awscli-bundle/install -b ~/bin/aws
./awscli-bundle/install -h

sleep 10

# AWS configure
export aws_access_key_id=AKIAIQBKPTUIZ6MHQ74r
export aws_secret_access_key=crBQm7MsJe5r8qMUvQOS6LWZhQReQ8DQOkMof4Kl
export region=us-east-2
export output=json

# S3 BUCKET CREATION
read -p "enter Bucket name :" name

Bucket=$(aws s3api create-bucket --bucket $name --region us-east-1 --output text | grep $name)

if [[ $Bucket == "/${name}" ]]
then
echo "${Bucket} kirutk-Bucket created"
else 
echo "${Bucket} Error in bucket creation"
fi


# UPLOADING FILE IN S3
read -p "Enter the FileName:" file
aws s3 cp $file s3://$Bucket --grants read=uri=http://acs.amazonaws.com/groups/global/AllUsers full=emailaddress=k@mail.com
fileCheck=$(aws s3 ls s3://$Bucket --recursive --human-readable --summarize --output text | grep $file)

if [[ $fileCheck == "/$file ]]
then 
echo "Smile pl, your file has uploaded" 
else 
echo "error occured while uploading file"
fi
