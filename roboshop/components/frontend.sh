#!/bin/bash

echo "I am in frontend !!"

#Validate if any script fail don't go to the next line.
set -e

source components/common.sh

echo -n "Installing Nginx :"
yum install nginx -y >> /tmp/frontend.log
stat $?

systemctl enable nginx

echo -n "Starting Nginx :"
systemctl start nginx
star $?

echo -n "Download the schema"
curl -s -L -o /tmp/frontend.zip "https://github.com/stans-robot-project/frontend/archive/main.zip"
stat $?

cd /usr/share/nginx/html
rm -rf *
unzip -o /tmp/frontend.zip >> /tmp/frontend.log
mv frontend-main/* .
mv static/* .
rm -rf frontend-main README.md
mv localhost.conf /etc/nginx/default.d/roboshop.conf

systemctl restart nginx
