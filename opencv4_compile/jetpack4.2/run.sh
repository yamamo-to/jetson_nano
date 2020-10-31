#!/bin/sh

DOCKER_USER=foo

docker run -it --rm \
 -v $PWD/home:/home/$DOCKER_USER \
 -v /usr/local/cuda-10.0:/usr/local/cuda-10.0 \
 -v /usr/lib/aarch64-linux-gnu/tegra:/usr/lib/aarch64-linux-gnu/tegra \
 -v /usr/lib/aarch64-linux-gnu/libcudnn.so.7.3.1:/usr/lib/aarch64-linux-gnu/libcudnn.so.7.3.1 \
 -v /usr/lib/aarch64-linux-gnu/libcudnn.so.7:/usr/lib/aarch64-linux-gnu/libcudnn.so.7 \
 --device=/dev/nvmap \
 --device=/dev/nvhost-ctrl \
 --device=/dev/nvhost-ctrl-gpu \
 opencv4_build
