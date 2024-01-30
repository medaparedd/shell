#!/bin/bash

ID=$(id -u)
R="\e[31m"
G="\e[32m"
Y="\e[33m"
N="\e[0m"
MONGDB_HOST=mongodb.daws74s.online

TIMESTAMP=$(date +%F-%H-%M-%S)
LOGFILE="/tmp/$0-$TIMESTAMP.log"

echo "script stareted executing at $TIMESTAMP" &>> $LOGFILE

VALIDATE(){
    if [ $1 -ne 0 ]
    then
        echo -e "$2 ... $R FAILED $N"
        exit 1
    else
        echo -e "$2 ... $G SUCCESS $N"
    fi
}

if [ $ID -ne 0 ]
then
    echo -e "$R ERROR:: Please run this script with root access $N"
    exit 1 # you can give other than 0
else
    echo "You are root user"
fi 

dnf install maven -y &>> $LOGFILE
VALIDATE $? "installed" 
id roboshop #if roboshop user does not exist, then it is failure
if [ $? -ne 0 ]
then
    useradd roboshop &>> $LOGFILE
    VALIDATE $? "roboshop user creation"
else
    echo -e "roboshop user already exist $Y SKIPPING $N"
fi
mkdir -p /app &>> $LOGFILE
VALIDATE $? "installed" 
curl -L -o /tmp/shipping.zip https://roboshop-builds.s3.amazonaws.com/shipping.zip &>> $LOGFILE
VALIDATE $? "installed" 
cd /app &>> $LOGFILE
VALIDATE $? "installed" 
unzip -o /tmp/shipping.zip &>> $LOGFILE
VALIDATE $? "installed" 
mvn clean package &>> $LOGFILE
VALIDATE $? "installed" 
mv target/shipping-1.0.jar shipping.jar &>> $LOGFILE
VALIDATE $? "installed" 
cp /home/centos/shell/shipping.service /etc/systemd/system/shipping.service &>> $LOGFILE
VALIDATE $? "installed" 
systemctl daemon-reload &>> $LOGFILE
VALIDATE $? "installed" 
systemctl enable shipping &>> $LOGFILE
VALIDATE $? "installed" 
systemctl start shipping &>> $LOGFILE
VALIDATE $? "installed" 
dnf install mysql -y &>> $LOGFILE
VALIDATE $? "installed" 
mysql -h mysql.daws74s.online -uroot -pRoboShop@1 < /app/schema/shipping.sql &>> $LOGFILE
VALIDATE $? "installed" 
systemctl restart shipping&>> $LOGFILE
VALIDATE $? "installed" 
