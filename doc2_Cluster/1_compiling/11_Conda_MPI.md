---
sort: 11
---

# Openmpi in Conda

```note
- Use conda to manage all necessary libs in Linux.
- However, this way cannot use openmpi with clang. So install clang in conda and use clang to compile openmpi
- Python > 3.7.12 require to update GCC-conda=11
`conda install -c conda-forge libstdcxx-ng=11 libgcc-ng=11 libgfortran-ng=11`. But dont use this to void requiring higher GLIBC. Also, `zlib=1.2.12` require GLIBC=2.14. So that to void these errors, use `conda install -c conda-forge libstdcxx-ng=10 libgcc-ng=10 libgfortran-ng=10 zlib=1.2.11 python=3.7.12`
```

## USC2 Tachyon (centos 6.9)

### Install conda

```tip
Consider Miniconda for light, and reduce error
```

Download [Anaconda installer for Linux](https://repo.anaconda.com/miniconda/)

```shell
cd /uhome/p001cao/local/W_Source_Code
wget https://repo.continuum.io/miniconda/Miniconda3-latest-Linux-x86_64.sh

module load compiler/gcc-11.2
export PATH=/uhome/p001cao/local/app/compiler/gcc-11.2/bin:$PATH
export CC=gcc  export CXX=g++  export FC=gfortran

bash Miniconda3-py37_4.9.2-Linux-x86_64.sh -u

choose folder to install:   /home1/p001cao/local/app/miniconda3
running conda init?  NO
... finish
```

#### Module file

- Conda module: create file into folder  /uhome/p001cao/local/share/lmodfiles/conda/conda3

```shell
set     topdir          /uhome/p001cao/local/miniconda3
prepend-path    PATH                    $topdir/bin
prepend-path    LD_LIBRARY_PATH         $topdir/lib
prepend-path    INCLUDE                 $topdir/include
```

- module file for Python Environments
https://manjusri.ucsc.edu/2017/09/08/environment-modules/
create 2 evironments: python37, python27

```shell
module load conda/conda3
conda create -n py37llvm python=3.7.5
```

create module files for environments, create file into folder  /uhome/p001cao/local/share/lmodfiles/conda/py37llvm

```shell
set     topdir          /uhome/p001cao/local/Miniconda3/envs/py37ompi
prepend-path    PATH                    $topdir/bin
prepend-path    LD_LIBRARY_PATH         $topdir/lib
prepend-path    INCLUDE                 $topdir/include
```

## Install libraries

Don't install ompi

```shell
module load conda/conda3
source activate py37llvm

conda install -c asmeurer glibc       # may error
conda install -c conda-forge cmake libstdcxx-ng=10 libgcc-ng=10 libgfortran-ng=10 zlib=1.2.11 python=3.7.12
```

1.LLVM

```shell
conda install -c conda-forge llvm clang flang libclang lld llvm-openmp llvm-tools
```

2.ucx

```shell
conda install -c conda-forge ucx
```

## OpenMPI



## Lammps

```shell
git pull origin develop
mkdir build_LLVM && cd build_LLVM

module load tool_dev/binutils-2.37
module load tool_dev/cmake-3.20.3
module load fftw/fftw3.3.10-ompi4.1.4-clang14
module load mpi/ompi4.1.4-clang14

export myCOMPILER=/home1/p001cao/local/app/compiler/llvm-14
export PATH=$PATH:${myCOMPILER}/bin
export CC=mpicc  export CXX=mpic++  export FC=mpifort
export LDFLAGS="-fuse-ld=lld -lrt"
## python (require py3) & BLAS+LAPACK
export pyROOT=/home1/p001cao/local/app/miniconda3/envs/py37Lammps

cmake ../cmake -C ../cmake/presets/all_on.cmake \
-DPython_ROOT_DIR=${pyROOT} \
-DBUILD_MPI=yes -DBUILD_OMP=yes -DPKG_OPENMP=yes -DLAMMPS_MACHINE=mpi -DBUILD_SHARED_LIBS=no \
-DPKG_GPU=no -DPKG_KOKKOS=no -DPKG_INTEL=no -DPKG_MDI=no \
-DPKG_SCAFACOS=no -DPKG_ADIOS=no -DPKG_NETCDF=no -DPKG_VTK=no -DPKG_H5MD=no \
-DPKG_MESONT=no -DPKG_LATTE=no -DPKG_MSCG=no -DPKG_ATC=no -DPKG_KIM=no \
-DPKG_PLUMED=yes -DPKG_ML-PACE=yes -DPKG_ML-QUIP=no -DPKG_ML-HDNNP=no  \
-DFFT=FFTW3 \
-DCMAKE_INSTALL_PREFIX=/home1/p001cao/local/app/lammps/llvmOMPI4-dev

make -j 16 && make install
```


## Ref
Update GLIBC: https://gist.github.com/michaelchughes/85287f1c6f6440c060c3d86b4e7d764b