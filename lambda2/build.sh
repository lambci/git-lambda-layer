#!/bin/sh

. ./config.sh

rm layer.zip

docker run --rm -v "$PWD":/tmp/layer lambci/yumda:2 bash -c "
  yum install -y git-${GIT_VERSION} openssl-libs openssl-devel && \
  cd /lambda/opt && \
  # Copy required OpenSSL libraries
  mkdir -p lib && \
  cp -a /usr/lib64/libcrypto.so* lib/ && \
  cp -a /usr/lib64/libssl.so* lib/ && \
  zip -yr /tmp/layer/layer.zip .
"
