#! /usr/bin/bash

kmkdir build-scripts
cd build-scripts
cmake $RECIPE_DIR/scripts

mkdir ../build
cd ../build

cmake .. -DCMAKE_INSTALL_PREFIX=${PREFIX} \
-DCERNLIB_BUILD_SHARED=OFF \ # @TODO: issue with openmotif
-DCERNLIB_POSITION_INDEPENDENT_CODE=ON

make -j$(nproc)
make install
