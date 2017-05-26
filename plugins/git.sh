#!/bin/bash

## GIT

BUILDER_GIT_URL=

BUILDER_GIT_BRANCH=

BUILDER_GIT_SSH_KEY="$(dirname ~/.ssh/id_rsa.pub)"

l_git(){

  local BUILDER_GIT_CMD=$@

  echo "BUILDER_GIT_CMD       $BUILDER_GIT_CMD"
  echo "BUILDER_GIT_SSH_KEY   $BUILDER_GIT_SSH_KEY"
  echo "BUILDER_VOLUME        $BUILDER_VOLUME"

  docker run -it --rm -v $BUILDER_VOLUME:/source -w /source -v $BUILDER_GIT_SSH_KEY:/root/.ssh/ indiehosters/git git $@

}

d_git(){

  echo "BUILDER_GIT_URL       $BUILDER_GIT_URL"
  echo "BUILDER_GIT_BRANCH    $BUILDER_GIT_BRANCH"

  l_git clone $BUILDER_GIT_URL /source || echo "Passing"

  l_git fetch --all

  l_git checkout $BUILDER_GIT_BRANCH ; l_git pull
}

d_git_clone(){

  d_git

}

