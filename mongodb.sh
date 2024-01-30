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
    else
        echo -e "$2 success"
    fi
}
cp mongo.repo /etc/yum.repos.d/mongo.repo &>> $LOGFILE
VALIDATE $? 
dnf install mongodb-org -y &>> $LOGFILE
VALIDATE $? 
systemctl enable mongod &>> $LOGFILE
VALIDATE $? 
systemctl start mongod &>> $LOGFILE
VALIDATE $? 
sed -i 's/127.0.0.1/0.0.0.0/g' /etc/mongod.conf &>> $LOGFILE
VALIDATE $? 
systemctl restart mongod &>> $LOGFILE
VALIDATE $? 