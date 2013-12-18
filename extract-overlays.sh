#!/bin/bash
set -e

cd `dirname $0`/build/overlays
for i in *.tar.gz; do
	x=${i%.tar.gz}
	rm ../../src/overlays/$x -rf
	mkdir ../../src/overlays/$x
	tar xvzf $i -C ../../src/overlays/$x
done

cd -

