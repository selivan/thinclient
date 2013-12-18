#!/bin/bash
set -e

cd `dirname $0`
rm ./src/initrd -rf
mkdir ./src/initrd
cd ./src/initrd
bzip2 -dc ../../build/initrd.img | cpio -id
cd `dirname $0`

