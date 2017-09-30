#!/bin/bash
set -x
set -e

dir=`dirname $0`/src/overlays
cd $dir
dir=`readlink -f .`

mkdir -p ../../build/overlays

if [ -z "$1" ]; then
	echo "Building all overlays..."
	for i in `find . -maxdepth 1 -mindepth 1 -type d`; do
		# remove './' from begining
		x=${i#./}
		cd $x
		test -e ../../../build/overlays/$x.tar.gz && rm ../../../build/overlays/$x.tar.gz -f
		tar cvzf ../../../build/overlays/$x.tar.gz .
		cd $dir
	done
else
	echo "Building overlay $x"
	x=$1
	cd $x
	test -e ../../../build/overlays/$x.tar.gz && rm ../../../build/overlays/$x.tar.gz -f
	tar cvzf ../../../build/overlays/$x.tar.gz .
	cd $dir
fi

