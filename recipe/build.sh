#! /usr/bin/bash

mkdir -p build-scripts
cd build-scripts
cmake $RECIPE_DIR/scripts

mkdir -p ../build
cd ../build

cmake .. -DCMAKE_INSTALL_PREFIX=${PREFIX} \
-DCERNLIB_POSITION_INDEPENDENT_CODE=ON
# @TODO: openmotif compatibility issue
# -DCERNLIB_BUILD_SHARED=OFF \

make -j$(nproc)
make install
