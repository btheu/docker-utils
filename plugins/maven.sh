#!/bin/bash

## MAVEN
MAVEN_DIR=$BUILDER_TARGET

MAVEN_VERSION=maven:3.3.9-jdk-8

MAVEN_SETTINGS_FILE="$BUILDER_WORKSPACE/settings.xml"

d_maven(){
  echo $@
  echo "MAVEN_DIR           $MAVEN_DIR"
  echo "MAVEN_VERSION       $MAVEN_VERSION"
  echo "MAVEN_SETTINGS_FILE $MAVEN_SETTINGS_FILE"
  docker run -it --rm -v $MAVEN_DIR:/source  -v $MAVEN_SETTINGS_FILE:/conf/settings.xml  -v /tmp/repository:/repository -w /source $MAVEN_VERSION mvn -s /conf/settings.xml $@
}
