#! /usr/bin/bash

mkdir build
cd build

cmake .. -DCMAKE_INSTALL_PREFIX=${PWD}/../cern/new
make -j$((nproc))
make install
