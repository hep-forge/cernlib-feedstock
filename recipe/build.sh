#! /usr/bin/bash

create_gnu_aliases() {

    local GNU="$1"
    local DIRNAME="$(dirname "$GNU")"
    local PREFIX="${GNU%-*}"

    for program in "$PREFIX-"*; do

            local short_name="${program#$PREFIX-}"

            ln -sf "$program" "$DIRNAME/$short_name"
            echo "$program => $DIRNAME/$short_name"
        fi
    done
}

create_gnu_aliases "$GCC"

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
