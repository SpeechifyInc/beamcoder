#!/bin/bash
set -x

cd $(dirname $0)/ffmpeg
./configure --disable-autodetect --disable-doc --disable-programs --disable-static --disable-stripping --disable-debug --enable-gpl --enable-shared --enable-pic --enable-version3 --enable-libmp3lame --enable-libopus --enable-libvorbis --prefix=build
make
make install
