#!/bin/bash
set -e

cd $(dirname $0)
mkdir -p unpacked-initrd
# Clean old files
find ./unpacked-initrd/ -mindepth 1 -depth -delete
cd unpacked-initrd
bzip2 -dc ../initrd.img | cpio -id
cd -
