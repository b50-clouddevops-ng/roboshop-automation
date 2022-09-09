#!/bin/bash

echo "I am in frontend !!"

#Validate if any script fail don't go to the next line.
set -e

source components/common.sh

echo "Installing Nginx :"
yum install nginx -y >> /tmp/frontend.log
if [ $? -eq 0 ]; then
    echo -e "\e[32m SUCCESS \e[0m"
else 
    echo -e "\e[31m Failure. Look for the log \e[0m"
fi

systemctl enable nginx

echo "Starting Nginx :"
systemctl start nginx
if [ $? -eq 0 ]; then
    echo -e "\e[32m SUCCESS \e[0m"
else 
    echo -e "\e[31m Failure. Look for the log \e[0m"
fi

echo "Download the schema"
curl -s -L -o /tmp/frontend.zip "https://github.com/stans-robot-project/frontend/archive/main.zip"
if [ $? -eq 0 ]; then
    echo -e "\e[32m SUCCESS \e[0m"
else 
    echo -e "\e[32m FAIL \e[0m"
fi

cd /usr/share/nginx/html
rm -rf *
unzip -o /tmp/frontend.zip >> /tmp/frontend.log
mv frontend-main/* .
mv static/* .
rm -rf frontend-main README.md
mv localhost.conf /etc/nginx/default.d/roboshop.conf

systemctl restart nginx
