#! /usr/bin/bash

ls -ls $BUILD_PREFIX/bin/
which gcc
which cc
which gfortran

ls -ls $BUILD_PREFIX/bin/*-cc

ln -s $BUILD_PREFIX/bin/*-cc $BUILD_PREFIX/bin/cc
ln -s $BUILD_PREFIX/bin/*-gcc $BUILD_PREFIX/bin/gcc
ln -s $BUILD_PREFIX/bin/*-gfortran $BUILD_PREFIX/bin/gfortran
echo $CC
echo $CXX
echo $FC

ls -ls $BUILD_PREFIX/bin/*-cc
ls -ls $BUILD_PREFIX/bin/*-gcc
ls -ls $BUILD_PREFIX/bin/*-gfortran
which gcc
which cc
which gfortran

# export CERN=${PREFIX}

# sed -i -E 's/(make.*)\s*-j [0-9]+/\1/g' ./make_cernlib
# ./make_cernlib

# CMAKE installation is not working due to include path issue in kpuic
# @TODO: Contact maintainer (https://gitlab.cern.ch/DPHEP/cernlib/cernlib/-/issues)

#mkdir _build
#cd _build

#cmake .. -DCMAKE_INSTALL_PREFIX=${PREFIX}

#make
#make install
