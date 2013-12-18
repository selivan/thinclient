#!/bin/bash
set -e

cd `dirname $0`/src/home
rm ../../build/home.tar.gz -f
tar cvzf ../../build/home.tar.gz ./
cd -
