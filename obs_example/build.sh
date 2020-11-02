#!/bin/sh

TAG=obs-studio
UBUNTU_MIRROR=jp.archive.ubuntu.com

docker build \
	--build-arg MIRROR=$UBUNTU_MIRROR \
	-t $TAG \
	.
