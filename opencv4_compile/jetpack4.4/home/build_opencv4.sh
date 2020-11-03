#!/bin/sh

VERSION=4.5.0
OPENCV4_DIR=/opt/opencv-${VERSION}

export LD_LIBRARY_PATH=/usr/lib/aarch64-linux-gnu/tegra:/usr/lib/aarch64-linux-gnu/tegra-egl:$LD_LIBRARY_PATH

if [ ! -d build ]; then
  mkdir build
fi

cd build

if [ ! -f opencv-${VERSION}.zip ]; then
  curl -L https://github.com/opencv/opencv/archive/${VERSION}.zip -o opencv-${VERSION}.zip 
  unzip opencv-${VERSION}.zip
fi

if [ ! -f opencv_contrib-${VERSION}.zip ]; then
  curl -L https://github.com/opencv/opencv_contrib/archive/${VERSION}.zip -o opencv_contrib-${VERSION}.zip
  unzip opencv_contrib-${VERSION}.zip
fi

cd opencv-${VERSION}
if [ ! -d release ]; then
  mkdir release
fi
cd release 
cmake \
  -D CMAKE_BUILD_TYPE=RELEASE \
  -D CMAKE_INSTALL_PREFIX=$OPENCV4_DIR \
  -D OPENCV_EXTRA_MODULES_PATH=../../opencv_contrib-${VERSION}/modules \
  -D WITH_CUDA=ON \
  -D CUDA_ARCH_BIN="5.3" \
  -D CUDA_ARCH_PTX="" \
  -D ENABLE_FAST_MATH=ON \
  -D CUDA_FAST_MATH=ON \
  -D WITH_CUBLAS=ON \
  -D OPENCV_DNN_CUDA=ON \
  -D WITH_CUDNN=ON \
  -D CUDNN_LIBRARY=/usr/lib/aarch64-linux-gnu/libcudnn.so.8.0.0 \
  -D CUDNN_INCLUDE_DIR=/usr/include \
  -D OPENCV_ENABLE_NONFREE=ON \
  -D WITH_GSTREAMER=ON \
  -D WITH_LIBV4L=ON \
  -D WITH_LAPACK=ON \
  -D BUILD_opencv_python2=ON \
  -D BUILD_opencv_python3=ON \
  -D BUILD_TESTS=OFF \
  -D BUILD_PERF_TESTS=OFF \
  -D BUILD_EXAMPLES=OFF \
  -D WITH_TBB=ON \
  -D WITH_V4L=ON \
  -D WITH_OPENGL=ON \
  -D WITH_VTK=OFF \
  -D WITH_GTK=OFF \
  -D WITH_QT=ON \
  -D WITH_GDAL=ON \
  ..

make -j$(nproc)
sudo make install

libdir=$OPENCV4_DIR/lib/aarch64-linux-gnu
if [ ! -d $libdir ]; then
  sudo mkdir $libdir
fi
for lib in \
  cblas atlas hdf5 glog sz Qt5OpenGL Qt5Test aec gflags cholmod cxsparse spqr tesseract \
  amd camd ccolamd dap dapclient epsilon f77blas freexl fyba geos_c geotiff \
  kmlbase kmldom kmlengine lept metis netcdf odbc odbcinst pq proj qhull spatialite xerces-c \
  arpack fygm fyut geos minizip superlu uriparser 
do
  sudo cp -p --preserve=links /usr/lib/aarch64-linux-gnu/lib$lib* $libdir/
done

for lib in ceres gdal armadillo dfalt mfhdfalt ogdi
do
  sudo cp -p --preserve=links /usr/lib/lib$lib.* $libdir/
done

# lapack and blas
for target in lapack blas;
do
  sudo cp -p --preserve=links /usr/lib/aarch64-linux-gnu/$target/lib* $libdir/
done

# make utililty for convenience
if [ ! -d $OPENCV4_DIR/etc ]; then
  sudo mkdir $OPENCV4_DIR/etc
fi

sudo cp $HOME/env.sh $OPENCV4_DIR/etc/env.sh

mksquashfs $OPENCV4_DIR $HOME/opencv-${VERSION}.sfs -b 1048576 -comp xz -Xdict-size 100%
