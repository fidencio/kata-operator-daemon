#!/bin/bash

set -xe

IMAGE_NAME="quay.io/fidencio/test"

if "${TRAVIS_BRANCH}" == "master"; then
	TAG="latest"
else
	TAG="4.6666"
fi

docker login \
	--username="${QUAY_USERNAME}" \
	--password="${QUAY_PASSWORD}" \
	quay.io

env DOCKER_CLI_EXPERIMENTAL="enabled" docker manifest create \
	$IMAGE_NAME:$TAG \
	$IMAGE_NAME:$TAG-ppc64le \
	$IMAGE_NAME:$TAG-amd64

env DOCKER_CLI_EXPERIMENTAL="enabled" docker manifest push \
	--purge \
	$IMAGE_NAME:$TAG
