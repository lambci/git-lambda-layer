#!/bin/bash

LAYER_NAME=git-lambda2

REGIONS="$(aws ssm get-parameters-by-path --path /aws/service/global-infrastructure/services/lambda/regions \
  --query 'Parameters[].Value' --output text | tr '[:blank:]' '\n' | grep -v -e ^cn- -e ^us-gov- | sort -r)"

for region in $REGIONS; do
  echo $(curl -sSL $(aws lambda get-layer-version --region $region --layer-name $LAYER_NAME --version-number $1 \
    --query Content.Location --output text 2>/dev/null) 2>/dev/null | wc -c) $region &
done

for job in $(jobs -p); do
  wait $job
done
