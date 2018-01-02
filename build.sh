#!/bin/bash

build-kernel() {
    set -x
    vmlinuz_path=$(readlink -f /vmlinuz)
    vmlinuz_filename=$(basename $vmlinuz_path)
    cp "$vmlinuz_path" /vagrant/build
    cd /vagrant/build
    chmod a+r "$vmlinuz_filename"
    ln -sf "$vmlinuz_filename" vmlinuz
    cd -
}

build-initrd() {
    set -x
    #update-initramfs -u
    initrd_path=$(readlink -f /initrd.img)
    initrd_filename=$(basename $initrd_path)
    cp "$initrd_path" /vagrant/build
    cd /vagrant/build/
    chmod a+r "$initrd_filename"
    ln -sf "$initrd_filename" initrd.img
    cd -
}

# UGLY CRUTCH HERE
# I coulnd't make mksquashfs to exclude all files in /var/log, but include /var/log directory
# So let's generate all files to exclude explicitly
generate-rootfs-excludes() {
    for d in /boot /dev /proc /sys /tmp /run /mnt /home/ubuntu /var/cache/apt /var/log /var/lib/apt/lists /usr/share/doc /usr/share/man /usr/src /var/lib/dhcp/; do
        find $d -mindepth 1 -maxdepth 1 >> "$1"
    done
    echo /vagrant >> "$1"
    echo initrd.img >> "$1"
    echo vmlinuz >> "$1"
}

build-rootfs() {
    set -x
    mv /vagrant/build/rootfs.squashfs /vagrant/build/rootfs.squashfs.bak
    cd /
    generate-rootfs-excludes /tmp/rootfs.exclude_dirs
    # Change interfaces file to symlink
    # To exclude Vagrant static interfaces
    echo "Backup /etc/network/interfaces"
    mv /etc/network/interfaces /etc/network/interfaces.bak
    ln -sf /tmp/interfaces /etc/network/interfaces
    mksquashfs . /vagrant/build/rootfs.squashfs -no-xattrs -noappend -always-use-fragments -comp xz -ef /tmp/rootfs.exclude_dirs \
    && rm -f /vagrant/build/rootfs.squashfs.bak
    chmod a+r /vagrant/build/rootfs.squashfs
    # Restore interfaces file
    echo "Restore original /etc/network/interfaces"
    rm -f /etc/network/interfaces
    mv /etc/network/interfaces.bak /etc/network/interfaces
    cd -
}

build-home() {
    set -x
    mv /vagrant/build/home.tar.gz /vagrant/build/home.tar.gz.bak
    cd /home/ubuntu
    # Don't use default unsecure ssh keys
    tar --exclude="./.ssh" -czf /vagrant/build/home.tar.gz ./ \
    && rm -f /vagrant/build/home.tar.gz.bak
    chmod a+r /vagrant/build/home.tar.gz
    cd -
}

source $(dirname "$0")/vars.sh

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
