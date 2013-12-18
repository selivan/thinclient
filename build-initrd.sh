#!/bin/bash
set -e

cd `dirname $0`/src/initrd
find . -print | cpio -H newc -o | bzip2 -9 -v -c > ../../build/initrd.img
cd -
