FROM ubuntu:18.04

ARG MIRROR=ports.ubuntu.com

# create a user
ARG USER=foo
ARG UID=1000
ARG GID=1000

# 
RUN set -x \
 && sed -i.org -e "s|ports.ubuntu.com|$MIRROR|g" /etc/apt/sources.list \
 && apt-get update && apt-get install -y \
    pkg-config squashfs-tools bash sudo git devscripts \
    qtcreator qtbase5-dev qttools5-dev cmake make g++ xorg-dev libssl-dev libx11-dev libsodium-dev libgl1-mesa-glx libegl1-mesa libcurl4-openssl-dev libavahi-compat-libdnssd-dev qtdeclarative5-dev libqt5svg5-dev libsystemd-dev \
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
