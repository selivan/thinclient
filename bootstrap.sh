#!/bin/bash
set -x

[ -z "$1" ] && echo "Usage: $0 rootfs-branch-name" && exit 1

image_name=rootfs.$1
echo "Bootstrapping new system for $image_name"

debootstrap_opts='--variant=minbase'
debootstrap_os='xenial'

cd `dirname $0`

echo "Bootstraping new system"

debootstrap $debootstrap_opts "$debootstrap_os" ./src/"$image_name"

echo "Creating necessary directories in new system"

mkdir -p ./src/"$image_name"/boot
mkdir -p ./src/"$image_name"/src
mkdir -p ./src/"$image_name"/usr/src

echo "Copying configs from ${image_name}_configs to bootstrapped system"
cp -ar -v ./src/"$image_name"_configs ./src/"$image_name"

echo "Moving unnecessary parts to ${image_name}_exclude"
mkdir -p  ./src/"$image_name"_exclude/boot
mkdir -p  ./src/"$image_name"_exclude/var/cache/apt
mkdir -p  ./src/"$image_name"_exclude/var/log
mkdir -p  ./src/"$image_name"_exclude/usr/share/doc
mkdir -p  ./src/"$image_name"_exclude/usr/share/man
mkdir -p  ./src/"$image_name"_exclude/src
mkdir -p  ./src/"$image_name"_exclude/usr/src
mkdir -p  ./src/"$image_name"_exclude/tmp

mv ./src/"$image_name"/boot/* ./src/"$image_name"_exclude/boot
mv ./src/"$image_name"/var/cache/apt/* ./src/"$image_name"_exclude/var/cache/apt
mv ./src/"$image_name"/usr/share/doc/* ./src/"$image_name"_exclude/usr/share/doc 
mv ./src/"$image_name"/usr/share/man/* ./src/"$image_name"_exclude/usr/share/man
mv ./src/"$image_name"/src/* ./src/"$image_name"_exclude/src
mv ./src/"$image_name"/usr/src/* ./src/"$image_name"_exclude/usr/src
#mv ./src/"$image_name"/tmp/* ./src/"$image_name"_exclude/tmp

