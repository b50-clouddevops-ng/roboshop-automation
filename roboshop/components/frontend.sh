#!/bin/bash

echo "I am in frontend !!"

#Validate if any script fail don't go to the next line.
set -e

source components/common.sh

echo "Installing Nginx :"
yum install nginx -y >> /tmp/frontend.log
systemctl enable nginx

echo "Starting Nginx :"
systemctl start nginx

echo "Download the frontend.zip to the /tmp"
curl -s -L -o /tmp/frontend.zip "https://github.com/stans-robot-project/frontend/archive/main.zip"

cd /usr/share/nginx/html
rm -rf *
unzip /tmp/frontend.zip >> /tmp/frontend.log
mv frontend-main/* .
mv static/* .
rm -rf frontend-main README.md
mv localhost.conf /etc/nginx/default.d/roboshop.conf

systemctl restart nginx
