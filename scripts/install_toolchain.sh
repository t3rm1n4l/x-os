#!/bin/bash
#Description: Install i386-jos toolchain

MAKE="make -j8"
PREFIX="/opt/jos-toolchain"

if [ $UID -ne 0 ];
then
    echo Please run as root
    exit 1
fi

mkdir -p $PREFIX

apt-get install libgmp-dev libmpfr-dev libmpc-dev -y

wget http://mirrors.ispros.com.bd/gnu/binutils/binutils-2.12.tar.gz
wget http://stingray.cyber.net.pk/pub/gnu/gcc/gcc-4.5.2/gcc-4.5.2.tar.gz
wget http://ftp.gnu.org/gnu/gdb/gdb-7.5.tar.gz

tar -xzf binutils-2.12.tar.gz
pushd binutils-2.12
./configure --prefix=$PREFIX --target=i386-jos-elf --disable-werror
$MAKE
$MAKE install
popd

tar -xzf gcc-4.5.2.tar.gz
pushd gcc-4.5.2
mkdir build
pushd build
../configure --prefix=$PREFIX \
    --target=i386-jos-elf --disable-werror \
    --disable-libssp --disable-libmudflap --with-newlib \
    --without-headers --enable-languages=c,c++
$MAKE all-gcc
$MAKE install-gcc
$MAKE all-target-libgcc
$MAKE install-target-libgcc
popd
popd

tar -xzf gdb-7.5.tar.gz
pushd gdb-7.5
./configure --prefix=$PREFIX \
    --target=i386-jos-elf \
    --program-prefix=i386-jos-elf- \
    --disable-werror

$MAKE all
$MAKE install
