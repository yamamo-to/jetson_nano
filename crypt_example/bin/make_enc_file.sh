#!/bin/sh

if [ $# -ne 2 ]; then
	echo "usage: $0 filename size_in_mib"
	exit 1
fi

export CRYPT_FILE=$1
export CRYPT_SIZE_MIB=$2
export CRYPT_NAME=`mktemp -u secret.XXXXX`

export CRYPT_DEVICE=/dev/mapper/$CRYPT_NAME
export CRYPT_LOOP=`losetup -f`

if [ -f $CRYPT_FILE ]; then
	echo "file is already exist: $CRYPT_FILE"
	exit 1
fi

# create device
dd if=/dev/urandom of=$CRYPT_FILE bs=1M count=$CRYPT_SIZE_MIB && \
losetup $CRYPT_LOOP $CRYPT_FILE

cryptsetup luksFormat $CRYPT_LOOP

# format ext4
echo "---"
echo "Start ext4 format"
cryptsetup luksOpen $CRYPT_LOOP $CRYPT_NAME

if [ ! -L $CRYPT_DEVICE ]; then
	echo
	echo "Failed to map encripted file to device."
	exit 3
fi

mkfs.ext4 $CRYPT_DEVICE
if [ $? -ne 0 ]; then
	echo
	echo "Failed to create encripted file."
	exit 4
fi

cryptsetup luksClose $CRYPT_DEVICE
losetup -d $CRYPT_LOOP
