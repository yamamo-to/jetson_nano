#!/bin/sh

DOCKER_USER=foo

docker run -it --rm \
 -v $PWD/home:/home/$DOCKER_USER \
 -v /usr/local/cuda-10.2:/usr/local/cuda-10.2 \
 -v /usr/lib/aarch64-linux-gnu:/usr/lib/aarch64-linux-gnu \
 --device=/dev/nvmap \
 --device=/dev/nvhost-ctrl \
 --device=/dev/nvhost-ctrl-gpu \
 --device=/dev/nvhost-ctrl-vi \
 --device=/dev/nvhost-vic \
 --device=/dev/nvhost-nvdec \
 --device=/dev/video0 \
 --device=/dev/snd \
 --net host \
 -e DISPLAY=$DISPLAY \
 -e LD_PRELOAD=/usr/lib/aarch64-linux-gnu/libGL.so \
 -v /tmp/.X11-unix:/tmp/.X11-unix \
 -v $HOME/.Xauthority:/home/$DOCKER_USER/.Xauthority \
 -v /etc/localtime:/etc/localtime:ro \
 --name obs \
 obs-studio
