#!/bin/bash
set -x

[ -z "$1" ] && echo "Usage: $0 rootfs-branch-name" && exit 1

image_name=rootfs.$1
echo "Chrooting to rootfs branch $image_name"


# Preparing chroot environment
set -e
cd `dirname $0`
mount -o bind ./src/home ./src/$image_name/root
mount -o bind /run ./src/$image_name/run
mount -t proc none ./src/$image_name/proc
mount -o bind /sys ./src/$image_name/sys
mount -o bind /dev ./src/$image_name/dev
mount -o bind /dev/pts ./src/$image_name/dev/pts

mount -o bind ./src/${image_name}_exclude/boot ./src/${image_name}/boot
mount -o bind ./src/${image_name}_exclude/var/cache/apt ./src/${image_name}/var/cache/apt
mount -o bind ./src/${image_name}_exclude/usr/share/doc ./src/${image_name}/usr/share/doc
mount -o bind ./src/${image_name}_exclude/usr/share/man ./src/${image_name}/usr/share/man
mount -o bind ./src/${image_name}_exclude/src ./src/${image_name}/src
mount -o bind ./src/${image_name}_exclude/usr/src ./src/${image_name}/usr/src
mount -o bind ./src/${image_name}_exclude/tmp ./src/${image_name}/tmp

xhost +
set +e

chroot ./src/$image_name bash

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
sleep 2
umount ./src/$image_name/dev
xhost -

