#!/bin/bash

## NODE

NODE_VERSION=dmitry7887/alpine-node-git
##node:7-alpine

d_node(){

  local NODE_CMD=$@

  echo "NODE_CMD        $NODE_CMD"
  echo "NODE_VERSION    $NODE_VERSION"
  echo "BUILDER_VOLUME  $BUILDER_VOLUME"
  docker run -it --rm -v $BUILDER_VOLUME:/source -w /source $NODE_VERSION $NODE_CMD
}
