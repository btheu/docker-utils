#!/bin/bash

d_file_pull(){

  local FILE_FROM=$1
  local FILE_TO=$2

  echo "FILE_FROM           $FILE_FROM"
  echo "FILE_TO             $FILE_TO"

  d_bash "cp -vrf $FILE_FROM /workspace/$FILE_TO"
}

d_file_push(){

  local FILE_FROM=$1
  local FILE_TO=$2

  echo "FILE_FROM           $FILE_FROM"
  echo "FILE_TO             $FILE_TO"
  
  d_bash "cp -vrf /workspace/$FILE_FROM $FILE_TO"
}
