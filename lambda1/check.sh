#!/bin/bash

REGIONS='
ap-northeast-1
ap-northeast-2
ap-south-1
ap-southeast-1
ap-southeast-2
ca-central-1
eu-central-1
eu-west-1
eu-west-2
eu-west-3
sa-east-1
us-east-1
us-east-2
us-west-1
us-west-2
'

for region in $REGIONS; do
  echo $(curl -sSL $(aws lambda get-layer-version --region $region --layer-name git --version-number $1 \
    --query Content.Location --output text 2>/dev/null) 2>/dev/null | wc -c) $region &
done

for job in $(jobs -p); do
  wait $job
done
