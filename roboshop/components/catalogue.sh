#!/bin/bash

echo "I am in frontend !!"

#Validate if any script fail don't go to the next line.
set -e

source components/common.sh

curl -sL https://rpm.nodesource.com/setup_lts.x | bash

echo -n "Install Nodejs :"
yum install nodejs -y >> /tmp/nodejs.log
stat $?

echo "Create a user call roboshot :"
useradd roboshop
stat $?

