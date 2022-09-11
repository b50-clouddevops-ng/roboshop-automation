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
stat $?

echo -n "Download the schema :"
curl -s -L -o /tmp/frontend.zip "https://github.com/stans-robot-project/frontend/archive/main.zip"
stat $?

cd /usr/share/nginx/html && rm -rf *

echo -n "Extract the script"
unzip -o /tmp/frontend.zip >> /tmp/frontend.log
stat $?

echo -n "Move the script to ngnix"
mv frontend-main/* . && mv static/* . 
stat $?

echo -n "Remove the unnessary file from /tmp file"
rm -rf frontend-main README.md
stat $?

echo -n "Cofiguring the Reverse Proxy"
mv localhost.conf /etc/nginx/default.d/roboshop.conf
stat $?

echo -n "Restarting Ngnix :"
systemctl restart nginx
stat $?
