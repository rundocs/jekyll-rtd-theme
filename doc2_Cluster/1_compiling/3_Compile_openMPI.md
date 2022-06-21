---
sort: 3
---

# Compiling OpenMPI-4

| | |
| -- | -- |
![pic](https://www.open-mpi.org/images/open-mpi-logo.png) | [Open MPI](https://www.open-mpi.org/) is a Message Passing Interface (MPI) library project combining technologies and resources from several other projects (FT-MPI, LA-MPI, LAM/MPI, and PACX-MPI).

```note
  - Some applications require C++11, this is only supported on GCC 4.8 or newer, which is not always available on system, then newer GCC need to be installed before compiling Openmpi.
  - Make sure to build OpenMPI with 64-bit support. To check whether the currently available OpenMPI do support 64-bit or not, type this:
  `ompi_info -a | grep 'Fort integer size'. If the output is 8, then it supports 64-bit. If output is 4, then it just supports 32-bit.* configuration for 64-bit support:
    - For Intel compilers use: `FFLAGS=-i8 FCFLAGS=-i8 CFLAGS=-m64 CXXFLAGS=-m64`
    - For GNU compilers type: `FFLAGS="-m64 -fdefault-integer-8" FCFLAGS="-m64 -fdefault-integer-8" CFLAGS=-m64 CXXFLAGS=-m64'
  - must keep the source after compiling
  - consider to use [UCX](https://openucx.org/introduction/)
  - OpenMPI-4 use UCX by default (openMPI 4.0,3 --> ucx-1.7 or older).
  - consider using linker
    - lld linker:

    ```shell
    module load llvm/llvm-gcc10-lld                   # to use lld
    LDFLAGS="-fuse-ld=lld -lrt"
    ```
    - gold linker:

    ```shell
    module load tool_dev/binutils-2.32
    LDFLAGS="-fuse-ld=gold -lrt"
    ```
```


## 1. Download:

[See what new in openMPI-4](https://raw.githubusercontent.com/open-mpi/ompi/v4.1.x/NEWS)

[download OpenMPI-4](https://www.open-mpi.org/software/ompi/v4.1/)
```shell
tar xvf openmpi-4.1.3rc1.tar.gz
cd openmpi-4.1.3rc1
```

## 2. Compiling OpenMPI + GCC
Need separated installations for: eagle, lion/leopard, cheetah, taycheon <br>
Installation OPTIONS in README.txt or `./configure -h`
- Sun Grid: `--with-sge`
- InfiniBand: `--with-verbs`
- with KNEM: `--with-knem=path`
- use UCX: `--with-ucx=path`
```shell
export myUCX=/uhome/p001cao/local/app/tool_dev/ucx-1.9
../configure...  --with-ucx=${myUCX}
```

### USC1: (Cenntos 6.5)
```note
- should use gold-linker to avoid compiling error
- UCX cause error: ib_md.c:329  UCX  ERROR ibv_reg_mr(address=0x145cb580, length=263504, access=0xf) failed: Resource temporarily unavailable. So dont use UCX on this server.
```
```shell
module load tool_dev/binutils-2.36                       # gold, should use to avoid link-error
module load compiler/gcc-11.2
export myKNEM=/uhome/p001cao/local/app/tool_dev/knem-1.1.4
```

#### InfiniBand cluster
```shell
cd openmpi-4.1.1
mkdir build_eagle && cd build_eagle

../configure CC=gcc CXX=g++ FC=gfortran F77=gfortran LDFLAGS="-fuse-ld=gold -lrt" \
--with-sge --without-ucx --with-verbs --with-knem=${myKNEM} \
--prefix=/uhome/p001cao/local/app/openmpi/4.1.1-gcc11.2-noUCX-eagle
```

#### no InfiniBand cluster
```shell
cd openmpi-4.1.1
mkdir build_lion && cd build_lion
../configure CC=gcc CXX=g++ FC=gfortran F77=gfortran LDFLAGS="-fuse-ld=gold -lrt" \
--with-sge --without-ucx --without-verbs --with-knem=${myKNEM} \
--prefix=/uhome/p001cao/local/app/openmpi/4.1.1-gcc11.2-noUCX-lion
```

```make
make  -j 20         # not use -j to know what error
make install
```

### USC2: (Cenntos 6.9)
- On Tacheon, UCX may give better performance.
- Do not use GCC-11, to avoid error. this does not work `export CFLAGS='-gdwarf-4 -gstrict-dwarf'`

```shell
cd openmpi-4.1.3
mkdir buildGCC && cd buildGCC
##
module load tool_dev/binutils-2.37                        # gold
module load compiler/gcc-10.3

export PATH=$PATH:/home1/p001cao/local/app/compiler/gcc-10.3/bin
export CC=gcc export CXX=g++ export FORTRAN=gfortran
export LDFLAGS="-fuse-ld=gold -lrt"
export CFLAGS='-gdwarf-4 -gstrict-dwarf'
export myUCX=/home1/p001cao/local/app/tool_dev/ucx-1.12              ## ucx-1.12  ucx-master

../configure --with-sge --with-ucx=${myUCX} --without-verbs \
--prefix=/home1/p001cao/local/app/openmpi/4.1.3-gcc10.3

make  -j 16 && make install
```


**without UCX**
```shell
module load tool_dev/binutils-2.35                        # gold
module load compiler/gcc-10.3
export LDFLAGS="-fuse-ld=gold -lrt"

../configure --with-sge --with-verbs --without-ucx  \
--prefix=/home1/p001cao/local/app/openmpi/4.1.1-gcc10.3-noUCX
```

### CANlab: (Cenntos 5.8)
```shell
module load gcc/gcc-7.4.0

../configure CC=gcc CXX=g++ FC=gfortran F77=gfortran \
--with-sge --without-verbs --without-ucx  \
--prefix=/home/thang/local/app/openmpi/4.0.2-gcc7.4.0
```

### CAN-GPU: (Ubuntu-18)
```note
- install Cuda ussing GCC
- cuda-10 only support to gcc-8
- need binutils 2.22 or newer to link cuda
```
#### Install conda
- [CLI install Cuda](https://docs.nvidia.com/cuda/cuda-installation-guide-linux/index.html#redhat-installation)
- Download:  `wget http://developer.download.nvidia.com/compute/cuda/10.2/Prod/local_installers/cuda_10.2.89_440.33.01_rhel6.run`
- Install (using Root acc)
  1. disable the graphical target, to update Nvidia driver
  ```shell
  systemctl isolate multi-user.target
  modprobe -r nvidia-drm
  ```
  ```shell
  module load compiler/gcc-7.4
  sh cuda_10.2.89_440.33.01_rhel6.run --toolkitpath=/home/thang/local/app/cuda-10.2
  ```
  2. after install Cuda, start the graphical environment again
  ```shell
  systemctl start graphical.target
  ```

#### compile OpenMPI
```shell
cd openmpi-4.1.1
mkdir build && cd build

module load compiler/gcc-7.4   # cuda-10 only support to gcc-8
module load binutils-2.35

../configure CC=gcc CXX=g++ FC=gfortran F77=gfortran \
--with-sge --without-ucx \
--with-cuda=/home/thang/local/app/cuda-10.2 \
--prefix=/home/thang/local/app/openmpi/4.1.1-gcc7.4-cuda
```


## 3. Compiling OpenMPI + Intel
### USC1: (Cenntos 6.5)
#### InfiniBand cluster
```shell
cd openmpi-4.1.1
mkdir build_eagle && cd build_eagle
```
```shell
module load intel/compiler-xe19u5
module load compiler/gcc/9.1.0
# check: icpc -v
export PATH=/home1/p001cao/local/app/intel/xe19u5/compilers_and_libraries_2019.5.281/linux/bin/intel64:$PATH
export CC=icc  export CXX=icpc  export FORTRAN=ifort

../configure CC=icc CXX=icpc FC=ifort F77=ifort \
--with-sge --without-ucx --with-verbs --with-knem=${myKNEM} \
--prefix=/uhome/p001cao/local/app/openmpi/4.1.1-intelxe19u5-noUCX-eagle
```

### USC2: (Cenntos 6.9)
```shell
# use linker lld (include in Intel-bin, require GLIBC >2.15)
module load compiler/gcc-10.1.0
module load intel/compiler-xe19u5       # lld
##
export PATH=/home1/p001cao/local/app/intel/xe19u5/compilers_and_libraries_2019.5.281/linux/bin/intel64:$PATH
export CC=icc  export CXX=icpc  export FORTRAN=ifort
export myUCX=/home1/p001cao/local/app/tool_dev/ucx-1.8-intel

../configure CC=icc CXX=icpc FC=ifort F77=ifort LDFLAGS="-fuse-ld=lld -lrt" \
--with-sge --without-verbs --with-ucx=${myUCX} \
--prefix=/home1/p001cao/local/app/openmpi/4.0.4-intelxe19u5
```


## 4. Make module file
at directory: /uhome/p001cao/local/share/lmodfiles/mpi--> create file "ompi4.1.1-gcc11.2-noUCX"

```shell
# for Tcl script use only
module load compiler/gcc-11.2
module load tool_dev/binutils-2.37

set     topdir          /uhome/p001cao/local/app/openmpi/4.1.1-gcc11.2-noUCX-eagle

prepend-path   PATH                $topdir/bin
prepend-path   LD_LIBRARY_PATH     $topdir/lib
prepend-path   INCLUDE             $topdir/include

prepend-path   PKG_CONFIG_PATH 	   $topdir/lib/pkgconfig          # this is required
```

**Check:**
```shell
module load ompi4.1.1-gcc11.2-noUCX
mpic++ -v
```


## OpenMPI-5
- There is no `--with-verb` anymore. And openib BTL is remove in this version, so InfiniBand must use "ucx PML". [See more](https://www.open-mpi.org/faq/?category=openfabrics
- May use UCX with OMPI-5 and do not need seperate installation for Eagle, Lion?
- May not be used with UCX-1.11
- See news in 5.x [here](https://github.com/open-mpi/ompi/tree/v5.0.x)


### USC1: (Cenntos 6.5)
```shell
module load tool_dev/binutils-2.36                       # gold, should use to avoid link-error
module load compiler/gcc-11.2
export myUCX=/uhome/p001cao/local/app/tool_dev/ucx-1.11
```

```shell
cd openmpi-5.0.0
mkdir build_eagle && cd build_eagle

../configure CC=gcc CXX=g++ FC=gfortran F77=gfortran LDFLAGS="-fuse-ld=gold -lrt" \
--with-sge --with-ucx=${myUCX}  \
--prefix=/uhome/p001cao/local/app/openmpi/5.0.0-gcc11.2-eagle
```

### USC2 (Cenntos 6.9)

- On Tacheon, UCX may give better performance.

```shell
module load tool_dev/autoconf-2.69b
module load tool_dev/libtool-2.4.6
module load tool_dev/automake-1.14
git clone --branch v5.0.x --recursive  https://github.com/open-mpi/ompi.git openmpi_5
cd openmpi_5
./autogen.pl
```

```shell
cd openmpi-5.0.0rc3
mkdir buildGCC && cd buildGCC
##
module load tool_dev/binutils-2.37                        # gold
module load compiler/gcc-10.3
export myUCX=/home1/p001cao/local/app/tool_dev/ucx-1.12               ## UCX

../configure CC=gcc CXX=g++ FC=gfortran F77=gfortran LDFLAGS="-fuse-ld=gold -lrt" \
--with-sge --with-ucx=${myUCX}  \
--prefix=/home1/p001cao/local/app/openmpi/5.0.0-gcc10.3

make -j 16 && make install
```

## 2. Compiling OpenMPI + Clang

### USC2(Cenntos 6.9)

```shell
tar xvf openmpi-4.1.4.tar.gz
cd openmpi-4.1.4
mkdir build_clang && cd build_clang

module load compiler/llvm-14          # clang + lld

export myCOMPILER=/home1/p001cao/local/app/compiler/llvm-14
export PATH=${myCOMPILER}/bin:$PATH
export CC=clang export CXX=clang++ export FC=gfortran
export LDFLAGS="-fuse-ld=lld -lrt" 
export myUCX=/home1/p001cao/local/app/tool_dev/ucx-1.13-llvm

../configure --with-sge --with-ucx=${myUCX} --without-verbs \
--prefix=/home1/p001cao/local/app/openmpi/4.1.4-clang14

make  -j 16 && make install
```
