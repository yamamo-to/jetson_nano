# Synergy - keyboard and mouse sharing solution

## What is this ?

This is a demo to compile Synergy and make a deb package using docker.
This example is tested on Jetson Nano with JetPack 4.4.1.

- Dockerfile                ... Dockerfile to create an image for build environment
- build_docker_image.sh     ... build script to make Docker image
- compile.sh                ... create docker container
- home/                     ... home directory mounted to /home/foo in the container
- /home/build_pacckage.sh   ... build script to make debian package
- /home/work/DEBIAN/control ... control file to make debian package

## Prerequisties

- Model: Jetson Nano
- Environment: JetPack 4.4.1
- Storage: at least 2GB of disk space

## Download example from github

```bash:terminal
git clone https://github.com/yamamo-to/jetson_nano.git
```

## Build Docker Image

```bash:terminal
cd jetson_nano/synergy
./build_docker_image.sh
```

## Launch Docker Container

```bash:terminal
./compile.sh
```

## Install debian package

```bash:terminal
sudo apt update
sudo apt install ./home/synergy-1.12.0-1_arm64.deb
```
## Uninstall debian package

```bash:terminal
sudo dpkg -r synergy
```

## See also

- https://symless.com/synergy
- https://github.com/symless/synergy-core
