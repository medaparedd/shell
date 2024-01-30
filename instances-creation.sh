#!/bin/bash

AMI=ami-0f3c7d07486cad139
instance_type=t2.micro
sg_id=sg-068a60ba9afcd3d41
subnet_id=subnet-02f930c84fb2f785d
ZONE_ID=Z0840714YB8BFEL4YBKP
DOMAIN_NAME="daws74s.online"
instances=("mongodb" "cart" "user" "redis" "catalogue" "rabbitmq" "payment" "shipping" "mysql" "web")

for i in "${instances[@]}"
do
  if [ $i == mongodb ] || [ $i == shipping ] || [ $i == mysql ]
  then
      instance_type=t3.small
  else
      instance_type=t2.micro
  fi

 IP_ADDRESS=$(aws ec2 run-instances --image-id $AMI --instance-type $INSTANCE_TYPE --security-group-ids $sg_id --tag-specifications "ResourceType=instance,Tags=[{Key=Name,Value=$i}]" --query 'Instances[0].PrivateIpAddress' --output text)
    echo "$i: $IP_ADDRESS"
  aws route53 change-resource-record-sets \
    --hosted-zone-id $ZONE_ID \
    --change-batch '
    {
        "Comment": "Creating a record set for cognito endpoint"
        ,"Changes": [{
        "Action"              : "UPSERT"
        ,"ResourceRecordSet"  : {
            "Name"              : "'$i'.'$DOMAIN_NAME'"
            ,"Type"             : "A"
            ,"TTL"              : 1
            ,"ResourceRecords"  : [{
                "Value"         : "'$IP_ADDRESS'"
            }]
        }
        }]
    }
        '
 


done


