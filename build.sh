#!/bin/sh

export GIT_VERSION=2.19.2

docker build --build-arg GIT_VERSION -t git-lambda-layer .
docker run --rm git-lambda-layer cat /tmp/git-${GIT_VERSION}.zip > ./layer.zip
