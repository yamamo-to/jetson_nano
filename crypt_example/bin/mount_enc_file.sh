#!/bin/sh

if [ $# -ne 2 ]; then
	echo "usage: $0 filename directory"
	exit 1
fi

export CRYPT_SRC=$1
export CRYPT_DST=$2
export CRYPT_NAME=`mktemp -u secret.XXXXX`

export CRYPT_DEVICE=/dev/mapper/$CRYPT_NAME
export CRYPT_LOOP=`losetup -f`

losetup $CRYPT_LOOP $CRYPT_SRC
cryptsetup luksOpen $CRYPT_LOOP $CRYPT_NAME

if [ ! -L $CRYPT_DEVICE ]; then
	echo
	echo "Failed to map encripted file to device."
	exit 3
fi

mount $CRYPT_DEVICE $CRYPT_DST
