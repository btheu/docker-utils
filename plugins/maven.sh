#!/bin/bash

## MAVEN

MAVEN_VERSION=maven:3.3.9-jdk-8

MAVEN_SETTINGS_FILE="settings.xml"

MAVEN_RELEASE_USERNAME=
MAVEN_RELEASE_PASSWORD=

MAVEN_SSH_KEY="$(dirname ~/.ssh/id_rsa.pub)"

d_maven(){
  echo "MAVEN CMD           $@"
  echo "MAVEN_VERSION       $MAVEN_VERSION"
  echo "MAVEN_SETTINGS_FILE $MAVEN_SETTINGS_FILE"
  echo "MAVEN_SSH_KEY       $MAVEN_SSH_KEY"
  echo "BUILDER_WORKSPACE   $BUILDER_WORKSPACE"
  echo "BUILDER_VOLUME      $BUILDER_VOLUME"
  docker run -it --rm -v $BUILDER_WORKSPACE:/workspace -v $BUILDER_VOLUME:/source -v $MAVEN_SSH_KEY:/root/.ssh/ -v /tmp/repository:/repository -w /source $MAVEN_VERSION mvn -s "/workspace/$MAVEN_SETTINGS_FILE" --batch-mode $@
}

d_maven_version(){

  local TMP="/tmp/dkbuilder/$BUILDER_APPLI_NAME/maven_version"
  local DIR=$(dirname "$TMP")

  mkdir -p "$DIR"
  touch "$TMP"

  d_maven org.apache.maven.plugins:maven-help-plugin:evaluate -Dexpression=project.version | tee "$TMP"

  echo $(cat "$TMP" | grep -v "^[\[|M]" | tail -n 1)
}

d_maven_release(){

  local args="-DenableSshAgent=true -DnoDeploy=true"

  local plugin="external.atlassian.jgitflow:jgitflow-maven-plugin:1.0-m5.1"

  d_maven $plugin:release-start  $args $@

  local RC=$?
  if [ $RC -ne 0 ]
  then
    echo "Release start failed"
    exit $RC
  fi

  d_maven $plugin:release-finish $args $@

}

