#!/bin/bash

cd $(dirname $0)
mkdir -p ./unpacked-initrd
# Clean old files
find ./unpacked-initrd/ -mindepth 1 -depth -delete
cd unpacked-initrd
initrd=$(readlink -f ../build/initrd.img)
#cat "$initrd" | cpio -id
unmkinitramfs -v "$initrd" .
cd -
