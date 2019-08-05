#!/bin/bash

BASE=$(dirname `readlink -f $0`)
#echo $BASE
cd $BASE

DEPS=$BASE/thirdparty
DEPS_SOURCE=$DEPS
DEPS_PREFIX=$DEPS/install
export PATH=${DEPS_PREFIX}/bin:$PATH
mkdir -p ${DEPS_PREFIX} ${DEPS_SOURCE}

# 1 protobuf
pushd $DEPS
if [ ! -f "${DEPS_PREFIX}/lib/libprotobuf.a" ] \
  || [ ! -d "${DEPS_PREFIX}/include/google/protobuf" ]; then
  rm -rf protobuf-2.6.1
  wget https://github.com/protocolbuffers/protobuf/archive/v2.6.1.tar.gz
  tar zxvf v2.6.1.tar.gz
  cd protobuf-2.6.1
  autoreconf -ivf
  ./configure --prefix=${DEPS_PREFIX}/
  make -j4 && make install
  cd -
  rm v2.6.1.tar.gz
fi
popd

# 2 leveldb
pushd $DEPS
if [ ! -f "${DEPS_PREFIX}/lib/libleveldb.a" ] \
  || [ ! -d "${DEPS_PREFIX}/include/leveldb" ]; then
  rm -rf leveldb
  git clone https://github.com/r00289486/leveldb.git 
  cd leveldb
  echo "PREFIX=${DEPS_PREFIX}" > config.mk
  make -j4 && make install
  cd -
fi
popd

# 3 sofa-pbrpc
# 3.1 snappy
pushd $DEPS
if [ ! -f "${DEPS_PREFIX}/lib/libsnappy.a" ] \
  || [ ! -f "${DEPS_PREFIX}/include/snappy.h" ]; then
  echo "***snappy***"
  rm -rf snappy-1.1.3
  wget https://github.com/google/snappy/archive/1.1.3.tar.gz
  tar zxvf 1.1.3.tar.gz
  cd snappy-1.1.3
  ./autogen.sh
  ./configure --prefix=${DEPS_PREFIX}/
  make -j4 && make install
  cd -
  rm 1.1.3.tar.gz
fi
popd

# 3.2 boost
pushd $DEPS
if [ ! -d "${DEPS_PREFIX}/boost_1_57_0/boost" ]; then
  rm -rf boost_1_57_0
  wget https://raw.githubusercontent.com/lylei9/boost_1_57_0/master/boost_1_57_0.tar.gz
  tar zxvf boost_1_57_0.tar.gz
  rm -rf ${DEPS_PREFIX}/boost_1_57_0
  mv boost_1_57_0 ${DEPS_PREFIX}/boost_1_57_0
  rm boost_1_57_0.tar.gz
fi
popd

pushd $DEPS
if [ ! -f "${DEPS_PREFIX}/lib/libsofa-pbrpc.a" ] \
  || [ ! -d "${DEPS_PREFIX}/include/sofa/pbrpc" ]; then
  rm -rf sofa-pbrpc 
  git clone --depth=1 https://github.com/baidu/sofa-pbrpc.git sofa-pbrpc
  cd sofa-pbrpc
  sed -i '/BOOST_HEADER_DIR=/ d' depends.mk
  sed -i '/PROTOBUF_DIR=/ d' depends.mk
  sed -i '/SNAPPY_DIR=/ d' depends.mk
  echo "BOOST_HEADER_DIR=${DEPS_PREFIX}/boost_1_57_0" >> depends.mk
  echo "PROTOBUF_DIR=${DEPS_PREFIX}" >> depends.mk
  echo "SNAPPY_DIR=${DEPS_PREFIX}" >> depends.mk
  echo "PREFIX=${DEPS_PREFIX}" >> depends.mk
  echo "STD_FLAG=c++11" >> depends.mk
  make -j4 && make install
fi
popd

if [ ! -d build ]; then
  mkdir -p build
fi

pushd $BASE/build
cmake .. && make 

