#!/bin/bash

DOCKER_USER=foo

vs=""

for file in /usr/include/cudnn*
do
	vs+=" -v ${file}:${file}"
done

for file in /usr/lib/aarch64-linux-gnu/libcudnn*
do
	vs+=" -v ${file}:${file}"
done

for file in /usr/lib/aarch64-linux-gnu/libcublas*
do
	vs+=" -v ${file}:${file}"
done

for file in /usr/include/cublas*
do
	vs+=" -v ${file}:${file}"
done

for file in /usr/lib/aarch64-linux-gnu/lapack/*
do
	vs+=" -v ${file}:${file}"
done

for file in /usr/lib/aarch64-linux-gnu/blas/*
do
	vs+=" -v ${file}:${file}"
done

docker run -it --rm \
 -v $PWD/home:/home/$DOCKER_USER \
 -v /usr/local/cuda-10.2:/usr/local/cuda-10.2 \
 -v /usr/lib/aarch64-linux-gnu/tegra:/usr/lib/aarch64-linux-gnu/tegra \
 -v /usr/lib/aarch64-linux-gnu/tegra-egl:/usr/lib/aarch64-linux-gnu/tegra-egl \
 $vs \
 --device=/dev/nvmap \
 --device=/dev/nvhost-ctrl \
 --device=/dev/nvhost-ctrl-gpu \
 opencv4_build
