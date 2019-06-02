# VGG16 example on Jetson Nano

## What is this ?

This is examples tested in Jetson Nano with JetPack 4.2. This includes:

- VGG16 image recognition by `chainer`
- Format conversion from VGG16 caffemodel to ONNX using `chainer`
- Format conversion from ONNX to `TensorRT` engine (serialized)
- VGG16 image recognition by `TensorRT` example

## Prerequisties

- Model: Jetson Nano
- Environment: JetPack 4.2
- Storage: at least 10GB of disk space

## Before execution

### Make swap

By default, the on-board memory is 4GB which is not enough, so that you have to create swap area before execution:

```bash:terminal
sudo fallocate -l 4G /swapfile
sudo chmod 600 /swapfile
sudo mkswap /swapfile
sudo swapon /swapfile
```

### Change high performance mode

```bash:terminal
sudo jetson_clocks
```

### Install pipenv

`pipenv` is a new management tool for virtual environment. Install `pipenv` as below:

```bash:terminal
sudo apt update
sudo apt upgrade
sudo apt install python3-pip
pip3 install pipenv --user
```

### Install other packages

```bash:terminal
sudo apt install cmake libprotobuf-dev protobuf-compiler libjpeg-dev
```


### Setup environment

The environment variables as below must be set before installing `pycuda`:

```bash:terminal
export PATH=/usr/local/cuda-10.0/bin:$PATH
export LD_LIBRARY_PATH=/usr/local/cuda-10.0/lib64:$LD_LIBRARY_PATH
export PYTHONPATH=/usr/lib/python3.6/dist-packages
```

Download example soruce code from github:

```bash:terminal
git clone https://github.com/yamamo-to/jetson_nano.git
```

Setup virtual environment using Pipenv:
!!! This takes about one hour !!!

```bash:terminal
cd jetson_nano/vgg16_example
pipenv --three
pipenv install
```

## Prepare VGG16 model in ONNX format

### 1. VGG16 image recognition using chainer

```bash:terminal
pipenv run python3 vgg16_test.py boss.jpg
```

### 2. Format conversion from VGG16 caffemodel to chainer by `chainer`

You can create VGG16 in ONNX format in the following:

```bash:terminal
pipenv run python3 chainer_vgg16_to_onnx.py
```

However, it takes a few hours to run this conversion.
Instead, you can split download from above:

```bash:terminal
wget http://www.robots.ox.ac.uk/~vgg/software/very_deep/caffe/VGG_ILSVRC_16_layers.caffemodel
pipenv run python3 caffe2chainer.py VGG_ILSVRC_16_layers.caffemodel VGG_ILSVRC_16_layers.npz
mkdir -p ~/.chainer/dataset/pfnet/chainer/models
mv VGG_ILSVRC_16_layers.npz ~/.chainer/dataset/pfnet/chainer/models/
```

then,
```bash:terminal
pipenv run python3 chainer_vgg16_to_onnx.py
```


## Run by TensorRT

Format conversion from ONNX to TensorRT engine as below:

```bash:terminal
pipenv run python3 onnx2trt.py vgg16.onnx vgg16.trt
```

You can perform the inference by TensorRT using TensorRT engine:

```bash:terminal
pipenv run python3 trt_infer.py vgg16.trt boss.jpg
```
