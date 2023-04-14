#!/bin/bash

cd `dirname $0`

PYTHON_VERSION=3.11.2
APPIMAGE_DIR=$HOME/appimage
INSTALL_SCRIPTS=(`find install -name "*.sh" | sort`)

printf "[0]\tALL\n"
for i in `seq 1 ${#INSTALL_SCRIPTS[@]}`; do
    printf "[%d]\t%s\n" $i ${INSTALL_SCRIPTS[$((i-1))]}
done

read -p '> ' N

if [[ $N -eq 0 ]]; then
    for i in `seq 1 ${#INSTALL_SCRIPTS[@]}`; do
        . ${INSTALL_SCRIPTS[$((i-1))]}
    done
else
    . ${INSTALL_SCRIPTS[$((N-1))]}
fi
