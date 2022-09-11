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

# echo -n "Enable MongoDB :"
# systemctl -n enable mongod
# stat $?

echo -n "Start mongodb :"
systemctl start mongod
stat $?

echo -n "Updating mongodb configuration file :"
sed -i -e 's/127.0.0.1/0.0.0.0/' /etc/mongod.conf
stat $?

echo -n " Restart mongodb :"
systemctl restart mongod
stat $?

echo -n "Download the mongodb schema :"
curl -s -L -o /tmp/mongodb.zip "https://github.com/stans-robot-project/mongodb/archive/main.zip"
stat $?

echo -n "Extracting mongodb schema :"
cd /tmp && unzip -o mongodb.zip
cd mongodb-main  
stat $?

echo -n "Injecting the schema :"
mongo < catalogue.js >> /tmp/mongodb.log
mongo < users.js >> /tmp/mongodb.log

echo "---------MomgoDB configuration completed.------------"


