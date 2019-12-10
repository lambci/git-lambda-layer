#!/bin/sh

export GIT_VERSION=2.24.1

rm layer.zip

docker run --rm -v "$PWD":/tmp/layer lambci/yumda:1 bash -c "
  yum install -y git-${GIT_VERSION} && \
  cd /lambda/opt && \
  zip -yr /tmp/layer/layer.zip .
"
