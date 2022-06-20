---
sort: 8
---

# Compiling Binutils

to use Gold linker (first released in binutils version 2.19), should to avoid link-error
https://mirror.yongbok.net/gnu/binutils/?C=M&O=D
There are three linkers available on modern GNU/Linux systems:
    - ld, maintained by GNU binutils,
    - gold, maintained by GNU binutils, "still in beta test",
    - lld, developed as part of the LLVM project.
For speed benchmarks, see: https://www.phoronix.com/scan.php?page=article&item=lld4-linux-tests&num=2 TL, DR: lld is fastest, followed by gold, followed by ld
check  binutils version:  ld -v

Install: http://www.linuxfromscratch.org/lfs/view/development/chapter06/binutils.html

## UCS2: working Ver: 2.32; 2.35.1
```shell
tar zxvf binutils-2.37.tar.gz             
cd binutils-2.37
mkdir build  &&  cd build
module load compiler/gcc-11.2

../configure --enable-gold=yes --enable-ld=default --enable-lto \
--enable-plugins --enable-shared --disable-werror \
--enable-64-bit-bfd --with-system-zlib \
--prefix=/home1/p001cao/local/app/tool_dev/binutils-2.37

make -j 16  && make install
```

check:  ld -v


## UCS1: 
- work with binutils-2.36.1, to avoid error in GCC-11

```shell
tar zxvf binutils-2.36.1.tar.gz             
cd binutils-2.36.1
mkdir build  &&  cd build

../configure --enable-gold=yes --enable-ld=default --enable-lto \
--enable-plugins --enable-shared --disable-werror \
--enable-64-bit-bfd --with-system-zlib \
--prefix=/uhome/p001cao/local/app/tool_dev/binutils-2.36
```




## create module file
cd /uhome/p001cao/local/Imodfiles  -->  create file "cmake-3.20.3"
```shell
# for Tcl script use only
set     topdir          /home1/p001cao/local/app/tool_dev/binutils-2.37

prepend-path    PATH                    $topdir/bin
prepend-path    LD_LIBRARY_PATH         $topdir/lib
prepend-path    INCLUDE 	        $topdir/include
```

## Zlib
```shell
wget -c --no-check-certificate https://zlib.net/zlib-1.2.12.tar.gz
tar zxvf zlib-1.2.12.tar.gz
cd zlib-1.2.12

./configure --enable-shared --prefix=/home1/p001cao/local/app/tool_dev/zlib-1.2.12
make -j 16 && make install
```

