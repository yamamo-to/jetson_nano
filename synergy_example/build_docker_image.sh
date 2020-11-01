#!/bin/sh

TAG=synergy
UBUNTU_MIRROR=jp.archive.ubuntu.com

docker build \
	--build-arg MIRROR=$UBUNTU_MIRROR \
	-t $TAG \
	.
