#!/bin/bash
ID=$(id -u)
R="\e[31m"
G="\e[32m"
Y="\e[33m"
N="\e[0m"
TIMESTAMP=$(date +%F-%H-%M-%S)
LOGFILE="/tmp/$0-$TIMESTAMP.log"
echo -e "$Y $0 $N"
echo -e "$Y $#"
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
for package in $@
do 
 yum list installed $package
 if [ $? -ne 0 ]
 then
   yum install $package -y &>> $LOGFILE
else
  echo -e "$package is already installed $Y skip it" 
fi
done
  


 


