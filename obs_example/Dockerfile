FROM ubuntu:18.04

ARG MIRROR=ports.ubuntu.com
ENV DEBIAN_FRONTEND noninteractive

COPY files/obs-studio_20201101-git-1_arm64.deb /tmp/

RUN set -x \
   && sed -i.org -e "s|ports.ubuntu.com|$MIRROR|g" /etc/apt/sources.list \
   && apt-get update \
   && apt-get install --no-install-recommends -y \
   bash \
   sudo \
   libqt5svg5 \
   libqt5xml5 \
   libavcodec57 \
   libavformat57 \
   libcurl4 \
   libqt5x11extras5 \
   libpulse0 \
   libjansson4 \
   libswscale4 \
   python3 \
   tzdata \
   libvlc5 \
   openssl \
   ca-certificates \
   libmbedtls10 \
   libusb-1.0-0 \
   libfdk-aac1 \
   libslang2 \
   alsa-utils \
   && dpkg -i /tmp/obs-studio_20201101-git-1_arm64.deb \
   && rm /tmp/obs-studio_20201101-git-1_arm64.deb \
   && rm -rf /var/lib/apt/lists/*

# set environment variable
ENV LD_LIBRARY_PATH /usr/local/cuda-10.2/targets/aarch64-linux/lib:/usr/lib/aarch64-linux-gnu/tegra
ENV CUDA_PATH /usr/local/cuda-10.2

# create a user
ARG USER=foo
ARG UID=1000
ARG GID=1000

RUN groupadd -g $GID $USER \
   && useradd -u $UID -g $GID -G video,audio $USER \
   && mkdir -p /home/$USER \
   && chown -R foo:foo /home/$USER \
   && echo "$USER ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers

ENV HOME /home/$USER
USER $USER
WORKDIR /home/$USER

CMD ["/usr/bin/obs"]
