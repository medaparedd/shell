#!/bin/bash
R="\e[31m"
G="\e[32m"
Y="\e[33m"

echo "$0"
echo "$#"
echo "$@"

DISKUSAGE=$(df -hT)
DISK_THRESHOLD=1
