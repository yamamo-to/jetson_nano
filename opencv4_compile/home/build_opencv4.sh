#!/bin/sh

TARGET_DIR=/opt/opencv-4.1.0/

mkdir build
cd build
curl -L https://github.com/opencv/opencv/archive/4.1.0.zip -o opencv-4.1.0.zip 
curl -L https://github.com/opencv/opencv_contrib/archive/4.1.0.zip -o opencv_contrib-4.1.0.zip

unzip opencv-4.1.0.zip
unzip opencv_contrib-4.1.0.zip
cd opencv-4.1.0
mkdir release
cd release 
cmake \
  -D WITH_CUDA=ON \
  -D CUDA_ARCH_BIN="5.3" \
  -D CUDA_ARCH_PTX="" \
  -D OPENCV_ENABLE_NONFREE=ON \
  -D OPENCV_EXTRA_MODULES_PATH=../../opencv_contrib-4.1.0/modules \
  -D WITH_GSTREAMER=ON \
  -D WITH_LIBV4L=ON \
  -D WITH_LAPACK=ON \
  -D BUILD_opencv_python2=ON \
  -D BUILD_opencv_python3=ON \
  -D BUILD_TESTS=OFF \
  -D BUILD_PERF_TESTS=OFF \
  -D BUILD_EXAMPLES=OFF \
  -D CMAKE_BUILD_TYPE=RELEASE \
  -D CMAKE_INSTALL_PREFIX=$TARGET_DIR \
  ..

make -j4
sudo make install
mksquashfs $TARGET_DIR $HOME/opencv-4.1.0.sfs -b 1048576 -comp xz -Xdict-size 100%
