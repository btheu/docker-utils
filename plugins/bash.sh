#!/bin/bash

## MAVEN

BASH_VERSION=busybox

d_bash(){

  local BASH_CMD=$@

  echo "BASH_CMD            $BASH_CMD"
  echo "BASH_VERSION        $BASH_VERSION"
  echo "BUILDER_VOLUME      $BUILDER_VOLUME"
  docker run -it --rm -v $BUILDER_VOLUME:/source -w /source $BASH_VERSION sh -cl "$BASH_CMD"
}
