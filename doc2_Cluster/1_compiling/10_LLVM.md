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
|Cmakte | >=3.13.4|
| GCC   | >=7.1.0 |
| Python| >= 3.6 |

[See here](https://llvm.org/docs/GettingStarted.html#id14)

## Download

```shell
git clone --branch release/14.x https://github.com/llvm/llvm-project.git llvm-14
cd llvm-14
git pull origin release/14.x
mkdir build && cd build
```

## USC2: Tachyon

```shell
tar xvf llvm-project-llvmorg-14.0.3.tar.gz
cd llvm-project-llvmorg-14.0.3
mkdir build && cd build

module load tool_dev/cmake-3.20.3
module load conda/py37Lammps
module load compiler/gcc-10.3

export PATH=$PATH:/home1/p001cao/local/app/compiler/gcc-10.3/bin
export CC=gcc export CXX=g++ export FORTRAN=gfortran

cmake ../llvm -DCMAKE_BUILD_TYPE=Release \
-DLLVM_ENABLE_ASSERTIONS=ON -DLLVM_OPTIMIZED_TABLEGEN=ON -DCMAKE_CXX_STANDARD=17 \
-DLLVM_ENABLE_PROJECTS=all \
-DCMAKE_INSTALL_PREFIX=/home1/p001cao/local/app/compiler/llvm-14.0.3

```
