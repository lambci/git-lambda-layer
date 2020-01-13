#!/bin/sh

. ./config.sh

rm layer.zip

docker run --rm -v "$PWD":/tmp/layer lambci/yumda:2 bash -c "
  yum install -y git-${GIT_VERSION} && \
  cd /lambda/opt && \
  zip -yr /tmp/layer/layer.zip .
"
