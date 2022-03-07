#!/bin/bash
set -x

cd $(dirname $0)/ffmpeg
./configure --disable-autodetect --disable-doc --disable-everything --disable-programs --disable-static --disable-stripping --disable-debug --enable-gpl --enable-shared --enable-pic --enable-version3 --enable-decoder=libopus,libvorbis,mp3,pcm_s32le,pcm_s16le --enable-encoder=libopus,libvorbis,libmp3lame,pcm_s32le,pcm_s16le --enable-demuxer=mp3,ogg,wav --enable-muxer=mp3,ogg,wav --enable-protocol=file --enable-filter=asetnsamples --enable-libmp3lame --enable-libopus --enable-libvorbis --prefix=build
make
make install
