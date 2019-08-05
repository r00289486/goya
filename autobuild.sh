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
  make install
  cd -
  rm v3.9.0
fi
popd

# 2.leveldb
pushd $DEPS
if [ ! -f "${DEPS_PREFIX}/lib/libleveldb.a" ] \
  || [ ! -d "${DEPS_PREFIX}/include/leveldb" ]; then
  rm -rf leveldb
  git clone https://github.com/r00289486/leveldb.git 
  cd leveldb
  echo "PREFIX=${DEPS_PREFIX}" > config.mk
  make -j4
  make install
  cd -
fi
popd

if [ ! -d build ]; then
  mkdir -p build
fi

pushd $BASE/build
cmake .. && make 

