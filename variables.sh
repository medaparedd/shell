#!/bin/bash
n1=$1
n2=$2
sum=$(($n1+$n2))
echo "$sum"
echo "$0"
echo "$@"
echo "$#"
if [ $n1 -gt $n2 ]
then
    echo "number1 is greater"
else
    echo "number1 is less"
fi