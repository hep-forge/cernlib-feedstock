#! /usr/bin/bash

# CMake 4 removed compat with the <3.5 minimum declared upstream; the
# CI-level env var doesn't reach here (conda-build filters the env)
export CMAKE_POLICY_VERSION_MINIMUM=3.5

mkdir -p build-scripts
cd build-scripts
cmake $RECIPE_DIR/scripts

mkdir -p ../build
cd ../build

cmake .. -DCMAKE_INSTALL_PREFIX=${PREFIX} \
-DCERNLIB_POSITION_INDEPENDENT_CODE=ON
# @TODO: openmotif compatibility issue
# -DCERNLIB_BUILD_SHARED=OFF \

NPROC=$(nproc 2>/dev/null || sysctl -n hw.ncpu)
make -j$NPROC
make install
