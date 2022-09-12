#!/bin/bash
echo "I am in MongoDb"

#Validate if any script fail, don't go to the next line.
set -e

#Call the common functions
source components/common.sh


echo  -n "Get the repos"
curl -L https://raw.githubusercontent.com/stans-robot-project/redis/main/redis.repo -o /etc/yum.repos.d/redis.repo >> /tmp/redish.log
stat $?

echo  -n "Install redish"
yum install redis-6.2.7 -y >> /tmp/redish.log
stat $?


sed -i -e 's/127.0.0/0.0.0.0' /etc/redis.conf

echo  -n "Enable redish : "
systemctl enable redis
stat $?

echo  -n "Start redish : "
systemctl start redis
stat $?

systemctl status redis -l

