#!/bin/bash

echo "I am in catalogue !!"

#Validate if any script fail don't go to the next line.
set -e

source components/common.sh

echo -n "Configure yum repos for nodejs :"
curl -sL https://rpm.nodesource.com/setup_lts.x | bash >> /tmp/nodejs.log
stat $?

echo -n "Install Nodejs :"
yum install nodejs -y >> /tmp/nodejs.log
stat $?

echo -n "adding a user call roboshot :"
id roboshop || useradd roboshop
stat $?

echo -n "Downloading the components :"
curl -s -L -o /tmp/catalogue.zip "https://github.com/stans-robot-project/catalogue/archive/main.zip" >> /tmp/nodejs.log
stat $?

echo -n "Cleanup of old cataloge contents :"
rm -rf /home/roboshop/catalogue/
stat $?


echo -n "Extracting cataloge contents :"
cd /home/roboshop 
unzip /tmp/catalogue.zip >> /tmp/nodejs.log && mv catalogue-main catalogue
stat $?

#Instead of switching the user change the file ownership.
#After extracting the catalogue component as a root we need to change the file permission from root to roboshop .
# [ root@catalogue /home/roboshop ]# ls -ltr
# total 0
# drwxr-xr-x 2 root root 83 Jun 22 06:18 catalogue

echo -n "change the ownership of roboshop"
chown -R  roboshop:roboshop catalogue/ 
stat $?


echo -n "Install nodeJS  dependencies:"
cd /home/roboshop/catalogue
npm install &>> /tmp/nodejs.log
stat $?

echo -n "Configuring the systemd file :"
sed -i -e 's/MONGO_DNSNAME/172.31.12.127/' /home/roboshop/catalogue/systemd.service
mv /home/roboshop/catalogue/systemd.service /etc/systemd/system/catalogue.service
stat $?

echo -n " Reload the daemon:"
systemctl daemon-reload
stat $?

echo -n "Start the catalogue :"
systemctl start catalogue
stat $?

echo -n "Enable the catalogue :"
systemctl enable catalogue
stat $?

systemctl status catalogue -l

