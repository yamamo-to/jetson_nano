#!/bin/sh

OPENCV4_DIR=/opt/opencv-4.5.0

PATH=$OPENCV4_DIR/bin:$PATH
LD_LIBRARY_PATH=$OPENCV4_DIR/lib:$OPENCV4_DIR/lib/aarch64-linux-gnu:$LD_LIBRARY_PATH
PYTHONPATH=$OPENCV4_DIR/lib/python3.6/dist-packages:$PYTHONPATH

export PATH LD_LIBRARY_PATH PYTHONPATH

