#!/bin/bash
ID=$(id -u)
R="\e[31m"
G="\e[32m"
Y="\e[33m"
N="\e[0m"
TIMESTAMP=$(date +%F-%H-%M-%S)
LOGFILE="/tmp/$0-$TIMESTAMP.log"

echo -e "$TIMESTAMP"

if [ $ID -ne 0 ]
then
   echo -e "$R please run with root user"
   exit 1
else
   echo -e "$G YES YOU R ROOT USER $N"
fi
VALIDATE(){
    if [ $1 -ne 0 ]
    then
        echo -e "$2 failed"
        exit 1
    else
        echo -e "$2 success"
    fi
}

dnf module disable nodejs -y
VALIDATE $? "installed" &>> $LOGFILE
dnf module enable nodejs:18 -y
VALIDATE $? "installed" &>> $LOGFILE
dnf install nodejs -y
VALIDATE $? "installed" &>> $LOGFILE
useradd roboshop
VALIDATE $? "installed" &>> $LOGFILE
mkdir /app
VALIDATE $? "installed" &>> $LOGFILE
curl -o /tmp/catalogue.zip https://roboshop-builds.s3.amazonaws.com/catalogue.zip
VALIDATE $? "installed" &>> $LOGFILE
cd /app 
VALIDATE $? "installed" &>> $LOGFILE
unzip /tmp/catalogue.zip
VALIDATE $? "installed" &>> $LOGFILE
npm install
VALIDATE $? "installed" &>> $LOGFILE
cp /home/centos/shell/catalogue.service /etc/systemd/system/catalogue.service
VALIDATE $? "installed" &>> $LOGFILE
systemctl daemon-reload
VALIDATE $? "installed" &>> $LOGFILE
systemctl enable catalogue
VALIDATE $? "installed" &>> $LOGFILE
systemctl start catalogue
VALIDATE $? "installed" &>> $LOGFILE
cp /home/centos/shell/mongo.repo /etc/yum.repos.d/mongo.repo
VALIDATE $? "installed" &>> $LOGFILE
dnf install mongodb-org-shell -y
VALIDATE $? "installed" &>> $LOGFILE
mongo --host mongodb.daws74s.online </app/schema/catalogue.js
VALIDATE $? "installed" &>> $LOGFILE