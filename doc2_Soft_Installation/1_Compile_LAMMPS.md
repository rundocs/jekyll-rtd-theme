---
sort: 1
---

# Compiling LAMMPS

This note is not to tell about what is [LAMMPS](https://www.lammps.org)? but the struggling work to deploy it on some Linux servers.

![Lammps logo](https://www.lammps.org/movies/logo.gif)

## Preparation

### 1. Prerequisite:
- Compiler: Intel, GCC, Clang,... 
- MPI implementation: OMPI, IMPI, MPICH,...
- Libraries depend on which packages will be installed: FFTW, intel MKL,...
- Newer LAMMPS may be no longer compatible with an old openMPI, as well FFTW/MKL, so these libs need to be updated too.
- OpenMPI may the fastest
- There is no longer USER_ packages from Jul-2021
- Need CMAKE, newer is better (a newer Cmake version may reduce the probability of error during compiling). Basic cmake: <br>
```shell
cmake -D OPTION_A=VALUE_A -D OPTION_B=VALUE_B ...     ../cmake make
```
- Module evironment
```shell
module load <module_name>
module display <module_name> 
```
- Only one installation for `eagle/lion/leopard/cheetah`, but need to load different OpenMPI for each cluster. Also need to load Conda to overwrite default python of the system (different Ver. of python may cause runtime error)


### 2. Download: 

[LAMMPS site](https://lammps.sandia.gov/bug.html) <br>
[Souce code](https://github.com/lammps/lammps) <br>

**download tar file**
```shell
tar -xvf lammps-stable_7Aug2019
cd lammps-stable_7Aug2019
mkdir build && cd build
```
**or download use Git:**
```shell
git clone --branch patch_20Nov2019 https://github.com/lammps/lammps.git lammps_patch_20Nov2019
cd lammps_patch_20Nov2019
git checkout patch_20Nov2019
```
```shell
git clone https://github.com/lammps/lammps.git    lammps_master
cd lammps_master
git pull origin master
```

### 3. Packages: 
NOTEs: include these OPTIONS in Cmake command, to build package-lib automatically:

  1. **UFM potential**
```shell
cd lammps-folder/src/
git clone https://github.com/plrodolfo/FluidFreeEnergyforLAMMPS.git USER-FFE
copy new pair_ufm into /src
copy new pair_eam.cpp & pair_eam.h into /src and delete corresponding files in /src/MANYBODY
```
  2. **POEMS, OPT**
```shell
-D PKG_OPT=yes
```
3. **MSCG**
```shell
-D PKG_MSCG=yes -D DOWNLOAD_MSCG=yes
```
5. **VORONOI**
```shell
-D PKG_VORONOI=yes -D DOWNLOAD_VORO=yes
```
6. **KSPACE**
- if use MKL for FFT, then need MKL library 
```shell
-D FFT=MKL  \
-D MKL_INCLUDE_DIRS=/uhome/p001cao/local/intel/xe2019/compilers_and_libraries_2019.5.281/linux/mkl/include  \
-D MKL_LIBRARY=/uhome/p001cao/local/intel/xe2019/compilers_and_libraries_2019.5.281/linux/mkl/lib/intel64  \
```
- if FTWW3, then dont need MKL_LIBRARY
```shell
-D FFT=FFTW3
-D FFTW3_INCLUDE_DIRS=/uhome/p001cao/local/fftw/3.3.8-openmpi4.0.1-Intel2019xe-double/include \
-D FFTW3_LIBRARY=/uhome/p001cao/local/fftw/3.3.8-openmpi4.0.1-Intel2019xe-double/lib \
```
- or use FFTW3 from intel_mkl: (not support long-double precision)
```shell
-D FFT=FFTW3 
-D FFTW3_INCLUDE_DIRS=/uhome/p001cao/local/intel/xe2018/compilers_and_libraries_2018.0.128/linux/mkl/include/fftw 
```
7. **LAPACK & BLAS** <br>
Use "intel/mkl" package, then LAPACK & BLAS will be found automatically
```shell
module load intel/mkl
module load tool_dev/gsl-2.6
```
8. **OpenMP**
```shell
-D PKG_USER-OMP=yes -D BUILD_OMP=yes -D PKG_USER-INTEL=no
```
9. **make no packages**
```shell
-D PKG_GPU=no -D PKG_KIM=no -D PKG_LATTE=no -D PKG_MSCG=no -D PKG_KOKKOS=no \
-D PKG_USER-ADIOS=no -D PKG_USER-NETCDF=no -D PKG_USER-OMP=no -D PKG_USER-INTEL=no \
-D PKG_USER-QUIP=no -D PKG_USER-SCAFACOS=no -D PKG_USER-QMMM=no -D PKG_USER-VTK=no \
-D PKG_USER-H5MD=no \
```
10. [**KOKKOS**](https://lammps.sandia.gov/doc/Build_extras.html#kokkos) <br>
For multicore CPUs using OpenMP, set these 2 variables.
```shell
-DKokkos_ARCH_WSM=yes                 # HOSTARCH = HOST from list above 
-DKokkos_ENABLE_OPENMP=yes 
-DBUILD_OMP=yes
```
11. [**PLUMED**](https://lammps.sandia.gov/doc/Build_extras.html#user-plumed)
- **pre-compile Plumed separately:**
```shell
module load plumed
```
```shell
-D PKG_PLUMED=yes -D DOWNLOAD_PLUMED=no -D PLUMED_MODE=static
```
- **self-build PLUMED:** will need GSL to link LAPACK, BLAS (require MKL)
```shell
-D PKG_PLUMED=yes -D DOWNLOAD_PLUMED=yes -D PLUMED_MODE=static
```
- **self-build PLUMED:** Configure Plumed to use Internal LAPACK&BLAS: (no need install BLAS&LAPACK or MKL+GSL)
open file: ../cmake/Modules/Packages/USER-PLUMED.cmake

Comment out these lines:
```shell
  # find_package(LAPACK REQUIRED)
  # find_package(BLAS REQUIRED)
  # find_package(GSL REQUIRED)
  # list(APPEND PLUMED_LINK_LIBS ${LAPACK_LIBRARIES} ${BLAS_LIBRARIES} GSL::gsl)
```
change lines: 
```shell
# URL http...... (line 65)
# URL_MD5
```
into: 
```shell
GIT_REPOSITORY https://github.com/plumed/plumed2.git 
GIT_TAG master                            # hack-the-tree   v2.6.2   v2.7b
```
```shell
CONFIGURE_COMMAND <SOURCE_DIR>/configure  ....   ...
            --enable-modules=all --enable-asmjit --disable-external-blas --disable-external-lapack
```
add this command after line 76 (inside ExternalProject_Add(...)): UPDATE_COMMAND 

12. **SMD** require Eigen
```shell
-D PKG_SMD=yes -D DOWNLOAD_EIGEN3=yes
```
open file: ../cmake/Modules/Packages/USER-SMD.cmake

change: 
```shell
URL http...... (line 12)
URL_MD5
```
into:
```shell
GIT_REPOSITORY https://github.com/eigenteam/eigen-git-mirror.git 
GIT_TAG  3.3.7
```
13. **MLIAP**
- require python >3.6

14. **MOLFILE package**
* to dump PDB file, need install VMD-plugins
* compatible with VMD 1.9 and 1.9.1
* [Compile VMD](http://www.ks.uiuc.edu/Research/vmd/plugins/doxygen/compiling.html)
   - **compile plugins** (just this is need for Lammps)
https://www.discngine.com/blog/2019/5/25/building-the-vmd-molfile-plugin-from-source-code
```shell
tar zxvf vmd-1.9.src.tar.gz
cd plugins
make LINUXPPC64
export PLUGINDIR=/uhome/p001cao/local/wSourceCode/vmd/vmd-1.9/plugins
make distrib
```
   - **compile VMD**
```shell
cd vmd-1.9.4a51
module load compiler/gcc-10.3
export VMDINSTALLDIR=/uhome/p001cao/local/app/vmd
./configure LINUXPPC64 OPENGL SILENT PTHREADS
cd src
make
```
* path in lib/molfile/Make.lammps: molfile_SYSPATH =-L/uhome/p001cao/local/wSourceCode/vmd/vmd-1.9/plugins/LINUXPPC64/molfile
```shell
export =/uhome/p001cao/local/wSourceCode/vmd/vmd-1.9/plugins/include
```
```shell
-D MOLFILE_INCLUDE_DIR=${PlugIncDIR}
-D PKG_MOLFILE=yes
```
15. **PYTHON** (use 1 of following ways)
Note: new numpy require higher GLIBC
- use module load --> do not need setting in Cmake
```shell
module load conda/py37Lammps
```
- use Python_ROOT_DIR (same as module load): --> will encounter the error: Anaconda environments prevent CMake from generating a safe runtime search path --> cannot be solved so far 
```shell
export pyROOT=/uhome/p001cao/local/app/miniconda3/envs/py37Lammps
```
```make
-DPython_ROOT_DIR=${pyROOT}
```
- use Python_EXECUTABLE # (Python_EXECUTABLE depend on cmake's version) (but this case still use system Python while compiling, so cannot use on multi-OS with different Versions )
```shell
export pyEXE=/uhome/p001cao/local/app/miniconda3/envs/py37Lammps/bin/python
export pyINC=/uhome/p001cao/local/app/miniconda3/envs/py37Lammps/include/python3.7m
export pyLIB=/uhome/p001cao/local/app/miniconda3/envs/py37Lammps/lib/libpython3.7m.a  
```
```shell
-DPython_EXECUTABLE=${pyEXE} -DPython_INCLUDE_DIR=${pyINC} -DPython_LIBRARY=${pyLIB} 
```

# Compiling 

# A. Open MPI + GCC
```note
```
- must export compilers to to avoid miss matching compilers
```shell
export PATH=/uhome/p001cao/local/app/openmpi/4.1.1-gcc11.2-noUCX-eagle/bin:$PATH
export CC=mpicc  export CXX=mpic++  export FORTRAN=mpifort
```
- "GCC + gold linker" is good now
```shell
module load tool_dev/binutils-2.36
```
```shell
-DCMAKE_EXE_LINKER_FLAGS="-fuse-ld=gold -lrt"
```
- use MKL
```shell
module load intel/mkl-xe19u5
source mklvars.sh intel64
module load tool_dev/gsl-2.6
```
```shell
-DFFT=MKL
```
- use external BLAS&LAPACK instead of MKL
```shell
export myLAPACK=/uhome/p001cao/local/app/lapack-3.9/liblapack.a
export myBLAS=/uhome/p001cao/local/app/blas-3.8/libfblas.a
```
```shell
-DBLAS_LIBRARIES=${myBLAS} -DLAPACK_LIBRARIES=${myLAPACK}
```
- use FFTW instead of MKL
```shell
module load fftw/fftw3.3.8-ompi4.1-gcc11.2
```
```shell
-DFFT=FFTW3
```
- consider linkers
```
module load llvm/llvm-gcc10-lld                    # to use lld
-DCMAKE_EXE_LINKER_FLAGS="-fuse-ld=lld -lrt" \
module load tool_dev/binutils-2.35                # gold
-DCMAKE_EXE_LINKER_FLAGS="-fuse-ld=gold -lrt" \
```
   

## 1. USC1 (eagle)
```note
- use different openmpi for Eagle vs Lion
- Note: python>3.7.9 require GLIBC new
`conda install python=3.7.5 pandas=1.0 numpy=1.19`
- Use GCC-11 need also update GCC-conda = 11
`conda install -c conda-forge libstdcxx-ng=11 libgcc-ng=11 libgfortran-ng=11`
```

```shell
cd lammps_master 
mkdir build   &&   cd build

module load tool_dev/binutils-2.36         # gold
module load tool_dev/cmake-3.21
module load fftw/fftw3.3.8-ompi4.1-gcc11.2
module load conda/py37Lammps               # python 3
module load mpi/ompi4.1.1-gcc11.2-noUCX-eagle

export PATH=/uhome/p001cao/local/app/openmpi/4.1.1-gcc11.2-noUCX-eagle/bin:$PATH
export CC=mpicc  export CXX=mpic++  export FORTRAN=mpifort
# MOLFILE_plugins:
export PlugIncDIR=/uhome/p001cao/local/wSourceCode/vmd/vmd-1.9/plugins/include
```

```shell
cmake ../cmake -C ../cmake/presets/all_on.cmake \
-DCMAKE_EXE_LINKER_FLAGS="-fuse-ld=gold -lrt" \
-DLAMMPS_EXCEPTIONS=yes -DBUILD_MPI=yes -DBUILD_OMP=yes -DLAMMPS_MACHINE=mpi \
-DPKG_OPENMP=yes -DPKG_INTEL=no -DPKG_GPU=no -DPKG_KOKKOS=no \
-DDOWNLOAD_EIGEN3=yes -DDOWNLOAD_VORO=yes -DPKG_KIM=no \
-DPKG_LATTE=no -DPKG_MSCG=no -DPKG_ATC=no -DPKG_MESONT=no  \
-DPKG_ADIOS=no -DPKG_NETCDF=no -DPKG_ML-QUIP=no -DPKG_SCAFACOS=no \
-DPKG_VTK=no -DPKG_H5MD=no \
-DMOLFILE_INCLUDE_DIR=${PlugIncDIR} \
-DFFT=FFTW3 \
-DPKG_PLUMED=yes -DDOWNLOAD_PLUMED=yes\
-DCMAKE_C_COMPILER=mpicc -DCMAKE_CXX_COMPILER=mpic++ -DCMAKE_Fortran_COMPILER=mpifort \
-DCMAKE_INSTALL_PREFIX=/uhome/p001cao/local/app/lammps/gccOMPI-master
```
```shell
make -j 8
# test:  mpirun -np 2 lmp_mpi
make install
```

## 2. USC2 (cheetah)
```shell
#module load mpi/ompi4.0.4-gcc10.1.0-lld
#module load llvm/llvm-gcc10-lld                    # to use lld 

module load mpi/ompi4.1.1-gcc10.3
module load tool_dev/binutils-2.35                # gold 
module load tool_dev/cmake-3.20.3
module load fftw/fftw3.3.8-ompi4.1-gcc10.3

export PATH=$PATH:/home1/p001cao/local/app/openmpi/4.1.1-gcc10.3/bin
export CC=mpicc  export CXX=mpic++  export FORTRAN=mpifort
## python (require py3) 
export pyROOT=/home1/p001cao/local/app/miniconda3/envs/py37Lammps
```
```make
cmake ../cmake -C ../cmake/presets/all_on.cmake \
-DCMAKE_EXE_LINKER_FLAGS="-fuse-ld=gold -lrt" \
-DPython_ROOT_DIR=${pyROOT} \
-DLAMMPS_EXCEPTIONS=yes -DBUILD_MPI=yes -DBUILD_OMP=yes -DLAMMPS_MACHINE=mpi \
-DPKG_OPENMP=yes -DPKG_INTEL=no -DPKG_GPU=no -DPKG_KOKKOS=no \
-DDOWNLOAD_EIGEN3=yes -DDOWNLOAD_VORO=yes \
-DPKG_KIM=no -DDOWNLOAD_KIM=no -DPKG_LATTE=no -DPKG_MSCG=no -DPKG_ATC=no -DPKG_MESONT=no  \
-DPKG_ADIOS=no -DPKG_NETCDF=no -DPKG_ML-QUIP=no -DPKG_SCAFACOS=no \
-DPKG_VTK=no -DPKG_H5MD=no \
-DFFT=FFTW3 \
-DPKG_PLUMED=yes -DDOWNLOAD_PLUMED=yes\
-DCMAKE_C_COMPILER=mpicc -DCMAKE_CXX_COMPILER=mpic++ -DCMAKE_Fortran_COMPILER=mpifort \
-DCMAKE_INSTALL_PREFIX=/home1/p001cao/local/app/lammps/gccOMPI-master
```


\# use Internal LAPACK&BLAS, then no need (GSL & MKL): open file: ../cmake/Modules/Packages/USER_PLUMED.cmake
comment out line 9-->12: find LAPACK, BLAS, GSL (Plumed build itself, no need GSL anymore)
--> then, do not need these:
module load tool_dev/gsl-2.6
module load intel/mkl-xe19u5
source mklvars.sh intel64
-DFFT=MKL \    # must set before Plumed

\# load plumed separately (bad alloc)
module load plumed2/2.7htt-gcc
-DPKG_USER-PLUMED=yes -DDOWNLOAD_PLUMED=no -DPLUMED_MODE=shared \

\#openKim: 
must create module file for openKim to add its PKG's path

## 3. CAN-GPU    
# https://docs.lammps.org/Build_extras.html#gpu
```shell
module load mpi/ompi4.1-gcc7.4-cuda      # cuda-10 only support to gcc-8
module load cmake-3.20.3
module load fftw/fftw3.3.8-ompi4.1-gcc7.4

export PATH=$PATH:/home/thang/local/app/openmpi/4.1.1-gcc7.4-cuda/bin
export CC=mpicc  export CXX=mpic++  export FORTRAN=mpifort
# python (require py3) 
export pyROOT=/home/thang/local/app/miniconda3/envs/py37
# cuda
export CUDA_PATH=/home/thang/local/app/cuda-10.2
export bin2c=/home/thang/local/app/cuda-10.2/bin/bin2c
```
```make
cmake ../cmake -C ../cmake/presets/all_on.cmake \
-DPython_ROOT_DIR=${pyROOT} \
-DLAMMPS_EXCEPTIONS=yes -DBUILD_MPI=yes -DBUILD_OMP=yes -DLAMMPS_MACHINE=mpi \
-DPKG_OPENMP=yes -D PKG_OPT=yes -DPKG_INTEL=no -DPKG_KOKKOS=no \
-DPKG_GPU=yes -DGPU_API=cuda -DGPU_ARCH=sm_60 -DBIN2C=${bin2c} -DGPU_PREC=double \
-DDOWNLOAD_EIGEN3=yes -DDOWNLOAD_VORO=yes \
-DPKG_KIM=no -DDOWNLOAD_KIM=no -DPKG_LATTE=no -DPKG_MSCG=no -DPKG_ATC=no -DPKG_MESONT=no  \
-DPKG_ADIOS=no -DPKG_NETCDF=no -DPKG_ML-QUIP=no -DPKG_SCAFACOS=no \
-DPKG_VTK=no -DPKG_H5MD=no \
-DFFT=FFTW3 \
-DPKG_PLUMED=yes -DDOWNLOAD_PLUMED=yes\
-DCMAKE_C_COMPILER=mpicc -DCMAKE_CXX_COMPILER=mpic++ -DCMAKE_Fortran_COMPILER=mpifort \
-DCMAKE_INSTALL_PREFIX=/home/thang/local/app/lammps/gccOMPI-master
```


\#####################

KOKKOS (USC 2) - 05May20 (error tbb_malloc  --> change TBB folder in file TBB.cmake)

-DBUILD_OMP=yes -DKokkos_ARCH_WSM=yes -DKokkos_ENABLE_OPENMP=yes  \
-DLMP_KOKKOS_USE_ATOMICS=yes -DKokkos_ENABLE_HWLOC=yes \

## TBB lib

set     topdir          /home1/p001cao/local/wSourceCode/Tooldev/oneTBB-2020.2
setenv          TBBROOT                 $topdir/bin
prepend-path    INCLUDE          $topdir/include
prepend-path    LD_LIBRARY_PATH         $topdir/build/linux_intel64_gcc_cc9.2.0_libc2.12_kernel2.6.32_release


##-- edit /cmake/Modules/FindTBB_MALLOC.cmake

find_path(TBB_MALLOC_INCLUDE_DIR NAMES tbb.h PATHS $ENV{TBBROOT}/include/tbb)
find_library(TBB_MALLOC_LIBRARY NAMES tbbmalloc PATHS $ENV{TBBROOT}/lib/intel64/gcc4.7

                                                       $ENV{TBBROOT}/build/linux_intel64_gcc_cc9.2.0_libc2.12_kernel2.6.32_release)


https://github.com/kokkos/kokkos/blob/master/BUILD.md
##-- must use
https://stackoverflow.com/questions/52018092/how-to-set-rpath-and-runpath-with-gcc-ld#52020177
export myGCC=/home1/p001cao/local/app/compiler/gcc-9.2.0
-DCMAKE_CXX_LINK_FLAGS="-L${myGCC}/lib64 -Wl,-rpath,${myGCC}/lib64" \

##--
module load mpi/ompi4.0.3-gcc9.2.0 
module load tool_dev/gsl-2.6 
module load tool_dev/cmake-3.17.2

module load tool_dev/binutils-2.32    
module load tool_dev/tbb-2020.2 
 export TBB_MALLOC_LIBRARY 
 export TBB_MALLOC_INCLUDE_DIR
cmake ../cmake -C ../cmake/presets/all_on.cmake \
-DCMAKE_EXE_LINKER_FLAGS="-fuse-ld=gold -lrt" \
-DBUILD_MPI=yes -DLAMMPS_MACHINE=mpi \
-DBUILD_OMP=yes -DKokkos_ARCH_WSM=yes -DKokkos_ENABLE_OPENMP=yes  \
-DBUILD_SHARED_LIBS=yes -DLAMMPS_EXCEPTIONS=yes \
-DPKG_GPU=no -DPKG_LATTE=no -DPKG_KIM=no -DPKG_MSCG=no -DPKG_USER-INTEL=no\
-DDOWNLOAD_VORO=yes -DDOWNLOAD_EIGEN3=yes \
-DPKG_USER-ADIOS=no -DPKG_USER-NETCDF=no -DPKG_USER-QUIP=no -DPKG_USER-SCAFACOS=no \
-DPKG_USER-QMMM=no -DPKG_USER-VTK=no -DPKG_USER-H5MD=no \
-DCMAKE_INSTALL_PREFIX=/home1/p001cao/local/app/lammps/05May20-gcc
C1. OpenSHMEM + GCC
module load mpi/ompi4.1.0-gcc10.2
module load tool_dev/binutils-2.35                # gold 
module load tool_dev/cmake-3.18.0
module load fftw/fftw3.3.8-ompi4.1-gcc10.2
##
export PATH=$PATH:/home1/p001cao/local/app/openmpi/4.1.0-gcc10.2/bin
export CC=shmemcc
export CXX=shmemc++
export FORTRAN=shmemfort
cmake ../cmake -C ../cmake/presets/all_on.cmake \
-DCMAKE_EXE_LINKER_FLAGS="-fuse-ld=gold -lrt" \
-DLAMMPS_EXCEPTIONS=yes -DBUILD_MPI=yes -DBUILD_OMP=yes -DLAMMPS_MACHINE=mpi \
-DPKG_USER-OMP=yes -DPKG_USER-INTEL=no -DPKG_GPU=no -DPKG_KOKKOS=no \
-DPKG_USER-SMD=yes -DDOWNLOAD_EIGEN3=yes -DDOWNLOAD_VORO=yes \
-DPKG_KIM=no -DDOWNLOAD_KIM=no -DPKG_LATTE=no -DPKG_MSCG=no -DPKG_USER-ATC=no -DPKG_USER-MESONT=no  \
-DPKG_USER-ADIOS=no -DPKG_USER-NETCDF=no -DPKG_USER-QUIP=no -DPKG_USER-SCAFACOS=no \
-DPKG_USER-VTK=no -DPKG_USER-H5MD=no \
-DFFT=FFTW3 \
-DPKG_USER-PLUMED=yes -DDOWNLOAD_PLUMED=yes\
-DCMAKE_C_COMPILER=mpicc -DCMAKE_CXX_COMPILER=mpic++ -DCMAKE_Fortran_COMPILER=mpifort \
-DCMAKE_INSTALL_PREFIX=/home1/p001cao/local/app/lammps/gccSHMEM-master


D. Compile Lammps19 with openMPI-conda & MKL-conda

I. Require:

openMPI & MKL must be installed in conda

Note: not yet support ucx


conda install -c conda-forge cmake mkl mkl-include libjpeg-turbo libpng 

conda install -c conda-forge openmpi openmpi-mpicc openmpi-mpicxx openmpi-mpifort 


# infiniBand

conda install -c conda-forge libibverbs-cos6-x86_64



II: Load modules 


module load conda/py37ompi

III: Configure





cmake  -C ../cmake/presets/all_on.cmake \
-D CMAKE_INSTALL_PREFIX=/home1/p001cao/local/lammps/20Nov19conda  \
-D BUILD_MPI=yes -D LAMMPS_MACHINE=mpi \
-D BUILD_LIB=yes -D BUILD_SHARED_LIBS=yes -D LAMMPS_EXCEPTIONS=yes \
-D PKG_GPU=no -D PKG_KIM=no -D PKG_LATTE=no -D PKG_MSCG=no -D PKG_KOKKOS=no \
-D DOWNLOAD_VORO=yes -D DOWNLOAD_EIGEN3=yes \
-D BUILD_OMP=yes -D PKG_USER-OMP=yes -D PKG_USER-INTEL=no \
-D PKG_USER-ADIOS=no -D PKG_USER-NETCDF=no -D PKG_USER-QUIP=no -D PKG_USER-SCAFACOS=no \
-D PKG_USER-QMMM=no -D PKG_USER-VTK=no -D PKG_USER-H5MD=no \
-D PKG_USER-PLUMED=no -D DOWNLOAD_PLUMED=no -D PLUMED_MODE=shared \
-D FFT=MKL \
-D MKL_LIBRARY=/home1/p001cao/local/miniconda3/envs/py37ompi/lib \
-D CMAKE_C_COMPILER=mpicc -D CMAKE_CXX_COMPILER=mpic++ -D CMAKE_Fortran_COMPILER=mpifort \../cmake 






E. Compile Lammps19 with openMPI4.0.1-gcc7.4.0 on CAN

Load modules: 

module load mpi/openmpi4.0.2-gcc7.4.0

module load cmake-3.12


-D PKG_USER-ATC=no -D PKG_VORONOI=no -D PKG_USER-SMD=no -D PKG_USER-PLUMED=no

use KISS for FTT

Configure:

cmake  -C ../cmake/presets/all_on.cmake \
-D CMAKE_INSTALL_PREFIX=/home/thang/local/app/lammps/20Nov19 \
-D BUILD_MPI=yes -D LAMMPS_MACHINE=mpi \
-D BUILD_LIB=yes -D BUILD_SHARED_LIBS=yes -D LAMMPS_EXCEPTIONS=yes \
-D PKG_GPU=no -D PKG_KIM=no -D PKG_LATTE=no -D PKG_MSCG=no -D PKG_KOKKOS=no \
-D PKG_USER-ATC=no -D PKG_VORONOI=no -D PKG_USER-SMD=no \
-D BUILD_OMP=yes -D PKG_USER-OMP=yes -D PKG_USER-INTEL=no \
-D PKG_USER-ADIOS=no -D PKG_USER-NETCDF=no -D PKG_USER-QUIP=no -D PKG_USER-SCAFACOS=no \
-D PKG_USER-QMMM=no -D PKG_USER-VTK=no -D PKG_USER-H5MD=no \
-D PKG_USER-PLUMED=no -D DOWNLOAD_PLUMED=no -D PLUMED_MODE=shared \
-D CMAKE_C_COMPILER=mpicc  -D CMAKE_CXX_COMPILER=mpic++ -D CMAKE_Fortran_COMPILER=mpifort \
../cmake










B. Lammps on USC2

4. OMPI-clang


OpenMP Compiler compatibility info: Some compilers do not fully support the default(none) directive 
and others (e.g. GCC version 9 and beyond) may implement OpenMP 4.0 semantics 


# run this 

cd /src/USER-OMP 
./hack_openmp_for_pgi_gcc9.sh



#NOTE: 

* The above incompatibility is solved with lammps/15Apr2020: https://github.com/lammps/lammps/pull/1651 
* Clang support openMP 4.5
* Ninja-cmake available from lammps/19Mar20
* from lammps/15Apr2020, lammps develop OpenMP with Clang 

##
git clone --branch patch_15Apr2020 https://github.com/lammps/lammps.git lammps_patch_15Apr2020 
cd lammps_patch_15Apr2020 
git checkout master
git pull origin master
mkdir build 
cd build


Load

module load mpi/ompi4.0.3-clang10 
module load plumed2/2.7htt-clang 
module load cmake-3.15.1



Configure


cmake ../cmake -C ../cmake/presets/all_on.cmake \
-DBUILD_MPI=yes -DLAMMPS_MACHINE=mpi \
-DBUILD_OMP=yes -DPKG_USER-OMP=yes -DPKG_USER-INTEL=no \
-DBUILD_LIB=yes -DBUILD_SHARED_LIBS=yes -DLAMMPS_EXCEPTIONS=yes \
-DPKG_GPU=no -DPKG_LATTE=no -DPKG_KOKKOS=no -DPKG_KIM=no -DPKG_MSCG=no \
-DDOWNLOAD_VORO=yes -DDOWNLOAD_EIGEN3=yes \
-DPKG_USER-ADIOS=no -DPKG_USER-NETCDF=no -DPKG_USER-QUIP=no -DPKG_USER-SCAFACOS=no \
-DPKG_USER-QMMM=no -DPKG_USER-VTK=no -DPKG_USER-H5MD=no \
-DPKG_USER-PLUMED=yes -DDOWNLOAD_PLUMED=no -DPLUMED_MODE=shared \
-DCMAKE_C_COMPILER=mpicc -DCMAKE_CXX_COMPILER=mpic++ -DCMAKE_Fortran_COMPILER=mpifort \
-DCMAKE_INSTALL_PREFIX=/home1/p001cao/local/app/lammps/15Apr20-clang





# USC1
-DCMAKE_INSTALL_PREFIX=/uhome/p001cao/local/app/lammps/19Mar20-clang



5. MVAPICH-GCC


module load mpi/mvapich2-2.3.2-gcc9.2.0
module load plumed2/2.7htt-mvapich
module load conda/py37mvapichSupp


Configure

cmake ../cmake -DCMAKE_EXE_LINKER_FLAGS="-fuse-ld=gold -lrt" \
-C ../cmake/presets/all_on.cmake \
-DBUILD_MPI=yes -DLAMMPS_MACHINE=mpi \
-DBUILD_OMP=yes -DPKG_USER-OMP=yes -DPKG_USER-INTEL=no \
-DBUILD_LIB=yes -DBUILD_SHARED_LIBS=yes -DLAMMPS_EXCEPTIONS=yes \
-DPKG_GPU=no -DPKG_LATTE=no -DPKG_KOKKOS=no -DPKG_KIM=no -DPKG_MSCG=no \
-DDOWNLOAD_VORO=yes -DDOWNLOAD_EIGEN3=yes \
-DPKG_USER-ADIOS=no -DPKG_USER-NETCDF=no -DPKG_USER-QUIP=no -DPKG_USER-SCAFACOS=no \
-DPKG_USER-QMMM=no -DPKG_USER-VTK=no -DPKG_USER-H5MD=no \
-DPKG_USER-PLUMED=yes -DDOWNLOAD_PLUMED=no -DPLUMED_MODE=shared \
-DCMAKE_C_COMPILER=mpicc -DCMAKE_CXX_COMPILER=mpic++ -DCMAKE_Fortran_COMPILER=mpifort \
-DCMAKE_INSTALL_PREFIX=/home1/p001cao/local/app/lammps/19Mar20-mva

https://github.com/lammps/lammps/blob/master/lib/message/cslib/src/STUBS_ZMQ/zmq.h



A. Compile Lammps19 with openMPI-4.0.2, Intel2019xe and MKL (w/wt FFTW-3.3.8) (USC)
II: Load modules
module load mpi/ompi4.0.2-Intel2019xe-noIB
module load intel/mkl-2019xe
module load gcc/gcc-7.4.0
module load plumed2/2.6htt
module load cmake-3.15.1
III: Compiling LAMMPS
* if occur error not found compiler, use this command to find path

find / -name icpc
find / -name ifort

find / -name icc

iii. Compile lammps
cd  lammps-folder
mkdir  build
cd  build

Step1: configuration

Note: write CMAKE command below on single line

cmake  -C ../cmake/presets/all_on.cmake \
-D CMAKE_INSTALL_PREFIX=/uhome/p001cao/local/lammps/20Nov19 \
-D BUILD_MPI=yes -D LAMMPS_MACHINE=mpi \
-D BUILD_LIB=yes -D BUILD_SHARED_LIBS=yes -D LAMMPS_EXCEPTIONS=yes \
-D PKG_GPU=no -D PKG_KIM=no -D PKG_LATTE=no -D PKG_MSCG=no -D PKG_KOKKOS=no \
-D DOWNLOAD_VORO=yes -D DOWNLOAD_EIGEN3=yes \
-D BUILD_OMP=yes -D PKG_USER-OMP=yes -D PKG_USER-INTEL=no \
-D PKG_USER-ADIOS=no -D PKG_USER-NETCDF=no -D PKG_USER-QUIP=no -D PKG_USER-SCAFACOS=no \
-D PKG_USER-QMMM=no -D PKG_USER-VTK=no -D PKG_USER-H5MD=no \
-D PKG_USER-PLUMED=yes -D DOWNLOAD_PLUMED=no -D PLUMED_MODE=shared \
-D FFT=MKL \
-D MKL_LIBRARY=/uhome/p001cao/local/intel/xe2019/compilers_and_libraries_2019.5.281/linux/mkl/lib/intel64 \
-D CMAKE_C_COMPILER=mpicc  -D CMAKE_CXX_COMPILER=mpic++ -D CMAKE_Fortran_COMPILER=mpifort \
../cmake

Step 2: compile ( in /build)
make -j 8
test: mpirun -np 2 lmp_mpi
LAMMPS (19 Jul 2019) 
Total wall time: 0:00:21

step 3: copy file 
make install

Step 4: create module file
 create file "7Aug19"
#######################################
# for Tcl script use only
set     topdir          /uhome/p001cao/local/lammps/7Aug19
set     version         7Aug19

module load  mpi/openMPI/4.0.2-Intel2018xe
module load  fftw/3.3.8/openmpi4.0.2-intel2018xe-double
module load  conda2-2019
module load  plumed2/2.6.0


setenv          LAMMPS                  $topdir

prepend-path    PATH                                    $topdir/bin
prepend-path    LD_LIBRARY_PATH         $topdir/lib64
prepend-path    INCLUDE                            $topdir/include/lammps
#######################################

save it in: /uhome/p001cao/local/share/lmodfiles/lammps
Ref:
https://lammps.sandia.gov/doc/Build_basics.html

#USC2:
Note: Kokkos may require TBB lib --> might only Intel can work
# Download specific TAG: git clone --branch <tag_name> <repo_url>
git clone --branch stable_3Mar2020 https://github.com/lammps/lammps.git lammps_stable_3Mar2020
cd lammps_stable_3Mar2020
mkdir build
cd build
##--- module load mpi/ompi4.0.3-intel19u5 module load intel/mkl-xe19u5 module load plumed2/2.7htt module load tool_dev/cmake-3.17.2

Configure
cmake ../cmake -C ../cmake/presets/all_on.cmake \ -DBUILD_MPI=yes -DLAMMPS_MACHINE=mpi \ -DBUILD_OMP=yes -DKokkos_ARCH_WSM=yes -DKokkos_ENABLE_OPENMP=yes \ -DBUILD_SHARED_LIBS=yes -DLAMMPS_EXCEPTIONS=yes \ -DPKG_GPU=no -DPKG_LATTE=no -DPKG_KIM=no -DPKG_MSCG=no -DPKG_USER-INTEL=no\ -DDOWNLOAD_VORO=yes -DDOWNLOAD_EIGEN3=yes \ -DPKG_USER-ADIOS=no -DPKG_USER-NETCDF=no -DPKG_USER-QUIP=no -DPKG_USER-SCAFACOS=no \ -DPKG_USER-QMMM=no -DPKG_USER-VTK=no -DPKG_USER-H5MD=no \ -DPKG_USER-PLUMED=yes -DDOWNLOAD_PLUMED=no -DPLUMED_MODE=shared \ -DCMAKE_C_COMPILER=mpicc -DCMAKE_CXX_COMPILER=mpic++ \ -DCMAKE_INSTALL_PREFIX=/home1/p001cao/local/app/lammps/05May20
B. with IMPI-2019xe + MKL:
Note: use intelMPI can run all both centos7 & centos6
# 1. USC 1:
Load modulesmodule load intel/compiler-xe19u5
module load mpi/impi-xe19u5
module load intel/mkl-xe19u5
module load plumed2/2.6httIMPI
module load conda/py37
module load cmake-3.15.1 

configuration
cd lammps-folder
mkdir build
cd build
cmake  -C ../cmake/presets/all_on.cmake \
-D CMAKE_INSTALL_PREFIX=/uhome/p001cao/local/app/lammps/20Nov19impi \
-D BUILD_MPI=yes -D LAMMPS_MACHINE=mpi \
-D BUILD_LIB=yes -D BUILD_SHARED_LIBS=yes -D LAMMPS_EXCEPTIONS=yes \
-D PKG_GPU=no -D PKG_KIM=no -D PKG_LATTE=no -D PKG_MSCG=no -D PKG_KOKKOS=no \
-D DOWNLOAD_VORO=yes -D DOWNLOAD_EIGEN3=yes \
-D BUILD_OMP=yes -D PKG_USER-OMP=yes -D PKG_USER-INTEL=no \
-D PKG_USER-ADIOS=no -D PKG_USER-NETCDF=no -D PKG_USER-QUIP=no -D PKG_USER-SCAFACOS=no \
-D PKG_USER-QMMM=no -D PKG_USER-VTK=no -D PKG_USER-H5MD=no \
-D PKG_USER-PLUMED=yes -D DOWNLOAD_PLUMED=no -D PLUMED_MODE=shared \
-D FFT=MKL \
-D MKL_LIBRARY=/uhome/p001cao/local/app/intel/xe19u5/compilers_and_libraries_2019.5.281/linux/mkl/lib/intel64_lin \
-D CMAKE_C_COMPILER=mpiicc -D CMAKE_CXX_COMPILER=mpiicpc -D CMAKE_Fortran_COMPILER=mpiifort \
../cmake
make -j 8
test:  mpirun -np 2 ./lmp_mpi
make install
Step 4: create module file
 create file "7Aug19-Impi"
############################################
module load intel/2019xe
module load mpi/impi-2019xe
module load plumed2/2.6.0-Impi
module load conda2-2019
setenv          LAMMPS                  $topdir

prepend-path    PATH                                    $topdir/bin
prepend-path    LD_LIBRARY_PATH         $topdir/lib64
prepend-path    INCLUDE                            $topdir/include/lammps
###############################################################


# 2. USC 2:
module load compiler/gcc-10.2              # must load before impi
module load intel/compiler-xe19u5           # intel include lld linker  require GLIBC 2.15
module load intel/mkl-xe19u5  
module load intel/impi-xe19u5           
source mpivars.sh release
module load tool_dev/cmake-3.18.0
module load tool_dev/gsl-2.6
module load tool_dev/binutils-2.32                # gold 
export PATH=$PATH:/home1/p001cao/local/app/intel/xe19u5/compilers_and_libraries_2019.5.281/linux/bin
export CC=mpiicc
export CXX=mpiicpc
export FORTRAN=mpiifort

Configure
cmake ../cmake -C ../cmake/presets/all_on.cmake \
-DCMAKE_EXE_LINKER_FLAGS="-fuse-ld=gold -lrt" \
-DLAMMPS_EXCEPTIONS=yes -DBUILD_MPI=yes -DBUILD_OMP=yes -DLAMMPS_MACHINE=mpi \
-DPKG_USER-OMP=yes -DPKG_USER-INTEL=yes -DPKG_GPU=no -DPKG_KOKKOS=no \
-DPKG_USER-SMD=yes -DDOWNLOAD_EIGEN3=yes -DDOWNLOAD_VORO=yes \
-DPKG_KIM=no -DDOWNLOAD_KIM=no -DPKG_LATTE=no -DPKG_MSCG=no -DPKG_USER-ATC=no \
-DPKG_USER-ADIOS=no -DPKG_USER-NETCDF=no -DPKG_USER-QUIP=no -DPKG_USER-SCAFACOS=no \
-DPKG_USER-VTK=no -DPKG_USER-H5MD=no \
-DFFT=MKL \
-DPKG_USER-PLUMED=yes -DDOWNLOAD_PLUMED=yes\
-DCMAKE_C_COMPILER=mpiicc -DCMAKE_CXX_COMPILER=mpiicpc -DCMAKE_Fortran_COMPILER=mpiifort \
-DCMAKE_INSTALL_PREFIX=/home1/p001cao/local/app/lammps/impi-master
#-- NOTE: Kokkos require TBB lib
module load intel/tbb-xe20u2
##-- edit /cmake/Modules/FindTBB_MALLOC.cmake
find_path(TBB_MALLOC_INCLUDE_DIR NAMES tbb.h PATHS $ENV{TBBROOT}/include/tbb)
find_library(TBB_MALLOC_LIBRARY NAMES tbbmalloc PATHS $ENV{TBBROOT}/lib/intel64/gcc4.8)     
##--
-DCMAKE_EXE_LINKER_FLAGS="-fuse-ld=lld -lrt" \
source compilervars.sh intel64
source mklvars.sh intel64





[Markdown basic syntax](https://www.markdownguide.org/basic-syntax) <br>
[Kramdown basic syntax](https://kramdown.gettalong.org/converter/html.html#math-support) <br>

