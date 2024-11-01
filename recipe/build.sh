#! /usr/bin/bash

ls -ls $BUILD_PREFIX/bin/
which gcc
which cc
which gfortran

ls -ls $BUILD_PREFIX/bin/x86_64-conda-linux-gnu-cc

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
