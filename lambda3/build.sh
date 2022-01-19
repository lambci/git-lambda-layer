#!/bin/sh

. ./config.sh

rm layer.zip

docker run --rm -v "$PWD":/tmp/layer lambci/yumda:2 bash -c "
  yum install -y git.x86_64 && \
  yum -y install python3 && \
  yum -y install python3-pip && \
  cd /lambda/opt && \
  zip -yr /tmp/layer/layer.zip .
"
