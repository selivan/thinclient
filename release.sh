#!/bin/bash
#set -x
[ -z "$1" ] && echo "Usage: $0 VERSION" && exit 1
cd `dirname $0`
mkdir -p "./release/$1" || ( echo "Failed to create specified catalog" > /dev/stderr; exit 2 )
cp -rv ./build/* "./release/$1"
touch "./release/$1/version_$1"

