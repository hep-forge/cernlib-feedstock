#! /usr/bin/bash

mkdir build
cd build

cmake .. -DCMAKE_INSTALL_PREFIX=${PWD}/../cern/new
cat CMakeCache.txt

make -j$((nproc))
make install
