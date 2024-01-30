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
dnf install nginx -y &>> $LOGFILE
VALIDATE $? "installed" 
systemctl enable nginx &>> $LOGFILE
VALIDATE $? "installed" 
systemctl start nginx &>> $LOGFILE
VALIDATE $? "installed" 
rm -rf /usr/share/nginx/html/* &>> $LOGFILE
VALIDATE $? "installed" 
curl -o /tmp/web.zip https://roboshop-builds.s3.amazonaws.com/web.zip &>> $LOGFILE
VALIDATE $? "installed" 
cd /usr/share/nginx/html &>> $LOGFILE
VALIDATE $? "installed" 
unzip -o /tmp/web.zip &>> $LOGFILE
VALIDATE $? "installed" 
cp /home/centos/shell/roboshop.conf /etc/nginx/default.d/roboshop.conf &>> $LOGFILE
VALIDATE $? "installed" 
systemctl restart nginx &>> $LOGFILE
VALIDATE $? "installed" 