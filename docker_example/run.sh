#!/bin/sh

DOCKER_USER=foo

docker run -it --rm \
 -v $PWD/home:/home/$DOCKER_USER \
 -v /usr/local/cuda-10.0:/usr/local/cuda-10.0 \
 -v /usr/lib/aarch64-linux-gnu/tegra:/usr/lib/aarch64-linux-gnu/tegra \
 -v /usr/lib/aarch64-linux-gnu/libcudnn.so.7.3.1:/usr/lib/aarch64-linux-gnu/libcudnn.so.7.3.1 \
 -v /usr/lib/aarch64-linux-gnu/libcudnn.so.7:/usr/lib/aarch64-linux-gnu/libcudnn.so.7 \
 --device=/dev/nvhost-as-gpu \
 --device=/dev/nvhost-ctrl \
 --device=/dev/nvhost-ctrl-gpu \
 --device=/dev/nvhost-ctrl-isp \
 --device=/dev/nvhost-ctrl-isp.1 \
 --device=/dev/nvhost-ctrl-nvdec \
 --device=/dev/nvhost-ctrl-vi \
 --device=/dev/nvhost-ctxsw-gpu \
 --device=/dev/nvhost-dbg-gpu \
 --device=/dev/nvhost-gpu \
 --device=/dev/nvhost-isp \
 --device=/dev/nvhost-isp.1 \
 --device=/dev/nvhost-msenc \
 --device=/dev/nvhost-nvdec \
 --device=/dev/nvhost-nvjpg \
 --device=/dev/nvhost-prof-gpu \
 --device=/dev/nvhost-sched-gpu \
 --device=/dev/nvhost-tsec \
 --device=/dev/nvhost-tsecb \
 --device=/dev/nvhost-tsg-gpu \
 --device=/dev/nvhost-vi \
 --device=/dev/nvhost-vic \
 --device=/dev/nvidiactl \
 --device=/dev/nvmap \
 python_with_tensorflow /bin/bash
