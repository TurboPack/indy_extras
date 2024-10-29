#!/bin/bash
# This script requires nasm, and the MSYS2 version of Perl in addition to the standard
# toolchain.  You can install these using pacman.
#
  case "${MSYSTEM}" in
    MINGW32)
      _mingw=mingw
	  _win=win32
      ;;
    CLANG32)
      _mingw=mingw
	  _win=win32
      ;;
    MINGW64)
      _mingw=mingw64
	  _win=win64
      ;;
	CLANG64)
      _mingw=mingw64
	  _win=win64
      ;;	
    CLANGARM64)
      _mingw=mingwarm64
	  _win=winarm64
      ;;
  esac
# https://github.com/openssl/openssl/releases/tag/OpenSSL_1_1_1w
versions=("1_1_1w")
for ver in "${versions[@]}"; do
  if [ ! -e "openssl-${ver}.tar.gz" ]; then
    wget https://github.com/openssl/openssl/archive/refs/tags/OpenSSL_${ver}.tar.gz	
  fi
  
  rm -rf openssl-${ver} 
  

# now do shared
  tar zxf "OpenSSL_${ver}.tar.gz"
  if [ -d openssl_${ver} ]; then 
    cd openssl_${ver}
  else
    cd openssl-OpenSSL_${ver}
  fi
  /usr/bin/perl Configure ${_mingw} shared
  make
  zip "openssl-${ver}-${_win}.zip" *.dll
  zip "openssl-${ver}-${_win}.zip" LICENSE.txt
  cd apps
  zip ../"openssl-${ver}-${_win}.zip" openssl.exe
  cd ..
  zip "openssl-${ver}-${_win}.zip" providers/*.dll
  zip "openssl-${ver}-${_win}.zip" engines/*.dll
  mv "openssl-${ver}-${_win}.zip" ..
  cd ..
done




