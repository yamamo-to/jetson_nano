# Motion JPEG streaming demo on Jetson Nano

## What is this ?

This is a motion JPEG streaming demo via http on Jetson Nano.

## Prerequisties

- Model: Jetson Nano
- Environment: JetPack 4.2

## Install python package

```bash:terminal
sudo apt install python3-pip
pip3 install numpy --user
```

## Download example from github

```bash:terminal
git clone https://github.com/yamamo-to/jetson_nano.git
cd jetson_nano/mjpeg_http
```

## Edit html

The default server URL is `http://127.0.0.1:8080/camera.mjpg`.
You need to change this URL to your server configuration.
Do not change `camera.mjpg` if you are using the source code as is.

```bash:terminal
vi html/index.html
```

## Run server

By default, server runs on 127.0.0.1. 

```bash:terminal
python3 -m mjpeg_http.server
```

If you need access the server not from localhost, use `--bind` option:
 ```bash:terminal
python3 -m mjpeg_http.server  --bind 0.0.0.0
```

## Access by browser

If you use Google chrome, you can access the motion jpeg directly:
`http://127.0.0.1:8080/camera.mjpg`

If not, you need access it via html:
`http://127.0.0.1:8080/index.html`

Change the host and port above to your settings on access.
