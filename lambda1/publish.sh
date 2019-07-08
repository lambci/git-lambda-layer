#!/bin/bash

GIT_VERSION=2.21.0

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
  aws lambda add-layer-version-permission --region $region --layer-name git \
    --statement-id sid1 --action lambda:GetLayerVersion --principal '*' \
    --version-number $(aws lambda publish-layer-version --region $region --layer-name git --zip-file fileb://layer.zip \
      --description "Git ${GIT_VERSION} and openssh binaries" --query Version --output text)
done
