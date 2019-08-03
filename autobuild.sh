#!/bin/bash

BASE=$(dirname `readlink -f $0`)
echo $BASE
cd $BASE

if [ ! -d build ]; then
  mkdir -p build
fi

