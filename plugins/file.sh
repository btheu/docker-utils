#!/bin/bash


BASH_VERSION=busybox

d_file_pull(){

  local FILE_FROM=$1
  local FILE_TO=$2
  local BASH_CMD=$@

  echo "BASH_VERSION        $BASH_VERSION"
  echo "FILE_FROM           $FILE_FROM"
  echo "FILE_TO             $FILE_TO"
  echo "BUILDER_VOLUME      $BUILDER_VOLUME"
  docker run -it --rm -v $BUILDER_VOLUME:/source -w /source -v $(pwd):/workspace $BASH_VERSION sh -cl "cp -vrf $FILE_FROM /workspace/$FILE_TO"
}

d_file_push(){

  local FILE_FROM=$1
  local FILE_TO=$2
  local BASH_CMD=$@

  echo "BASH_VERSION        $BASH_VERSION"
  echo "FILE_FROM           $FILE_FROM"
  echo "FILE_TO             $FILE_TO"
  echo "BUILDER_VOLUME      $BUILDER_VOLUME"
  docker run -it --rm -v $BUILDER_VOLUME:/source -w /source -v $(pwd):/workspace $BASH_VERSION sh -cl "cp -vrf /workspace/$FILE_FROM $FILE_TO"
}
