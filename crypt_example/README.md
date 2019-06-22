# Portable encrypted file on Jetson Nano

## What is this ?

This is a portable encrypted file system using a loop file on Jetson Nano.
By default, the kernel option `CONFIG_DM_CRYPT` is not set. This is a compiled
module with `CONFIG_DM_CRYPT=m` and this modules works on the default kernel.

## Contents

- install.sh             ... install script
- modules/dm-crypt.ko    ... kernel module for encryption
- example/a_crypt_file   ... encrypted loop file for example
- bin/make_enc_file.sh   ... create encrypted file
- bin/mount_enc_file.sh  ... mount encrypted file
- bin/umount_enc_file.sh ... unmount encrypted file

## Prerequisties

- Model: Jetson Nano
- Environment: JetPack 4.2

## Download example from github

```bash:terminal
git clone https://github.com/yamamo-to/jetson_nano.git
```

## Run install script

To install module `dm-crypt.ko`, run the install script `install.sh`:

```bash:terminal
cd jetson_nano/crypt_example
sudo ./install.sh
```

## Install cryptsetup

Install `cryptsetup` using apt:

```bash:terminal
sudo apt install cryptsetup
```

## Decript an example encripted file

Let's decript a sample file.
The password is `jetson`.

```bash:terminal
mkdir /mnt/test
sudo ./bin/mount_enc_file.sh example/a_crypt_file /mnt/test
```

To umount the directory, use `unmount_enc_file.sh`
```bash:terminal
sudo ./bin/umount_enc_file.sh /mnt/test
```

# How to create a portable encrypted file

For convinient, `make_enc_file.sh` is prepared.
The following example creates 10 MiB file: `cryptfile`.

```bash:terminal
sudo ./bin/make_enc_file.sh cryptfile 10
```
