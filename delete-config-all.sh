#!/bin/bash

# Set AWS profile
echo -n "Enter AWS profile name: "
read aws_profile

# Set regions to check
regions=(us-east-1 us-east-2 us-west-1 us-west-2 ap-south-1 ap-northeast-3 ap-northeast-2 ap-northeast-1 ap-southeast-1 ap-southeast-2 ca-central-1 eu-central-1 eu-west-1 eu-west-2 eu-west-3 eu-north-1 sa-east-1)

# Stop all existing configuration recorders
echo "Stopping all existing configuration recorders..."
for region in "${regions[@]}"
do
    recorders=$(aws configservice describe-configuration-recorders --region $region --profile $aws_profile --query "ConfigurationRecorders[].name" --output text)
    for recorder in $recorders
    do
        echo "Stopping configuration recorder $recorder in $region"
        aws configservice stop-configuration-recorder --region $region --profile $aws_profile --configuration-recorder-name $recorder
    done
done
echo "All existing configuration recorders have been stopped."

# Delete all delivery channels
echo "Deleting all delivery channels..."
for region in "${regions[@]}"
do
    delivery_channels=$(aws configservice describe-delivery-channels --region $region --profile $aws_profile --query "DeliveryChannels[].name" --output text)
    for channel in $delivery_channels
    do
        echo "Deleting delivery channel $channel in $region"
        aws configservice delete-delivery-channel --region $region --profile $aws_profile --delivery-channel-name $channel
    done
done
echo "All delivery channels have been deleted."

# Delete all configuration recorders
echo "Deleting all configuration recorders..."
for region in "${regions[@]}"
do
    recorders=$(aws configservice describe-configuration-recorders --region $region --profile $aws_profile --query "ConfigurationRecorders[].name" --output text)
    for recorder in $recorders
    do
        echo "Deleting configuration recorder $recorder in $region"
        aws configservice delete-configuration-recorder --region $region --profile $aws_profile --configuration-recorder-name $recorder
    done
done
echo "All configuration recorders have been deleted."
