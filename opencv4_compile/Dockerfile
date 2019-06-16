FROM ubuntu:18.04

ARG MIRROR=ports.ubuntu.com
ARG USER=foo
ARG UID=1000
ARG GID=1000

ENV CUDA_PATH /usr/local/cuda-10.0
ENV LD_LIBRARY_PATH /usr/local/cuda-10.0/targets/aarch64-linux/lib:/usr/lib/aarch64-linux-gnu/tegra

RUN set -x \
 && sed -i.org -e "s|ports.ubuntu.com|$MIRROR|g" /etc/apt/sources.list \
 && apt update && apt install -y \
    bash \
    sudo \
    build-essential \
    cmake \
    git \
    libgtk2.0-dev \
    pkg-config \
    libavcodec-dev \
    libavformat-dev \
    libswscale-dev \
    libgstreamer1.0-dev \
    libgstreamer-plugins-base1.0-dev \
    python2.7-dev \
    python3.6-dev \
    python-dev \
    python-numpy \
    python3-numpy \
    libtbb2 \
    libtbb-dev \
    libjpeg-dev \
    libpng-dev \
    libtiff-dev \
    libdc1394-22-dev \
    libv4l-dev \
    v4l-utils \
    qv4l2 \
    v4l2ucp \
    curl \
    libopenblas-dev \
    libopenblas-base \
    liblapack-dev \
    libeigen3-dev \
    libhdf5-serial-dev \
    hdf5-tools \
    libhdf5-dev \
    unzip \
 && mkdir /usr/local/cuda-10.0 \
 && rm -rf /var/lib/apt/lists/* \
 && groupadd -g $GID $USER \
 && useradd -u $UID -g $GID -G video $USER \
 && mkdir -p /home/$USER \
 && chown -R foo:foo /home/$USER \
 && echo "$USER ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers

ENV HOME /home/$USER
USER $USER
WORKDIR /home/$USER

CMD ["/bin/bash"]
