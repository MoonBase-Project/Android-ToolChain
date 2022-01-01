#!/bin/bash

time ./build-gcc.sh -a arm64 ; time rm -rf build-gcc build-binutils ; time ./build-gcc.sh -a arm ; time rm -rf build-gcc build-binutils ; time ./build-gcc.sh -a x86 ; time rm -rf build-gcc build-binutils

cd ../
rm -rf cross-tc
mkdir cross-tc

mv gcc-* cross-tc/

cp strip-all.sh cross-tc/

cd cross-tc/

du -hs .
echo "before strip"
time ./strip-all.sh
echo "after strip"
du -hs .

echo "]]]]]] DONE-DONE-DONE [[[[[["
