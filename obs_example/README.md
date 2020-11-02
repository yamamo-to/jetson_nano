# OBS Studio example on Jetson Nano

## What is this ?

This is an example to run OBS Studio inside docker on Jetson Nano with JetPack 4.4.1.

- Dockerfile    ... Dockerfile to create an image including OBS Studio
- build.sh      ... build script to make Docker image
- obs-studio.sh ... example to launch container
- home/         ... home directory mounted to /home/foo in the container

## Prerequisties

- Model: Jetson Nano
- Environment: JetPack 4.4.1
- Storage: at least 1GB of disk space

## Download example from github

```bash:terminal
git clone https://github.com/yamamo-to/jetson_nano.git
```

## Build Docker Image

```bash:terminal
cd jetson_nano/obs_example
./build.sh
```

## Launch Docker Container

```bash:terminal
./obs-studio.sh
```
