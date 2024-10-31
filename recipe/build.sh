#! /usr/bin/bash

sed -i -E 's/(make.*)\s*-j [0-9]+/\1/g' ./make_cernlib
./make_cernlib
