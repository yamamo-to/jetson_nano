#!/bin/sh

if [ $# -ne 1 ]; then
	echo "usage: $0 directory"
	exit 1
fi

CRYPT_DIR=`realpath $1`

mount | \
while read mapper_name on dir others; do
	if [ "x$dir" = "x$CRYPT_DIR" ]; then
		umount $dir
		cryptsetup status $mapper_name | while read key val; do
			if [ "`echo $key | grep device:`" ]; then
				cryptsetup luksClose $mapper_name
				losetup -d $val
			fi
		done
	fi
done
