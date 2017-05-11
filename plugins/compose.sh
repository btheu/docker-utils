#!/bin/bash

## RUN IMAGE

COMPOSE_FILE="$BUILDER_WORKSPACE/docker-compose.yml"

d_compose(){

  echo "COMPOSE_FILE $COMPOSE_FILE"
  cd $(dirname $COMPOSE_FILE)

  docker-compose up -d

}
