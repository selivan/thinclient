#!/bin/bash

cd $(dirname $0)
# Clean old files
find ./unpacked-rootfs/ -mindepth 1 -depth -delete
rmdir ./unpacked-rootfs/
unsquashfs -d unpacked-rootfs build/rootfs.squashfs
cd -
