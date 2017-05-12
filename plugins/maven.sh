#!/bin/bash

## MAVEN
MAVEN_DIR=$BUILDER_TARGET

MAVEN_VERSION=maven:3.3.9-jdk-8

MAVEN_SETTINGS_FILE="$BUILDER_WORKSPACE/settings.xml"

MAVEN_RELEASE_USERNAME=
MAVEN_RELEASE_PASSWORD=

d_maven(){
  echo "MAVEN CMD           $@"
  echo "MAVEN_DIR           $MAVEN_DIR"
  echo "MAVEN_VERSION       $MAVEN_VERSION"
  echo "MAVEN_SETTINGS_FILE $MAVEN_SETTINGS_FILE"
  docker run -it --rm -v $MAVEN_DIR:/source  -v $MAVEN_SETTINGS_FILE:/conf/settings.xml  -v /tmp/repository:/repository -w /source $MAVEN_VERSION mvn -s /conf/settings.xml --batch-mode $@
}

d_maven_version(){

  local TMP="/tmp/dkbuilder/$BUILDER_APPLI_NAME/maven_version"
  local DIR=$(dirname "$TMP")

  mkdir -p "$DIR"
  touch "$TMP"

  d_maven org.apache.maven.plugins:maven-help-plugin:evaluate -Dexpression=project.version | tee "$TMP"

  echo $(cat "$TMP" | grep -v "^[\[|M]")
}

d_maven_release(){

  ## TODO BTHEU propagate git ssh key for jgitflow

  local auth="-Dusername=$MAVEN_RELEASE_USERNAME -Dpassword=$MAVEN_RELEASE_PASSWORD"

  d_maven com.atlassian.maven.plugins:maven-jgitflow-plugin:release-start  $auth $@

  d_maven com.atlassian.maven.plugins:maven-jgitflow-plugin:release-finish $auth $@
}
