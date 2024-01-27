#!/bin/bash
ID=$(id -u)
R="\e[31m"
G="\e[32m"
Y="\e[33m"
N="\e[0m"
timestamp=$(date +%F-%H-%M-%S)
LOGFILE="/tmp/$0-$timestamp.log"
echo -e "$Y $0 $N"
echo -e "$Y $#"
echo -e "$timestamp"
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
yum install mysql -y
VALIDATE $? "INSTALLING MYSQL" &>> $LOGFILE
yum install git -y
VALIDATE $? "INSTALLING GIT" &>> $LOGFILE
