#!/bin/bash

set -e

# Build the deployment wrapper docker image
docker build . -t wrapper

# Destroy
docker run --rm --privileged -it \
  -e NUKE_CONFIG_FOLDER=$(pwd)/terraform \
  -v $(pwd):/workdir \
  -v /var/run/docker.sock:/var/run/docker.sock\
  -w /workdir wrapper \
  sh terraform/destroy.sh
