#! /usr/bin/bash

find -name sed -i -E 's/(make.*)\s*-j [0-9]+/\1/g' ./make_cernlib
./make_cernlib
