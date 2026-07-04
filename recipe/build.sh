#! /usr/bin/bash

# CMake 4 removed compat with the <3.5 minimum declared upstream; the
# CI-level env var doesn't reach here (conda-build filters the env)
export CMAKE_POLICY_VERSION_MINIMUM=3.5

# Several targets' own link steps (kuesvr/cdmove, pawlib/comis/test/comist)
# drop -L$PREFIX/lib, so -lcrypt can't find libxcrypt's libcrypt.so even
# though it's a host: dependency and correctly installed. Plain `export
# LDFLAGS` isn't enough -- CMake only seeds CMAKE_EXE_LINKER_FLAGS_INIT
# from env LDFLAGS on a truly fresh configure, and some per-target link
# rules here don't inherit it anyway. Pass it straight into CMake's own
# linker-flags cache variable so every target gets it regardless.
export LDFLAGS="${LDFLAGS} -L${PREFIX}/lib -Wl,-rpath,${PREFIX}/lib"
CRYPT_LDFLAGS="-L${PREFIX}/lib -Wl,-rpath,${PREFIX}/lib"

mkdir -p build-scripts
cd build-scripts
cmake $RECIPE_DIR/scripts

mkdir -p ../build
cd ../build

cmake .. -DCMAKE_INSTALL_PREFIX=${PREFIX} \
-DCERNLIB_POSITION_INDEPENDENT_CODE=ON \
-DCMAKE_EXE_LINKER_FLAGS="${CRYPT_LDFLAGS}" \
-DCMAKE_SHARED_LINKER_FLAGS="${CRYPT_LDFLAGS}"
# @TODO: openmotif compatibility issue
# -DCERNLIB_BUILD_SHARED=OFF \

NPROC=$(nproc 2>/dev/null || sysctl -n hw.ncpu)
make -j$NPROC
make install
