#!/bin/bash

push() {
  VERSION=$1
  TAG=${VERSION}

# base
  echo
  echo Pushing axelspringer/confd:${TAG}
  docker push axelspringer/confd:${TAG} || exit $?

  echo
  echo Updating axelspringer/confd:latest
  docker tag axelspringer/confd:${TAG} axelspringer/confd:latest
  docker push axelspringer/confd:latest || exit $?
}

# login docker before push
docker login -u="$DOCKER_USERNAME" -p="$DOCKER_PASSWORD"

#   confd version
push "0.14.0"
