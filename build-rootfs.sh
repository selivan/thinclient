#!/bin/bash
set -e

[ -z "$1" ] && echo "Usage: $0 rootfs-branch-name" && exit 1

image_name=rootfs.$1
echo "Building image for $image_name"
cd `dirname $0`/src/$image_name
rm ../../build/$image_name.squashfs -f
mksquashfs . ../../build/${image_name}.squashfs -noappend -always-use-fragments -comp xz
cd -
