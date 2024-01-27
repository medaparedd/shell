#!/bin/bash
R="\e[31m"
G="\e[32m"
Y="\e[33m"
N="\e[0m"
timestamp=$(date +%F-%H-%M-%S)
LOGFILE="/tmp/$0-$timestamp.logs"
n1=$1
n2=$2
sum=$(($n1+$n2)) &>> $LOGFILE
echo -e "$Y $sum $N"
echo -e "$Y $0 $N"
echo -e "$Y $@ $N"
echo -e "$Y $#"
echo "$timestamp"
if [ $n1 -gt $n2 ]
then
    echo -e "$G number1 is greater $N"
else
    echo -e "$R number1 is less $N"
fi