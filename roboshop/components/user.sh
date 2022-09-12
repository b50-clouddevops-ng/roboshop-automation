#!/bin/bash

echo "I am in User !!"

#Validate if any script fail don't go to the next line.
set -e

source components/common.sh

echo -n "Configure yum repos for nodejs :"
curl -sL https://rpm.nodesource.com/setup_lts.x | bash >> /tmp/user.log
stat $?

echo -n "Install Nodejs :"
yum install nodejs -y >> /tmp/user.log
stat $?

echo -n "adding a user call roboshot :"
id roboshop || useradd roboshop
stat $?

echo -n "Downloading the components :"
curl -s -L -o /tmp/user.zip "https://github.com/stans-robot-project/user/archive/main.zip" >> /tmp/user.log
stat $?

echo -n "Cleanup of old cataloge contents :"
rm -rf /home/roboshop/user/
stat $?


echo -n "Extracting cataloge contents :"
cd /home/roboshop 
unzip /tmp/user.zip >> /tmp/nodejs.log && mv user-main user
stat $?

echo -n "change the ownership of roboshop"
chown -R  roboshop:roboshop user/ 
stat $?


echo -n "Install nodeJS  dependencies:"
cd /home/roboshop/user
npm install &>> /tmp/user.log
stat $?