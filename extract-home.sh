#!/bin/bash
set -e

cd `dirname $0`
rm ./src/home -rf
mkdir ./src/home
cd ./src/home
tar xvzf ../../build/home.tar.gz
cd `dirname $0`

