#!/bin/bash

build() {
  VERSION=$1
  TAG=${VERSION}

# build
  echo Building axelspringer/confd:${TAG}
    docker build \
      --compress \
      -t axelspringer/confd:${TAG} \
      --build-arg CONFD_VERSION=${VERSION} \
      . || exit $?
}

#  confd version
build "0.14.0"
