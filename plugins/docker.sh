#!/bin/bash

## BUILD IMAGE

DOCKER_DOCKERFILE="Dockerfile"
DOCKER_CONTEXT="."

DOCKER_VERSION=docker:17

DOCKER_TAGS=

DOCKER_REPO=

d_docker(){

  DOCKER_IMAGE=$DOCKER_REPO/${BUILDER_APPLI_NAME// /-}
  
  export DOCKER_IMAGE=${DOCKER_IMAGE,,} # lowercase
  
  local TAGS=""
  for tag in $DOCKER_TAGS
  do
    TAGS="$TAGS -t $DOCKER_IMAGE:$tag"
  done

  echo "DOCKER             $TAGS"
  echo "DOCKER_VERSION     $DOCKER_VERSION"
  echo "DOCKER_IMAGE       $DOCKER_IMAGE"
  echo "DOCKER_CONTEXT     $DOCKER_CONTEXT"
  echo "BUILDER_VOLUME     $BUILDER_VOLUME"
  echo "BUILDER_WORKSPACE  $BUILDER_WORKSPACE"

  docker run -it --rm -v $BUILDER_WORKSPACE:/context/workspace  -v $BUILDER_VOLUME:/context/volume -v /var/run/docker.sock:/var/run/docker.sock -w /context $DOCKER_VERSION docker build $DOCKER_CONTEXT -f /context/workspace/$DOCKER_DOCKERFILE $TAGS
}
