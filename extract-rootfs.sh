#!/bin/bash
set -e

[ -z "$1" ] && echo "Usage: $0 rootfs-branch-name" && exit 1

image_name=rootfs.$1
echo "Extracting image for $image_name"
cd `dirname $0`
rm ./src/$image_name -rf
unsquashfs -d src/$image_name build/$image_name.squashfs

