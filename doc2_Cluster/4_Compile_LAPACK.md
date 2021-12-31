---
sort: 4
---

# Compiling LAPACK & ScaLAPACK

## LAPACK & BLAS
Two of the most common used computational libraries are LAPACK and BLAS.  They are super fast in doing linear algebra operations involving matrices and vectors.
- BLAS (Basic Linear Algebra Subprograms) are routines that provide standard building blocks for performing basic vector and matrix operations. 
- LAPACK (Linear Algebra PACKage) is written in Fortran 90 and provides routines for solving systems of simultaneous linear equations, least-squares solutions of linear systems of equations, eigenvalue problems, and singular value problems.
- BLAS is need in LAPACK. BLAS & LAPACK can be install separately. First, you have to install BLAS before LAPACK, because LAPACK needs it. Download the packages from the following websites. ([see here](https://coral.ise.lehigh.edu/jild13/2016/07/27/install-lapack-and-blas-on-linux-based-systems/) and [here](https://stackoverflow.com/questions/63600714/how-to-build-blas-and-lapack-for-use-in-c-on-linux-cluster))
    - BLAS, see [http://www.netlib.org/blas/]
    - LAPACK, see [http://www.netlib.org/lapack/]
- Or can install LAPACK by cmake, where [soureCode LAPACK](https://github.com/Reference-LAPACK/lapack) also includes BLAS

### install LAPACK with cmake
- see CMAKE options in file CMakeLists.txt, 
- This way also install BLAS, CBLAS, LAPACKE, set `-DCBLAS=on -DLAPACKE=on`
```shell
tar -xvf lapack-3.10.0.tar.gz
cd lapack-3.10.0
mkdir build && cd build
```
```shell
module load tool_dev/cmake-3.21
module load compiler/gcc-11.2
export PATH=/uhome/p001cao/local/app/compiler/gcc-11.2/bin:$PATH
export CC=gcc  export CXX=g++  export FC=gfortran  
export LD_LIBRARY_PATH=/uhome/p001cao/local/app/compiler/gcc-11.2/lib64:$LD_LIBRARY_PATH

export myInstallDIR=/uhome/p001cao/local/app/lapack-3.10

cmake .. -DCBLAS=on -DLAPACKE=on \
-DCMAKE_INSTALL_LIBDIR=${myInstallDIR} \
-DCMAKE_INSTALL_INCLUDEDIR=${myInstallDIR}

make -j 8
make install 
```

### usage
```shell
export myLAPACK=/uhome/p001cao/local/app/lapack-3.10/liblapack.a
export myLAPACKE=/uhome/p001cao/local/app/lapack-3.10/liblapacke.a
export myBLAS=/uhome/p001cao/local/app/lapack-3.10/libblas.a
export myCBLAS=/uhome/p001cao/local/app/lapack-3.10/libcblas.a
```

## ScaLAPACK
ScaLAPACK (Scalable LAPACK) is a library of high-performance linear algebra routines for parallel distributed memory machines.
- Installing ScaLAPACK needs BLAS, LAPACK and BLACS library. (BLACS now included inside ScaLAPACK)
- ScaLAPACK now only supports MPI.
- Installation docs of ScaLAPACK [here](http://netlib.org/scalapack/scalapack_installer/README)
- Some guide [here](https://gitlab.com/arm-hpc/packages/-/wikis/packages/scalapack)
- [SouceCode](https://github.com/Reference-ScaLAPACK/scalapack)
- see CMAKE options in file CMakeLists.txt
```note 
ScaLAPACK can not compute with GCC-11
```
```shell
git clone https://github.com/Reference-ScaLAPACK/scalapack.git ScaLAPACK
cd ScaLAPACK
mkdir build && cd build
```
- Or download release
```shell
tar -xvf scalapack-2.1.0.tar.gz
cd scalapack-2.1.0
mkdir build && cd build
```

```shell
module load tool_dev/cmake-3.21          
module load mpi/ompi4.1.1-gcc11.2-noUCX-eagle

export PATH=/uhome/p001cao/local/app/openmpi/4.1.1-gcc11.2-noUCX-eagle/bin:$PATH
export CC=mpicc  export CXX=mpic++  export F90=mpif90 export F77=mpif77
export LD_LIBRARY_PATH=/uhome/p001cao/local/app/openmpi/4.1.1-gcc11.2-noUCX-eagle/lib:$LD_LIBRARY_PATH
export CFLAGS="-Ofast -march=x86-64" 
export FFLAGS="-Ofast -march=x86-64 -fallow-argument-mismatch"
```

### self-build BLAS and LAPACK
```shell
cmake .. -DUSE_OPTIMIZED_LAPACK_BLAS=on \
-DSCALAPACK_BUILD_TESTING=no \
-DCMAKE_C_COMPILER=mpicc -DCMAKE_Fortran_COMPILER=mpif77 \
-DCMAKE_INSTALL_PREFIX=/uhome/p001cao/local/app/ScaLAPACK-2.1 
```

### Install with preinstall BLAS and LAPACK
```shell
export myLAPACK=/uhome/p001cao/local/app/lapack-3.10/liblapack.a
export myBLAS=/uhome/p001cao/local/app/lapack-3.10/libblas.a

cmake .. -DBLAS_LIBRARIES=${myBLAS} -DLAPACK_LIBRARIES=${myLAPACK} \
-DCMAKE_C_COMPILER=mpicc -DCMAKE_Fortran_COMPILER=mpifort \
-DCMAKE_INSTALL_PREFIX=/uhome/p001cao/local/app/ScaLAPACK-2.1 



-DCMAKE_C_FLAGS="-Ofast -mtune=x86-64" -DCMAKE_Fortran_FLAGS="-Ofast -mtune=x86-64 -fallow-argument-mismatch" \

export CFLAGS="-Ofast -mtune=x86-64 " 
export FFLAGS="-Ofast -mtune=x86-64 -std=legacy"

-DCMAKE_Fortran_FLAGS="-std=legacy" \

export FFLAGS="-std=legacy"

```


## OpenBLAS
OpenBLAS is an open source optimized BLAS (Basic Linear Algebra Subprograms) library based on GotoBLAS2 1.13 BSD version.
- Installation  [here](https://iq.opengenus.org/install-openblas-from-source/)
- [SouceCode](https://github.com/xianyi/OpenBLAS)
- see CMAKE options in file CMakeLists.txt

```note 
- to create dynamic link (file *.so), use: -DBUILD_SHARED_LIBS=yes 
```
```shell
git clone https://github.com/xianyi/OpenBLAS.git
cd OpenBLAS
mkdir build && cd build
```
- Or download release
```shell
tar -xvf OpenBLAS-0.3.19.tar.gz
cd OpenBLAS-0.3.19
mkdir build && cd build
```

### UCS 2
```shell
module load tool_dev/cmake-3.20.3
module load mpi/ompi5.0.0-gcc11.2

cmake .. -DCMAKE_INSTALL_PREFIX=/home1/p001cao/local/app/tool_dev/openBLAS-0.3.19

make -j 16 && make install
```


```shell
## Usage
export myBLAS=/home1/p001cao/local/app/tool_dev/openBLAS-0.3.19/lib64/libopenblas.a   
cmake .. -DBLAS_LIBRARIES=${myBLAS} -DLAPACK_LIBRARIES=${myBLAS} \
```