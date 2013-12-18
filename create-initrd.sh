#!/bin/bash
set -e

cd `dirname $0`/src
mkinitramfs -v -d ./initramfs-tools -o ../build/initrd.img
echo '############################################################'
echo "WARNING: initrd built for running kernel verion: $(uname -r)"
echo '############################################################'
cd -
