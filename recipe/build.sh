#! /usr/bin/bash

# CMake 4 removed compat with the <3.5 minimum declared upstream; the
# CI-level env var doesn't reach here (conda-build filters the env)
export CMAKE_POLICY_VERSION_MINIMUM=3.5

# Several targets' own link steps (kuesvr/cdmove, pawlib/comis/test/comist)
# drop -L$PREFIX/lib, so -lcrypt can't find libxcrypt's libcrypt.so even
# though it's a host: dependency and correctly installed. Neither plain
# `export LDFLAGS` nor -DCMAKE_EXE_LINKER_FLAGS on the configure line
# reach comist's link step (its CMakeLists.txt likely sets its own
# LINK_FLAGS/link_libraries that don't inherit the global ones). The one
# thing every linker invocation genuinely can't ignore is LIBRARY_PATH --
# gcc/gfortran/collect2 append it to their own -L search dirs regardless
# of what the build system generated on the command line.
export LDFLAGS="${LDFLAGS} -L${PREFIX}/lib -Wl,-rpath,${PREFIX}/lib"
export LIBRARY_PATH="${PREFIX}/lib${LIBRARY_PATH:+:$LIBRARY_PATH}"
CRYPT_LDFLAGS="-L${PREFIX}/lib -Wl,-rpath,${PREFIX}/lib"

mkdir -p build-scripts
cd build-scripts
cmake $RECIPE_DIR/scripts

mkdir -p ../build
cd ../build

# ${CMAKE_ARGS} carries conda-build's own -DCMAKE_BUILD_TYPE=Release
# (plus toolchain/strip paths) -- omitting it leaves CMAKE_BUILD_TYPE
# unset (this project's own CMakeLists.txt never defaults it either),
# producing an unoptimized, unstripped debug-info binary.
cmake .. ${CMAKE_ARGS} -DCMAKE_INSTALL_PREFIX=${PREFIX} \
-DCERNLIB_POSITION_INDEPENDENT_CODE=ON \
-DCMAKE_EXE_LINKER_FLAGS="${CRYPT_LDFLAGS}" \
-DCMAKE_SHARED_LINKER_FLAGS="${CRYPT_LDFLAGS}"
# @TODO: openmotif compatibility issue
# -DCERNLIB_BUILD_SHARED=OFF \

NPROC=$(nproc 2>/dev/null || sysctl -n hw.ncpu)
make -j$NPROC
make install
