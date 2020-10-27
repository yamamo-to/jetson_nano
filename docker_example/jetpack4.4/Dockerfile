FROM ubuntu:18.04

ARG MIRROR=ports.ubuntu.com

# https://docs.nvidia.com/deeplearning/frameworks/install-tf-jetson-platform/index.html
RUN set -x \
 && sed -i.org -e "s|ports.ubuntu.com|$MIRROR|g" /etc/apt/sources.list \
 && apt update && apt install -y \
    pkg-config \
    bash \
    libhdf5-serial-dev hdf5-tools libhdf5-dev zlib1g-dev zip libjpeg8-dev liblapack-dev libblas-dev gfortran python3-pip \
 && rm -rf /var/lib/apt/lists/*

RUN pip3 install -U pip testresources setuptools==49.6.0 \
 && pip3 install -U numpy==1.16.1 future==0.18.2 mock==3.0.5 h5py==2.10.0 keras_preprocessing==1.1.1 keras_applications==1.0.8 gast==0.2.2 futures protobuf pybind11 

# split image due to too long compilation time
RUN pip3 install --pre --extra-index-url https://developer.download.nvidia.com/compute/redist/jp/v44 tensorflow 

# set environment variable
ENV LD_LIBRARY_PATH /usr/local/cuda-10.2/targets/aarch64-linux/lib:/usr/lib/aarch64-linux-gnu/tegra
ENV CUDA_PATH /usr/local/cuda-10.2

# create a user
ARG USER=foo
ARG UID=1000
ARG GID=1000

RUN groupadd -g $GID $USER \
 && useradd -u $UID -g $GID -G video $USER \
 && mkdir -p /home/$USER \
 && chown -R foo:foo /home/$USER

ENV HOME /home/$USER
USER $USER
WORKDIR /home/$USER

CMD ["/bin/bash"]
