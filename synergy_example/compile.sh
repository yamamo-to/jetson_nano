#!/bin/sh

DOCKER_USER=foo

docker run -it --rm \
 -v $PWD/home:/home/$DOCKER_USER \
 synergy \
./build_package.sh
