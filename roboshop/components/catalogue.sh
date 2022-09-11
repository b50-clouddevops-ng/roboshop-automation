#!/bin/bash

echo "I am in catalogue !!"

#Validate if any script fail don't go to the next line.
set -e

source components/common.sh

echo -n "Configure yum repos for nodejs :"
curl -sL https://rpm.nodesource.com/setup_lts.x | bash >> /tmp/nodejs.log
stat $?

echo -n "Install Nodejs :"
yum install nodejs -y >> /tmp/nodejs.log
stat $?

echo -n "adding a user call roboshot :"
id roboshop || useradd roboshop
stat $?

echo -n "Downloading the components :"
curl -s -L -o /tmp/catalogue.zip "https://github.com/stans-robot-project/catalogue/archive/main.zip" >> /tmp/nodejs.log
stat $?

echo -n "Cleanup of old cataloge contents :"
rm -rf /home/roboshop/catalogue/
stat $?


echo -n "Extracting cataloge contents :"
cd /home/roboshop && unzip /tmp/catalogue.zip >> /tmp/nodejs.log && mv catalogue-main catalogue
stat $?

#After extracting the catalogue component as a root we need to change the file permission from centos to roboshop user.
drwxr-xr-x 3 root root 128 Sep 11 17:18 catalogue

echo -n "change the ownership to roboshop"
chmod roboshop:roboshop catalogue/ 


echo -n "Install nodeJS  dependencies:"
cd /home/roboshop/catalogue
npm install >> /tmp/nodejs.log
stat $?