#!/bin/bash

. ./config.sh

REGIONS="$(aws ssm get-parameters-by-path --path /aws/service/global-infrastructure/services/lambda/regions \
  --query 'Parameters[].Value' --output text | tr '[:blank:]' '\n' | grep -v -e ^cn- -e ^us-gov- | sort -r)"

for region in $REGIONS; do
  aws lambda list-layer-versions --region $region --layer-name $LAYER_NAME \
    --query 'LayerVersions[*].[LayerVersionArn]' --output text
done
