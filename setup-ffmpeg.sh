#!/bin/bash
set -e
set -u

JVAL=16

ROOT_DIR=$(realpath $(dirname $0)/ffmpeg)
echo $ROOT_DIR
cd $ROOT_DIR

EXTERNAL_DIR=$(realpath external/)
TARGET_DIR=$(realpath build/)

rm -rf $EXTERNAL_DIR
rm -rf $TARGET_DIR
mkdir $EXTERNAL_DIR

#download and extract package
download() {
  url="$1"
  wget $url -O - | tar -xzf - -C $EXTERNAL_DIR
}

# Download Ogg, Opus, Vorbis and Mp3Lame
download "https://github.com/xiph/ogg/archive/refs/tags/v1.3.5.tar.gz"
download "https://github.com/xiph/opus/archive/refs/tags/v1.1.2.tar.gz"
download "https://github.com/xiph/vorbis/archive/refs/tags/v1.3.7.tar.gz"
download "https://iweb.dl.sourceforge.net/project/lame/lame/3.100/lame-3.100.tar.gz"

echo "*** Building mp3lame ***"
cd external/lame*
make distclean || true
./configure --prefix=$TARGET_DIR --enable-nasm --disable-static --enable-shared
CFLAGS="-I$TARGET_DIR/include" LDFLAGS="-L$TARGET_DIR/lib" make -j $JVAL
make install
cd ..

echo "*** Building libogg ***"
cd $EXTERNAL_DIR/ogg*
make distclean || true
./autogen.sh
./configure --prefix=$TARGET_DIR --disable-static --enable-shared
CFLAGS="-I$TARGET_DIR/include" LDFLAGS="-L$TARGET_DIR/lib" make -j $JVAL
make install

echo "*** Building libvorbis ***"
cd $EXTERNAL_DIR/vorbis*
make distclean || true
./autogen.sh
./configure --prefix=$TARGET_DIR --disable-static --enable-shared
CFLAGS="-I$TARGET_DIR/include" LDFLAGS="-L$TARGET_DIR/lib" make -j $JVAL
make install
cd ..

echo "*** Building opus ***"
cd $EXTERNAL_DIR/opus*
make distclean || true
./autogen.sh
./configure --prefix=$TARGET_DIR --disable-static --enable-shared
# Specify opus target to avoid generating docs since it throws an error
CFLAGS="-I$TARGET_DIR/include" LDFLAGS="-L$TARGET_DIR/lib" make opus -j $JVAL
make install

echo "*** Building ffmpeg ***"
cd $ROOT_DIR
make distclean || true
./configure --disable-autodetect --disable-doc --disable-everything --disable-programs --disable-static --disable-stripping --disable-debug --enable-gpl --enable-shared --enable-pic --enable-version3 --enable-decoder=libopus,libvorbis,mp3,pcm_s32le,pcm_s16le --enable-encoder=libopus,libvorbis,libmp3lame,pcm_s32le,pcm_s16le --enable-demuxer=mp3,ogg,wav --enable-muxer=mp3,ogg,wav --enable-protocol=file --enable-filter=asetnsamples,aresample --enable-libmp3lame --enable-libopus --enable-libvorbis --prefix=build
make -j $JVAL
make install
