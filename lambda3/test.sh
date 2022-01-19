#!/bin/sh

rm -rf layer && unzip layer.zip -d layer

cd test

#docker run --rm -v "$PWD":/var/task -v "$PWD"/../layer:/opt lambci/yumda:2 python /var/task/main.py
docker run --rm -v "$PWD":/var/task -v "$PWD"/../layer:/opt lambci/yumda:2 bash /var/task/docker.test.sh

