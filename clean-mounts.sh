#!/bin/bash
set -x

[ -z "$1" ] && echo "Usage: $0 rootfs-branch-name" && exit 1

image_name=rootfs.$1
echo "Cleaning chroot mountpoints for $image_name"


# Envoronment cleanup
cd `dirname $0`

umount ./src/${image_name}/boot
umount ./src/${image_name}/var/cache/apt
umount ./src/${image_name}/usr/share/doc
umount ./src/${image_name}/usr/share/man
umount ./src/${image_name}/src
umount ./src/${image_name}/usr/src
umount ./src/${image_name}/tmp

umount ./src/$image_name/root
umount ./src/$image_name/run
umount ./src/$image_name/proc
umount ./src/$image_name/sys
umount ./src/$image_name/dev/pts
umount ./src/$image_name/dev
which xhost && xhost -

