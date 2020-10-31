FROM ubuntu:18.04

ARG MIRROR=ports.ubuntu.com
ARG USER=foo
ARG UID=1000
ARG GID=1000

ENV DEBIAN_FRONTEND noninteractive
ENV CUDA_PATH /usr/local/cuda-10.2
ENV LD_LIBRARY_PATH /usr/local/cuda-10.2/targets/aarch64-linux/lib:/usr/lib/aarch64-linux-gnu/tegra:/usr/lib/aarch64-linux-gnu

RUN set -x \
 && sed -i.org -e "s|ports.ubuntu.com|$MIRROR|g" /etc/apt/sources.list \
 && apt-get update && apt-get install -y apt-utils && apt-get install -y \
# Build:
    bash \
    build-essential \
    checkinstall \
    cmake \
    curl \
    doxygen \
    gfortran \
    git \
    pkg-config \
    squashfs-tools \
    sudo \
    unzip \
    yasm \
# freetype2
    libfreetype6-dev \
# HDF5
    hdf5-tools \
    libhdf5-dev \
    libhdf5-serial-dev \
# CERES
    libceres-dev \
# Tesseract
    libtesseract-dev \
# C/C++
    ccache \
# SFM
    libgoogle-glog-dev \
    libgflags-dev \
# GUI: QT
    qt5-default \ 
    qt5-qmake \ 
    libglvnd-dev \
# GUI: GTK+
    libgtk-3-dev \
    libgtk2.0-dev \
    libgtkglext1 \
    libgtkglext1-dev \
    libglu1-mesa-dev \
    libsm-dev \
    libice-dev \
    libx11-dev \
    libxext-dev \
    qv4l2 \
# Media I/O:
    libjpeg-dev \
    libpng-dev \
    libtiff-dev \
    libgdal-dev \
    libgphoto2-dev \
# Video I/O:
    libdc1394-22-dev \
    libavcodec-dev \
    libavformat-dev \
    libavresample-dev \
    libfaac-dev \
    libmp3lame-dev \
    libswscale-dev \
    libgstreamer-plugins-base1.0-dev \
    libgstreamer1.0-dev \
    libtheora-dev \
    libvorbis-dev \
    libopencore-amrnb-dev \
    libopencore-amrwb-dev \
    libx264-dev \
    libxvidcore-dev \
    libv4l-dev \
    v4l-utils \
    v4l2ucp \
    libxine2-dev \
# Parallel framework:
    libtbb-dev \
# Other third-party libraries:
    libatlas-base-dev \
    libblas-dev \
    libopenblas-base \
    libopenblas-dev \
    libeigen3-dev \
    liblapacke-dev \
# Python 2:
    python2.7-dev \
    python-numpy \
# Python 3:
    python3-numpy \
    python3.6-dev \
# Others:
    libgpm2 \
    libprotobuf-dev \
    protobuf-compiler \
 && mkdir /usr/local/cuda-10.2 \
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
