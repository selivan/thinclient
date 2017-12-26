#!/bin/bash

build-kernel() {
    set -x
    vmlinuz_path=$(readlink -f /vmlinuz)
    vmlinuz_filename=$(basename $vmlinuz_path)
    cp "$vmlinuz_path" /vagrant/build
    cd /vagrant/build
    ln -sf "$vmlinuz_filename" vmlinuz
    cd -
}

build-initrd() {
    set -x
    update-initramfs -u
    initrd_path=$(readlink -f /initrd.img)
    initrd_filename=$(basename $initrd_path)
    cp "$initrd_path" /vagrant/build
    cd /vagrant/build/
    ln -sf "$initrd_filename" initrd.img
    cd -
}

build-rootfs() {
    set -x
    mv /vagrant/build/rootfs.squashfs /vagrant/build/rootfs.squashfs.bak
    cd /
    # -always-use-fragments use fragment blocks for files larger than block size
    # -noappend do not append to existing filesystem
    #
    mksquashfs . /vagrant/build/rootfs.squashfs -noappend -always-use-fragments -comp xz -wildcards -ef $(dirname $0)/rootfs.exclude_dirs
    cd -
    rm -f /vagrant/build/rootfs.squashfs.bak
}

build-home() {
    set -x
    mv /vagrant/build/home.tar.gz /vagrant/build/home.tar.gz.bak
    cd /home/ubuntu
    # Don't use default unsecure ssh keys
    tar --exclude="./.ssh" -czf /vagrant/build/home.tar.gz ./
    cd -
    rm -f /vagrant/build/home.tar.gz.bak
}

case "$1" in
    all)
        build-kernel
        build-initrd
        build-rootfs
        build-home
        ;;
    kernel)
        build-kernel
        ;;
    initrd)
        build-initrd
        ;;
    rootfs)
        build-rootfs
        ;;
    home)
        build-home
        ;;
    *)
        echo "Usage: $0 all|initrd|kernel|rootfs|home"
        exit 1
        ;;
esac
