#!/bin/sh

if [ ! -d synergy-core ]; then
  git clone https://github.com/symless/synergy-core.git
fi

mkdir build
cd build
cmake -DCMAKE_INSTALL_PREFIX=/usr ../synergy-core
make
make install DESTDIR=../work
cd ..
fakeroot dpkg-deb --build work
mv work.deb synergy-1.12.0-1_arm64.deb
