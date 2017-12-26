#!/bin/bash
set -e

cd $(dirname $0)
mkdir -p unpacked-rootfs
# Clean old files
find ./unpacked-rootfs/ -mindepth 1 -depth -delete
unsquashfs -d unpacked-rootfs build/$image_name.squashfs
cd -
