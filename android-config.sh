#! /bin/bash

#
# Program : android-configure.sh
# Author  : Chris Conlon, yaSSL (www.yassl.com)
#
# Date    : January 27, 2012
#
# Description: This script will configure CyaSSL for cross
#              compilation by the Android NDK standalone
#              toolchain, and can be used as an alternat to
#              using the Android NDK framework to build CyaSSL
#              as done in the cyassl-android-ndk packate. 
#
#              As written, it only builds a static library. This 
#              can be easily modified below to build a shared library 
#              by changing build options passed to ./configure.
#
# Instructions:
#   1) Download, install, and set up Android NDK standalone
#      toolchain (http://developer.android.com/sdk/ndk/index.html).
#   2) Place this script in the root CyaSSL directory.
#   3) Adjust PATH and CCBIN (below) to match your environment
#   3) Run ./android-configure.sh
#   4) Run make
#   5) Copy built libraries in ./src/.libs to desired 
#      Android project.
#   6) Copy CyaSSL header files to Android NDK project
#

## Add Android NDK Cross Compile toolchain to path
#export NDK_TC_ROOT=/home/afernandes/opt/ndk-standalone-v21-arm
export NDK_TC_ROOT=/home/afernandes/opt/ndk-standalone-v21-x86
export PATH=$NDK_TC_ROOT:$PATH

## Set up variables to point to Cross-Compile tools
export CCBIN="$NDK_TC_ROOT/bin"
#export CCTOOL="$CCBIN/arm-linux-androideabi-"
export CCTOOL="$CCBIN/i686-linux-android-"

## Export our NDK Cross-Compile tools
export CC="${CCTOOL}gcc"
export RANLIB="${CCTOOL}ranlib"
export AR="${CCTOOL}ar"

## Configure the library
#arm build
#ac_cv_func_malloc_0_nonnull=yes ac_cv_func_realloc_0_nonnull=yes ./configure --host=arm-linux-androideabi --enable-static --disable-shared --prefix="/home/afernandes/work/krb5/cyassl-out" --enable-md4 --enable-pwdbased

#x86 build
ac_cv_func_malloc_0_nonnull=yes ac_cv_func_realloc_0_nonnull=yes ./configure --host=i686-linux-android --enable-static --disable-shared --prefix="/home/afernandes/work/krb5/cyassl-out" --enable-md4 --enable-pwdbased

make clean
make
make install
