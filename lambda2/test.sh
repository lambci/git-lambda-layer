#!/bin/sh

rm -rf layer && unzip layer.zip -d layer

cd test

docker run --rm -v "$PWD":/var/task -v "$PWD"/../layer:/opt lambci/lambda:nodejs10.x index.handler

