#!/bin/sh

export GIT_VERSION=2.20.0

LAYER_VERSION=$(aws lambda publish-layer-version --layer-name git --zip-file fileb://layer.zip \
  --description "Git ${GIT_VERSION} and openssh binaries" --query Version --output text)

echo "Published version ${LAYER_VERSION}"

aws lambda add-layer-version-permission --layer-name git --version-number $LAYER_VERSION \
  --statement-id sid1 --action lambda:GetLayerVersion --principal '*'
