#!/bin/bash

## MAVEN

MAVEN_VERSION=maven:3.3.9-jdk-8

MAVEN_SETTINGS_FILE="settings.xml"

MAVEN_RELEASE_USERNAME=
MAVEN_RELEASE_PASSWORD=

MAVEN_RELEASE_PUSH=false
MAVEN_RELEASE_SSH=true
MAVEN_RELEASE_NO_DEPLOY=true

MAVEN_SSH_KEY="$(dirname ~/.ssh/id_rsa.pub)"

d_maven(){

  local MAVEN_CMD=$@

  echo "MAVEN_CMD           $MAVEN_CMD"
  echo "MAVEN_VERSION       $MAVEN_VERSION"
  echo "MAVEN_SETTINGS_FILE $MAVEN_SETTINGS_FILE"
  echo "MAVEN_SSH_KEY       $MAVEN_SSH_KEY"
  echo "BUILDER_WORKSPACE   $BUILDER_WORKSPACE"
  echo "BUILDER_VOLUME      $BUILDER_VOLUME"
  docker run -it --rm -v $BUILDER_WORKSPACE:/workspace -v $BUILDER_VOLUME:/source -v $MAVEN_SSH_KEY:/root/.ssh/ -v /tmp/repository:/repository -w /source $MAVEN_VERSION mvn -s "/workspace/$MAVEN_SETTINGS_FILE" --batch-mode $MAVEN_CMD
}

d_maven_version(){

  local TMP="/tmp/dkbuilder/$BUILDER_APPLI_NAME/maven_version"
  local DIR=$(dirname "$TMP")

  mkdir -p "$DIR"
  touch "$TMP"

  d_maven org.apache.maven.plugins:maven-help-plugin:evaluate -Dexpression=project.version | tee "$TMP"

  export MAVEN_POM_VERSION=$(cat "$TMP" | grep -v "^[\[|M]" | tail -n 1 | tr -d '\r' )
}

d_maven_release(){

  local args="-DautoVersionSubmodules=true -DenableSshAgent=$MAVEN_RELEASE_SSH -DnoDeploy=$MAVEN_RELEASE_NO_DEPLOY -Dusername=$MAVEN_RELEASE_USERNAME -Dpassword=$MAVEN_RELEASE_PASSWORD "

  local plugin="external.atlassian.jgitflow:jgitflow-maven-plugin:1.0-m5.1"

  echo "MAVEN_RELEASE_SSH         $MAVEN_RELEASE_SSH"
  echo "MAVEN_RELEASE_PUSH        $MAVEN_RELEASE_PUSH"
  echo "MAVEN_RELEASE_NO_DEPLOY   $MAVEN_RELEASE_NO_DEPLOY"

  d_maven $plugin:release-start  $args $@

  local RC=$?
  if [ $RC -ne 0 ]
  then
    echo "Release start failed"
    exit $RC
  fi

  RUN d_maven $plugin:release-finish $args $@

  if [ $MAVEN_RELEASE_PUSH == 'true' ]
  then
    echo "Pushing new git status"

    RUN l_git push --all
    RUN l_git push --tags
  fi

}



