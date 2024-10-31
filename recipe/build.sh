#! /usr/bin/bash

mkdir build
cd build

cmake --trace-expand .. -DCMAKE_INSTALL_PREFIX=${PWD}/../cern/new

make
make install
