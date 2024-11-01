#! /usr/bin/bash

export CERN=${PREFIX}
./make_cernlib

# CMAKE installation is not working due to include path issue in kpuic
# @TODO: Contact maintainer (https://gitlab.cern.ch/DPHEP/cernlib/cernlib/-/issues)

#mkdir _build
#cd _build

#cmake .. -DCMAKE_INSTALL_PREFIX=${PREFIX}         

#make
#make install
