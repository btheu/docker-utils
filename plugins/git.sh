#!/bin/bash

## GIT

BUILDER_GIT_URL=

BUILDER_GIT_BRANCH=

BUILDER_GIT_REPO=$BUILDER_TARGET

d_git(){

  git clone $BUILDER_GIT_URL $BUILDER_GIT_REPO || echo "Passing"
  
  cd $BUILDER_GIT_REPO
  
  git fetch --all
  
  git checkout $BUILDER_GIT_BRANCH ; git pull
}

