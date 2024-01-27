#!/bin/bash
R="\e[31m"
G="\e[32m"
Y="\e[33m"
N="\e[0m"
n1=$1
n2=$2
sum=$(($n1+$n2))
echo -e "$Y $sum $N"
echo -e "$Y $0 $N"
echo -e "$Y $@ $N"
echo -e "$Y $#"
if [ $n1 -gt $n2 ]
then
    echo -e "$G number1 is greater $N"
else
    echo -e "$R number1 is less $N"
fi