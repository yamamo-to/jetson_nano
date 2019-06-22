#!/bin/sh

dir=/lib/modules/4.9.140-tegra/kernel/drivers/md
src=modules/dm-crypt.ko 
dst=$dir/dm-crypt.ko

if [ ! -d $dir ]; then
	mkdir -p $dir
	chmod 755 $dir
fi

/usr/bin/install -T -o root -g root -m 644 $src $dst
/sbin/depmod -a
