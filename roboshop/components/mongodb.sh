#!/bin/bash
echo "I am in MongoDb"

#Validate if any script fail, don't go to the next line.
set -e

#Call the common functions
source components/common.sh

echo -n "1. Setup MongoDB repos"
curl -s -o /etc/yum.repos.d/mongodb.repo https://raw.githubusercontent.com/stans-robot-project/mongodb/main/mongo.repo
stat $?

echo -n "2. Install Mongo & Start Service."
yum install -y mongodb-org
stat $?

systemctl -n enable mongod
echo -n " start mongodb "
systemctl start mongod
stat $?


