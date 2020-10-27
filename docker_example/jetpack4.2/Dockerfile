FROM ubuntu:18.04

ARG MIRROR=ports.ubuntu.com

# for Tensorflow
RUN set -x \
 && sed -i.org -e "s|ports.ubuntu.com|$MIRROR|g" /etc/apt/sources.list \
 && apt update && apt install -y \
    pkg-config \
    bash python3-pip libhdf5-serial-dev hdf5-tools zlib1g-dev zip libjpeg8-dev libhdf5-dev \
 && pip3 install -U numpy grpcio absl-py py-cpuinfo psutil portpicker six mock requests gast h5py astor termcolor

# split image due to too long compilation time
RUN pip3 install -U keras-preprocessing keras-applications protobuf tensorboard tensorflow-estimator \
 && pip3 install --extra-index-url https://developer.download.nvidia.com/compute/redist/jp/v42 tensorflow-gpu==1.13.1+nv19.5 \
 && rm -rf /var/lib/apt/lists/*

# set environment variable
ENV LD_LIBRARY_PATH /usr/local/cuda-10.0/targets/aarch64-linux/lib:/usr/lib/aarch64-linux-gnu/tegra
ENV CUDA_PATH /usr/local/cuda-10.0

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
