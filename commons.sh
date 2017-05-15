#!/bin/bash

RUN(){

  $@
  local RC=$?
  if [ $RC -ne 0 ]
  then
    exit $RC
  fi

}
