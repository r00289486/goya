#!/bin/bash

BASE=$(dirname `readlink -f $0`)
#echo $BASE
cd $BASE

DEPS=$BASE/thirdparty
DEPS_SOURCE=$DEPS
DEPS_PREFIX=$DEPS/install
export PATH=${DEPS_PREFIX}/bin:$PATH
mkdir -p ${DEPS_PREFIX} ${DEPS_SOURCE}

# 1.protobuf
pushd $DEPS
if [ ! -f "${DEPS_PREFIX}/lib/libprotobuf.a" ] \
  || [ ! -d "${DEPS_PREFIX}/include/google/protobuf" ]; then
  wget https://codeload.github.com/protocolbuffers/protobuf/tar.gz/v3.9.0
  tar zxvf v3.9.0
  cd protobuf-3.9.0
  ./autogen.sh
  ./configure --prefix=${DEPS_PREFIX}/
  make -j4 && make check
  sudo make install
  cd -
  rm v3.9.0
fi
popd

if [ ! -d build ]; then
  mkdir -p build
fi

pushd $BASE/build
cmake .. && make 

