#!/bin/bash

## BUILD IMAGE

DOCKER_CONTEXT=$BUILDER_TARGET

DOCKER_DOCKERFILE="$BUILDER_WORKSPACE/Dockerfile"

DOCKER_VERSION=docker:17

DOCKER_TAGS=

DOCKER_REPO=

d_docker(){

  DOCKER_IMAGE=$DOCKER_REPO/${BUILDER_APPLI_NAME/ /-}
  
  export DOCKER_IMAGE=${DOCKER_IMAGE,,} # lowercase
  
  local TAGS=""
  for tag in $DOCKER_TAGS
  do
    TAGS="$TAGS -t $DOCKER_IMAGE:$tag"
  done

  echo "DOCKER         $TAGS"
  echo "DOCKER_CONTEXT $DOCKER_CONTEXT"
  echo "DOCKER_VERSION $DOCKER_VERSION"
  echo "DOCKER_IMAGE   $DOCKER_IMAGE"

  cp -vf $DOCKER_DOCKERFILE $DOCKER_CONTEXT

  docker run -it --rm -v $DOCKER_CONTEXT:/context -v /var/run/docker.sock:/var/run/docker.sock -w /context $DOCKER_VERSION docker build /context $TAGS
}
