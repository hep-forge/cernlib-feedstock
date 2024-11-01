#! /usr/bin/bash

#create_aliases_based_on() {

#    local _prefix="${1%-*}"
#    for _program in "$_prefix-"*; do
#        ln -sf "$_program" "$(dirname $1)/${_program#$_prefix-}"
#    done
#}

#create_aliases_based_on "$GCC" # ./make_cernlib is using gfortran/gcc and cc without checks (cmake use $CC, $FC and CXX variables pointing to a different place)

#export CERN=${PREFIX}

#sed -i -E 's/(make.*)\s*-j [0-9]+/\1/g' ./make_cernlib
#./make_cernlib

# CMAKE installation is not working due to include path issue in kpuic
# @TODO: Contact maintainer (https://gitlab.cern.ch/DPHEP/cernlib/cernlib/-/issues)

mkdir build
cd build

cmake .. -DCMAKE_INSTALL_PREFIX=${PREFIX}

make
make install
