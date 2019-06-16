# OpenCV 4.1.0 Compile demo on Jetson Nano

## What is this ?

This is an environment to compile OpenCV 4.1.0 using docker.
This example is tested on Jetson Nano with JetPack 4.2.

- Dockerfile              ... Dockerfile to create an image for build environment
- build_docker_image.sh   ... build script to make Docker image
- run.sh                  ... create docker container
- home/                   ... home directory mounted to /home/foo in the container
- /home/build_opencv4.sh  ... build script to make OpenCV 4.1.0

## Prerequisties

- Model: Jetson Nano
- Environment: JetPack 4.2
- Storage: at least 15GB of disk space

## Download example from github

```bash:terminal
git clone https://github.com/yamamo-to/jetson_nano.git
```

## Build Docker Image

```bash:terminal
cd jetson_nano/opencv4_compile
./build_docker_image.sh
```

## Launch Docker Container

```bash:terminal
./run.sh
```

## Run build script

```bash:container
./build_opencv4.sh
```

## Export outside container

You can find out binaries in the following directories:

- home/dist
- home/build
