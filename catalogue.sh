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

dnf module disable nodejs -y &>> $LOGFILE
VALIDATE $? "installed" 
dnf module enable nodejs:18 -y &>> $LOGFILE
VALIDATE $? "installed" 
dnf install nodejs -y &>> $LOGFILE
VALIDATE $? "installed" 
id=roboshop
if [ $id -ne 0 ]
then
    useradd roboshop &>> $LOGFILE
    VALIDATE $? "installed" 
else
    echo "its already exists"
fi

mkdir -p /app &>> $LOGFILE
VALIDATE $? "installed" 
curl -o /tmp/catalogue.zip https://roboshop-builds.s3.amazonaws.com/catalogue.zip &>> $LOGFILE
VALIDATE $? "installed" 
cd /app &>> $LOGFILE
VALIDATE $? "installed"
unzip -o /tmp/catalogue.zip 
VALIDATE $? "installed" 
npm install &>> $LOGFILE
VALIDATE $? "installed" 
cp /home/centos/shell/catalogue.service /etc/systemd/system/catalogue.service &>> $LOGFILE
VALIDATE $? "installed" 
systemctl daemon-reload &>> $LOGFILE
VALIDATE $? "installed"  
systemctl enable catalogue &>> $LOGFILE
VALIDATE $? "installed" 
systemctl start catalogue &>> $LOGFILE
VALIDATE $? "installed" 
cp /home/centos/shell/mongo.repo /etc/yum.repos.d/mongo.repo &>> $LOGFILE
VALIDATE $? "installed" 
dnf install mongodb-org-shell -y &>> $LOGFILE
VALIDATE $? "installed" 
mongo --host mongodb.daws74s.online </app/schema/catalogue.js &>> $LOGFILE
VALIDATE $? "installed" 