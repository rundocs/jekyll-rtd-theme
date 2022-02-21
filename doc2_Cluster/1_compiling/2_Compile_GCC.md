---
sort: 2
---

# Compiling GCC-11

The [GNU Compiler](https://gcc.gnu.org) Collection includes front ends for C, C++, Objective-C, Fortran, Ada, Go, and D, as well as libraries for these languages (libstdc++,...).

![pic](https://gcc.gnu.org/img/gccegg-65.png)

```note
- Some applications require C++11, this is only supported on GCC 4.8 or newer
- [intel 2018 support gcc versions 4.3 - 6.3](https://software.intel.com/en-us/articles/intel-c-compiler-180-for-linux-release-notes-for-intel-parallel-studio-xe-2018)
- compile GCC outside source-dir, to avoid modifying source code when compiling get fail
- cuda does not support gcc > 8 
```

## 1. Download:

* check all availabe versions GCC
  - [at this link](https://gcc.gnu.org/releases.html)
  - or check this:
  ```shell
  svn ls svn://gcc.gnu.org/svn/gcc/tags | grep gcc | grep release
  #or http://ftp.tsukuba.wide.ad.jp/software/gcc/releases
  ```
* download
  - use this
  ```shell
  wget http://ftp.tsukuba.wide.ad.jp/software/gcc/releases/gcc-10.3.0/gcc-10.3.0.tar.gz
  tar xvf gcc-10.3.0.tar.gz
  ```
  - or git
  ```shell
  git clone -b releases/gcc-11.2.0 https://github.com/gcc-mirror/gcc gcc-11.2.0
  ```

## 2. Install
Include 2 steps:
- **download prerequisites:**
```shell
cd gcc-11.2.0
./contrib/download_prerequisites
```
- **Configure:** [see this link](https://gcc.gnu.org/install/configure.html)
```note
configure error: uint64_t or int64_t not found     --> need at least gcc-4.5
```


### USC1: (eagle)
```shell
cd gcc-11.2
git checkout releases/gcc-11.2
./contrib/download_prerequisites

mkdir build && cd build
module load compiler/gcc-10.3         # to avoid:  uint64_t or int64_t not found 

../configure --enable-languages=c,c++,objc,obj-c++,fortran \
--enable-checking=release --enable-shared --disable-multilib --with-system-zlib \
--prefix=/uhome/p001cao/local/app/compiler/gcc-11.2
```

```make
make  -j 20         # not use -j to know what error
make install
# check: g++ -v
```

### USC 2
```shell 
mkdir build && cd build

../configure --enable-languages=c,c++,objc,obj-c++,fortran \
--enable-checking=release --enable-shared --disable-multilib --with-system-zlib \
--prefix=/home1/p001cao/local/app/compiler/gcc-11.2
```

### CAN
```shell 
--prefix=/home/thang/local/app/compiler/gcc-10.3
```

### CAN_GPU
```shell 
module load compiler/gcc-7.4   # cuda note support gcc > 8 
--prefix=/home/thang/local/app/compiler/gcc-10.3'
```


## 3. Make module file 
at directory: /uhome/p001cao/local/share/lmodfiles/GCC --> create file "gcc-11.2"

```shell
# for Tcl script use only
set             topdir          /uhome/p001cao/local/app/compiler/gcc-11.2

setenv           CC gcc
setenv           CXX g++
setenv           FC gfortran
setenv           F90 gfortran

prepend-path    PATH                    $topdir/bin
prepend-path    INCLUDE 	              $topdir/include/c++/11.2.0
prepend-path    LD_LIBRARY_PATH         $topdir/lib/gcc/x86_64-pc-linux-gnu/11.2.0
prepend-path    LD_LIBRARY_PATH         $topdir/lib64
prepend-path    LD_LIBRARY_PATH         $topdir/libexec/gcc/x86_64-pc-linux-gnu/11.2.0
prepend-path    INFOPATH                $topdir/share/info
```

