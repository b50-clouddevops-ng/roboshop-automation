#!/bin/bash
echo "I am in MongoDb"

#Validate if any script fail, don't go to the next line.
set -e

#Call the common functions
source components/common.sh

echo -n "Setup MongoDB repos : "
curl -s -o /etc/yum.repos.d/mongodb.repo https://raw.githubusercontent.com/stans-robot-project/mongodb/main/mongo.repo
stat $?

echo -n "Install Mongodb : "
yum install -y mongodb-org >> /tmp/mongodb.log
stat $?

systemctl -n enable mongod
echo -n "Start mongodb :"
systemctl start mongod
stat $?


