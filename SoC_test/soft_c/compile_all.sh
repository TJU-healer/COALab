#!/bin/sh

for c in $(ls ./src)
do
    if [ "$c" != "soc_io.h" ]; then
        make USER_PROGRAM=${c%.*c}
        make USER_PROGRAM=${c%.*c}
        # echo ${c%.*c}
    fi
done
