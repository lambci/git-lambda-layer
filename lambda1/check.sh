#!/bin/bash

# eg: ./check.sh 3

LAYER_NAME=git

REGIONS="$(aws ssm get-parameters-by-path --path /aws/service/global-infrastructure/services/lambda/regions \
  --query 'Parameters[].Value' --output text | tr '[:blank:]' '\n' | grep -v -e ^cn- -e ^us-gov- | sort -r)"

for region in $REGIONS; do
  echo $(aws lambda get-layer-version --region $region --layer-name $LAYER_NAME --version-number $1 \
    --query Content.CodeSha256 --output text 2>/dev/null) $region &
done

for job in $(jobs -p); do
  wait $job
done
