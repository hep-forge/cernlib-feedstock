#! /usr/bin/bash

# CMake 4 removed compat with the <3.5 minimum declared upstream; the
# CI-level env var doesn't reach here (conda-build filters the env)
export CMAKE_POLICY_VERSION_MINIMUM=3.5

# kuesvr/cdmove's own link step drops -L$PREFIX/lib (only aarch64 --
# amd64 links fine), so -lcrypt can't find libxcrypt's libcrypt.so even
# though it's a host: dependency and correctly installed. Force it onto
# the search path explicitly rather than depend on every generated
# Makefile rule inheriting conda's LDFLAGS.
export LDFLAGS="${LDFLAGS} -L${PREFIX}/lib -Wl,-rpath,${PREFIX}/lib"

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
