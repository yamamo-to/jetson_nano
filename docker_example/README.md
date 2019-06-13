# Docker example on Jetson Nano

## What is this ?

This is a Docker example to call TensorFlow with GPU in a container.
This example is tested on Jetson Nano with JetPack 4.2.

- Dockerfile ... Dockerfile to create an image including TensorFlow
- build.sh   ... build script to make Docker image
- run.sh     ... exsample to launch container
- home/      ... home directory mounted to /home/foo in the container

This example demonstrates an image recognition by Resnet50.

## Prerequisties

- Model: Jetson Nano
- Environment: JetPack 4.2
- Storage: at least 10GB of disk space

## Download example from github

```bash:terminal
git clone https://github.com/yamamo-to/jetson_nano.git
```

## Build Docker Image

Note that this build takes time. In my environment it takes about an hour.

```bash:terminal
cd jetson_nano/docker_example
./build.sh
```

## Launch Docker Container

```bash:terminal
./run.sh
```

## Run example

First, install pillow as below:

```bash:container
pip3 install pillow
```

Then, run the script:

```bash:container
python3 scripts/resnet50_keras.py data/boss.jpg
```
