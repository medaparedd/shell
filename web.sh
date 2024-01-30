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
dnf install nginx -y
VALIDATE $? "installed" &>> $LOGFILE
systemctl enable nginx
VALIDATE $? "installed" &>> $LOGFILE
systemctl start nginx
VALIDATE $? "installed" &>> $LOGFILE
rm -rf /usr/share/nginx/html/*
VALIDATE $? "installed" &>> $LOGFILE
curl -o /tmp/web.zip https://roboshop-builds.s3.amazonaws.com/web.zip
VALIDATE $? "installed" &>> $LOGFILE
cd /usr/share/nginx/html
VALIDATE $? "installed" &>> $LOGFILE
unzip /tmp/web.zip
VALIDATE $? "installed" &>> $LOGFILE
cp roboshop.conf /etc/nginx/default.d/roboshop.conf 
VALIDATE $? "installed" &>> $LOGFILE
systemctl restart nginx 
VALIDATE $? "installed" &>> $LOGFILE