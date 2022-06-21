---
sort: 10
---

# LLVM

The [LLVM project](https://llvm.org/) has multiple components. The core of the project is itself called "LLVM". This contains all of the tools, libraries, and header files needed to process intermediate representations and convert them into object files. Tools include an assembler, disassembler, bitcode analyzer, and bitcode optimizer. It also contains basic regression tests.

C-like languages use the [Clang](https://clang.llvm.org/) frontend. This component compiles C, C++, Objective-C, and Objective-C++ code into LLVM bitcode -- and from there into object files, using LLVM.

Other components include: the [libc++ C++](https://libcxx.llvm.org/) standard library, the [LLD linker](https://lld.llvm.org/), and more.

**Requirements
Compiling LLVM requires that you have several software packages installed. The table below lists those required packages. The Package column is the usual name for the software package that LLVM depends on. The Version column provides “known to work” versions of the package. The Notes column describes how LLVM uses the package and provides other details.

|Package | Version |
|--|--|
|Cmakte | >=3.13.4|
| GCC   | >=7.1.0 |
| Python| >= 3.6 |
| BINUTILS | newer is better|

[See here](https://llvm.org/docs/GettingStarted.html#id14)

## Download

```shell
git clone --branch release/14.x https://github.com/llvm/llvm-project.git llvm-14
cd llvm-14
git pull origin release/14.x
mkdir build && cd build
```

## USC2: Tachyon

### use GCC

```note
- May need GCC >= 9. 
- Use `-DCMAKE_CXX_STANDARD=17` to avoid no digit exponent.
- use `CMAKE_C_FLAGS="-flax-vector-conversions"` avoid 128i convert error.
- consider -DLLVM_TARGETS_TO_BUILD="AArch64".
- must use `-DGCC_INSTALL_PREFIX -DCMAKE_CXX_LINK_FLAGS="-Wl,-rpath,${myCOMPILER}/lib64 -L${myCOMPILER}/lib64"` to have right link to libc.
- Dont use -DLLVM_ENABLE_RUNTIMES="compiler-rt;libc;libcxx;libcxxabi;libunwind". Instead, use DLLVM_ENABLE_RUNTIMES="compiler-rt;libc;libcxx;libcxxabi;libunwind" [see](https://llvm.org/docs/GettingStarted.html#id20).
- These modules may cause errors: compiler-rt;libunwind;libc
- Use Release/Debug
- See more https://llvm.org/docs/CMake.html
- LLDB require SWIG > 3.0
- LLVM require python >= 3.6, and python 3.6 require zlib>1.2.11 require GLIBC_2.14 (libgcc-ng=9). And zlib=1.2.11 will cause hidden libs by conda, so should update  zlib>1.2.11 to hidden error. Or should use static-link (libs*.a) or use absolute path to dynamic libs (*.so) in cmake to avoid this error. Note, link a dynamic lib (*.so) to a static lib (*.a) may cause " Dyanmic reloc overflow runtime" error, so best way is use absolute path to dynamic libs (*.so).
```

```shell
source activate py37Lammps
conda install -c conda-forge libgcc-ng=9 libstdcxx-ng=9 libgomp=9 zlib=1.2.11 python=3.7
```

**Install LLVM

```shell
# tar xvf llvm-project-llvmorg-14.0.5.tar.gz
# cd llvm-project-llvmorg-14.0.5
# rm -r llvm-14

git clone -b release/14.x https://github.com/llvm/llvm-project.git llvm-14
cd llvm-14.0.5
mkdir build && cd build

module load tool_dev/cmake-3.24
module load conda/py37Lammps
module load tool_dev/binutils-2.37
module load compiler/gcc-11.2

export myCOMPILER=/home1/p001cao/local/app/compiler/gcc-11.2
export PATH=$PATH:${myCOMPILER}/bin                                 # :/usr/bin
export CC=gcc export CXX=g++
export LDFLAGS="-fuse-ld=gold -lrt"   
export myZLIB=/home1/p001cao/local/app/tool_dev/zlib-1.2.12           # avoid zlib hidden by conda
export CFLAGS="-gdwarf-4 -gstrict-dwarf"       # avoid dwarf5 error

cmake ../llvm -DCMAKE_BUILD_TYPE=Release \
-DLLVM_ENABLE_PROJECTS="clang;clang-tools-extra;libclc;lld;openmp;polly;pstl;mlir;flang;libcxx;libcxxabi" \
-DGCC_INSTALL_PREFIX=${myCOMPILER} \
-DCMAKE_CXX_LINK_FLAGS="-Wl,-rpath,${myCOMPILER}/lib64 -L${myCOMPILER}/lib64" \
-DCMAKE_CXX_STANDARD=17 \
-DCMAKE_C_FLAGS="-flax-vector-conversions" -DCMAKE_C_FLAGS_RELEASE="-flax-vector-conversions" \
-DZLIB_INCLUDE_DIR=${myZLIB} -DZLIB_LIBRARY=${myZLIB}/lib/libz.so.1.2.12 \
-DCMAKE_INSTALL_PREFIX=/home1/p001cao/local/app/compiler/llvm-14

make -j 16 && make install
```

check:

```shell
module load mpi/ompi4.1.3-clang14
clang -v
```

Options:

```shell
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:${myCOMPILER}/lib

-DLLVM_ENABLE_RUNTIMES="libunwind;libcxx"
-DLLVM_ENABLE_PROJECTS="clang;clang-tools-extra;flang;libclc;lld;openmp;polly;pstl;mlir" \  # "clang;flang;lld;openmp"
-DCMAKE_CXX_LINK_FLAGS="-Wl,-rpath,${myCOMPILER}/lib64 -L${myCOMPILER}/lib64" \
```

**Ref
https://stackoverflow.com/questions/69683755/libpng-apngerror-o-requires-dynamic-r-x86-64-pc32-reloc-against-stderr
[2]. [Dynamic relocs, runtime overflows and -fPIC](https://tinyurl.com/2bw9jo5q)

### Module file

at directory: /home1/p001cao/local/1myModfiles/compiler --> create file "llvm-14"

```shell
# for Tcl script use only
set     topdir          /home1/p001cao/local/app/compiler/llvm-14
set     version         clang-14.0

prepend-path    PATH                    $topdir/bin
prepend-path    LD_LIBRARY_PATH         $topdir/lib
prepend-path    LD_LIBRARY_PATH         $topdir/libexec
prepend-path    INCLUDE                 $topdir/include
# prepend-path    INCLUDE                 $topdir/include/c++/v1

```

### use GCC-conda
```note
use conda can install: gcc, cmake,... and other libs. But note install LLVM, since new GLIBC is required, 
```

**Install Conda (Since LLVM require python >= 3.6)

```shell
conda create -n py37gcc12 python=3.7
source activate py37gcc12
conda install -c conda-forge libgcc-ng=12 libstdcxx-ng=12 libgomp=12 cmake=3 binutils
```

**Install LLVM

```shell
git clone -b release/14.x https://github.com/llvm/llvm-project.git llvm-14
cd llvm-14
mkdir build_conda && cd build_conda

module load conda/py37gcc12

export myCOMPILER=/home1/p001cao/local/app/miniconda3/envs/py37gcc12
export PATH=${myCOMPILER}/bin:$PATH                                     # :/usr/bin
export CC=gcc export CXX=g++
export LDFLAGS="-fuse-ld=gold -lrt"
export CFLAGS="-gdwarf-4 -gstrict-dwarf -flax-vector-conversions"

cmake ../llvm -DCMAKE_BUILD_TYPE=Release \
-DCMAKE_CXX_STANDARD=17 \
-DLLVM_ENABLE_PROJECTS="clang;clang-tools-extra;libclc;lld;openmp;polly;pstl;mlir;flang;libcxx;libcxxabi" \
-DGCC_INSTALL_PREFIX=${myCOMPILER} \
-DCMAKE_CXX_LINK_FLAGS="-Wl,-rpath,${myCOMPILER}/lib64 -L${myCOMPILER}/lib64" \
-DCMAKE_INSTALL_PREFIX=/home1/p001cao/local/app/compiler/llvm-14-conda

make -j 16 && make install
```
