#!/bin/bash

export CC="gcc"
export CXX="g++"
export LD="ld.bfd"
export AR="gcc-ar"
export AS="as"
export NM="gcc-nm"
export RANLIB="gcc-ranlib"
export STRIP="gcc-strip"
export OBJCOPY="objcopy"
export OBJDUMP="objdump"
export HOSTCC="gcc"
export HOSTLD="ld.bfd"
export HOSTAR="gcc-ar"

export CFLAGS=" -march=x86-64 -mtune=generic -O3 -pipe -flto=4 -fuse-linker-plugin \
-falign-functions=32 -mfpmath=sse+387 -flimit-function-alignment -ffunction-sections \
-fdata-sections -fno-math-errno -fno-trapping-math -fgraphite-identity -floop-nest-optimize \
-fno-stack-protector -fipa-pta -fdevirtualize-at-ltrans -fomit-frame-pointer -Wno-all -Wno-error \
-fno-strict-aliasing -pipe --param=inline-min-speedup=15 --param=max-inline-insns-single=200 \
--param=max-inline-insns-auto=30 --param=early-inlining-insns=14 "

export LDFLAGS="-Wl,-O2 -Wl,--as-needed,-z,now -fuse-ld=bfd -Wl,--hash-style=gnu"

export CXXFLAGS="${CFLAGS}"
export FCFLAGS="${CFLAGS}"
export FFLAGS="${CFLAGS}"
export CPPFLAGS="${CFLAGS}"
export BOOT_CFLAGS="${CFLAGS}"
export GCC_CFLAGS="${CFLAGS}"

while getopts a: flag; do
  case "${flag}" in
    a) arch=${OPTARG} ;;
  esac
done

case "${arch}" in
  "arm") TARGET="arm-eabi" ;;
  "arm64") TARGET="aarch64-elf" ;;
  "x86") TARGET="x86_64-elf" ;;
esac

export WORK_DIR="$PWD"
export PREFIX="$PWD/../gcc-${arch}"
export PATH="$PREFIX/bin:$PATH"

download_resources() {

#  git clone --depth=1 https://github.com/bminor/binutils-gdb -b binutils-2_37-branch binutils
#  git clone --depth=1 https://github.com/gcc-mirror/gcc -b releases/gcc-11 gcc

  cd ${WORK_DIR}
}

build_binutils() {
  cd ${WORK_DIR}
  echo "Building Gnu/Binutils"
  mkdir build-binutils
  cd build-binutils
  ../binutils/configure --target=$TARGET \
    --host=x86_64-pc-linux-gnu \
    --build=x86_64-pc-linux-gnu \
    --prefix="$PREFIX" \
    --with-sysroot \
    --disable-nls \
    --disable-docs \
    --disable-werror \
    --disable-gdb \
    --enable-gold \
    --enable-plugins \
    --with-system-zlib \
    --without-included-gettext \
    --enable-poison-system-directories \
    --enable-secureplt \
    --enable-default-hash-style=gnu \
    --enable-obsolete \
    --disable-shared \
    --enable-threads \
    --enable-relro \
    --enable-install-libiberty \
    --enable-textrel-check=warning \
    --enable-static \
    --disable-libdecnumber\
    --disable-readline \
    --disable-sim \
    --without-stage1-ldflags \
    --without-debuginfod \
    --disable-cet \
    --with-headers \
    --with-pkgversion="jsX-Custom Gnu/Binutils"
  make -j$(($(nproc --all) + 1))
  make install -j$(($(nproc --all) + 1))
  cd ../
  echo "Compiled Gnu/Binutils, Done"
}

build_gcc() {
clear
  cd ${WORK_DIR}
  echo "Building GCC"
  cd gcc
  ./contrib/download_prerequisites
  cd ../
  mkdir build-gcc
  cd build-gcc
  ../gcc/configure --target=$TARGET \
    --host=x86_64-pc-linux-gnu \
    --build=x86_64-pc-linux-gnu \
    --prefix="$PREFIX" \
    --disable-decimal-float \
    --disable-libffi \
    --disable-libgomp \
    --disable-libmudflap \
    --disable-libquadmath \
    --disable-libstdcxx-pch \
    --disable-nls \
    --disable-shared \
    --disable-docs \
    --with-zstd \
    --enable-lto \
    --with-isl \
    --disable-isl-version-check \
    --enable-default-ssp \
    --enable-languages=c \
    --with-pkgversion="MoonBase-Android-ToolChain" \
    --with-newlib \
    --with-gnu-as \
    --with-gnu-ld \
    --with-sysroot
  make all-gcc -j$(($(nproc --all) + 1))
  make all-target-libgcc -j$(($(nproc --all) + 1))
  make install-gcc -j$(($(nproc --all) + 1))
  make install-target-libgcc -j$(($(nproc --all) + 1))
  echo "Compiled Gnu/Gcc, Done"
}

download_resources
build_binutils
build_gcc
