#!/bin/sh

. ./config.sh

rm layer.zip

docker run --rm -v "$PWD":/tmp/layer lambci/yumda:2 bash -c "
  curl -sSf 'https://packagecloud.io/install/repositories/github/git-lfs/config_file.repo?os=amzn&dist=2&source=script' > /lambda/etc/yum.repos.d/github_git-lfs.repo && \
  yum -q makecache -y --disablerepo='*' --enablerepo='github_git-lfs' --enablerepo='github_git-lfs-source' && \
  yum install -y git-${GIT_VERSION} git-lfs-${GIT_LFS_VERSION} && \
  mv /lambda/usr/bin/git-lfs /lambda/opt/bin/git-lfs && \
  cd /lambda/opt && \
  zip -yr /tmp/layer/layer.zip .
"
