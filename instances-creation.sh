#!/bin/bash

AMI=ami-0f3c7d07486cad139
instance_type=t2.micro
sg_id=sg-068a60ba9afcd3d41
subnet_id=subnet-02f930c84fb2f785d

instances=("mongodb" "cart" "user" "redis" "catalogue" "rabbitmq" "payment" "shipping" "mysql" "web")

for i in $(instances[@])
do
  if [ $i == mongodb ] || [ $i == shipping ] || [ $i == mysql ]
  then
      instance_type=t3.small
  else
      instance_type=t2.micro
  fi

  aws ec2 run-instances --image-id $AMI --count 1 --instance-type $instance_type  --security-group-ids $sg_id --subnet-id $subnet_id
done


