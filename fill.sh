#!/bin/bash
ID=$(id -u)
R="\e[31m"
G="\e[32m"
Y="\e[33m"
N="\e[0m"

TIMESTAMP=$(date +%F-%H-%M-%S)
LOGFILE="/tmp/$0-$TIMESTAMP.log"

echo -e "$G $0"
echo -e "$G $#"

if [ $ID -ne 0 ]
then
    echo -e  "$R you are not a root user, so please run with rootuser"
    exit 1
else
    echo -e "$G you are root user, you can go for further process"
fi

VALIDATE(){
    if [ $1 -ne 0 ]
    then 
        echo -e "$R $2 failed"
        exit 1
    else
        echo -e "$G $2 success"
    fi
}

echo -e "$Y enter the package name you want to install"
read $package_name
yum install $package_name -y
VALIDATE $? "installing $package_name"
