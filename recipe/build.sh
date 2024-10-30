#! /usr/bin/bash

mkdir build-scripts
cd build-scripts
cmake $RECIPE_DIR/scripts

mkdir ../build
cd ../build

cmake .. -DCMAKE_INSTALL_PREFIX=${PREFIX}
make -j$(nproc)
make install
