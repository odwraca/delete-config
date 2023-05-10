#!/bin/bash

# Set AWS profile
echo -n "Enter AWS profile name: "
read aws_profile

# Set regions to check
regions=(us-east-1 us-east-2 us-west-1)

# Loop through regions
for region in "${regions[@]}"
do
    # Get delivery channels in region
    delivery_channels=$(aws configservice describe-delivery-channels --region $region --profile $aws_profile)

    # Print delivery channels
    echo "Delivery Channels in $region:"
    echo $delivery_channels
    echo ""

    # Get configuration recorders in region
    recorders=$(aws configservice describe-configuration-recorders --region $region --profile $aws_profile)

    # Print configuration recorders
    echo "Configuration Recorders in $region:"
    echo $recorders
    echo ""
done