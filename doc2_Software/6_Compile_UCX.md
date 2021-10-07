---
sort: 6
---

# Compiling UCX

https://github.com/openucx/ucx/wiki/OpenMPI-and-OpenSHMEM-installation-with-UCX
##################################
UCX need to compile OpenMPI to use InfiniBand

To use UCX you need to
Get the recent release from https://github.com/openucx/ucx/releases
Build and make it avaliable to your machines
Configure OMPI --with-ucx="path-to-ucx" and rebuild/reinstall it
Afterwards when you launch you set UCX pml:
$ mpirun -mca btl self -mca pml ucx ....
To control which device and what transport are being used you can add following env variables:
$ mpirun -mca btl self -mca pml ucx -x UCX_NET_DEVICES=mlx5_0:1 -x UCX_TLS=rc,shm ....
Try to experiment with different TLS's see here for more info.
##################################

https://github.com/openucx/ucx/wiki
##NOTE:
* OpenMPI 4.0,3 support ucx 1.7 or older
* OpenMPI 4.0,4 support newer ucx

#### install from Source (work now, but should not be use to avoid runtime errors)
## Requirements: autoconf-2.69b, libtool-2.4.6, automake-1.14
# git clone --branch master https://github.com/openucx/ucx  ucx-master
cd ucx-master
module load tool_dev/autoconf-2.69b
module load tool_dev/automake-1.14
module load tool_dev/libtool-2.4.6 
export ACLOCAL_PATH=/home1/p001cao/local/app/tool_dev/libtool-2.4.6/share/aclocal
./autogen.sh
mkdir build   &&  cd build

### (install from Release --> no need ./autogen.h)
tar xvf ucx-1.11.2.tar.gz
cd ucx-1.11.2
mkdir build   &&  cd build
## USC2
module load tool_dev/binutils-2.35              # gold
module load compiler/gcc-10.3
##
export PATH=$PATH:/home1/p001cao/local/app/compiler/gcc-10.3/bin
export CC=gcc export CXX=g++ export FORTRAN=gfortran
myKNEM=/home1/p001cao/local/app/tool_dev/knem-1.1.4
myNUMA=/home1/p001cao/local/app/tool_dev/numactl-2.0.13
##--
../contrib/configure-release  --enable-mt --with-knem=$myKNEM \
LDFLAGS="-fuse-ld=gold -lrt  -L$myNUMA/lib -Wl,-rpath,$myNUMA/lib" \
CFLAGS="-I$myNUMA/include" \
--prefix=/home1/p001cao/local/app/tool_dev/ucx-1.10


## USC1 (eagle)
```shell
module load tool_dev/binutils-2.36              # gold 
module load compiler/gcc-11.2

export PATH=$PATH:/uhome/p001cao/local/app/compiler/gcc-11.2/bin
export CC=gcc export CXX=g++ export FORTRAN=gfortran

../contrib/configure-release --enable-mt \
--prefix=/uhome/p001cao/local/app/tool_dev/ucx-1.11
```


Option:
```shell
myKNEM=/uhome/p001cao/local/app/tool_dev/knem-1.1.4
myNUMA=/uhome/p001cao/local/app/tool_dev/numactl-2.0.13

--with-knem=$myKNEM \
LDFLAGS="-fuse-ld=gold -lrt  -L$myNUMA/lib -Wl,-rpath,$myNUMA/lib" \
CFLAGS="-I$myNUMA/include" \
```

Other options:
```shell
--disable-numa
--with-rc --with-ud --with-dc --with-ib-hw-tm --with-dm --with-cm \
## consider options
--with-verbs(=DIR)      Build OpenFabrics support, adding DIR/include,
                        DIR/lib, and DIR/lib64 to the search path for
                        headers and libraries
--with-rc               Compile with IB Reliable Connection support
--with-ud               Compile with IB Unreliable Datagram support
--with-dc               Compile with IB Dynamic Connection support
--with-mlx5-dv          Compile with mlx5 Direct Verbs support. Direct Verbs
                        (DV) support provides additional acceleration
                        capabilities that are not available in a regular
                        mode.
--with-ib-hw-tm         Compile with IB Tag Matching support
--with-dm               Compile with Device Memory support

--with-cm               Compile with IB Connection Manager support

##-- Consider
myNUMA=/home1/p001cao/local/app/tool_dev/numactl-2.0.13
LDFLAGS="-fuse-ld=gold -lrt  -L$myNUMA/lib -Wl,-rpath,$myNUMA/lib" \
CFLAGS="-I$myNUMA/include" \
##--
export myKNEM=/home1/p001cao/local/app/tool_dev/knem1.1.3    
export myOFI=/home1/p001cao/local/app/tool_dev/libfabric-1.10.1 
--with-verbs=${myOFI} --with-knem=${myKNEM} \
https://developer.arm.com/tools-and-software/server-and-hpc/help/porting-and-tuning/building-open-mpi-with-openucx/running-openmpi-with-openucx
```

####2. Intel
module load intel/compiler-xe19u5
export PATH=/home1/p001cao/local/app/intel/xe19u5/compilers_and_libraries_2019.5.281/linux/bin/intel64:$PATH
export CC=icc  export CXX=icpc  export FORTRAN=ifort
export LD_LIBRARY_PATH=/home1/p001cao/local/app/intel/xe19u5/compilers_and_libraries_2019.5.281/linux/compiler/lib/intel64_lin:$LD_LIBRARY_PATH

export LD_LIBRARY_PATH=/home1/p001cao/local/app/tool_dev/glibc-2.18/lib:$LD_LIBRARY_PATH
export LD_LIBRARY_PATH=/usr/local/lib

export myKNEM=/home1/p001cao/local/app/tool_dev/knem1.1.3    
export myOFI=/home1/p001cao/local/app/tool_dev/libfabric-1.10.1
##--
../contrib/configure-release --disable-numa --enable-mt LDFLAGS="-fuse-ld=lld -lrt" \
--with-verbs=${myOFI} --with-knem=${myKNEM} \
--prefix=/home1/p001cao/local/app/tool_dev/ucx-1.8-intel


List of main transports and aliases
https://github.com/openucx/ucx/wiki/UCX-environment-parameters
all	use all the available transports.
sm	all shared memory transports.
shm	same as "sm".
ugni	ugni_rdma and ugni_udt.
rc	RC (=reliable connection), and UD (=unreliable datagram) for connection bootstrap.
"accelerated" transports are used if possible.
ud	UD transport, "accelerated" is used if possible.
dc	DC - Mellanox scalable offloaded dynamic connection transport
rc_x	Same as "rc", but using accelerated transports only
rc_v	Same as "rc", but using Verbs-based transports only
ud_x	Same as "ud", but using accelerated transports only
ud_v	Same as "ud", but using Verbs-based transports only
tcp	TCP over SOCK_STREAM sockets
rdmacm	Use RDMACM connection management for client-server API
sockcm	Use sockets-based connection management for client-server API
cuda_copy	Use cu\*Memcpy for hostcuda device self transfers but also to detect cuda memory
gdr_copy	Use GDRcopy library for hostcuda device self transfers
cuda_ipc	Use CUDA-IPC for cuda devicedevice transfers over PCIe/NVLINK
rocm_copy	Use for host-rocm device transfers
rocm_ipc	Use IPC for rocm device-device transfers
self	Loopback transport to communicate within the same process
II. UCX optional Libs
1. rdma-core (fail)
UCX detects the exiting libraries on the build machine and enables/disables support for various features accordingly. If some of the modules UCX was built with are not found during runtime, they will be silently disabled.
Basic shared memory and TCP support - always enabled
Optimized shared memory - requires knem or xpmem drivers. On modern kernels also CMA (cross-memory-attach) mechanism will be used.
RDMA support - requires rdma-core or libibverbs library.
NVIDIA GPU support - requires Cuda drives
AMD GPU support - requires ROCm drivers
git clone https://github.com/linux-rdma/rdma-core  rdma-core
cd rdma-core
tar xvf rdma-core-30.0.tar.gz
cd rdma-core-30.0
####
module load compiler/gcc-10.1.0
module load tool_dev/cmake-3.17.2 
module load tool_dev/libnl-3.0
module load tool_dev/libtool-2.4.6

export LD_LIBRARY_PATH=/home1/p001cao/local/app/tool_dev/libnl-3.0/lib:$LD_LIBRARY_PATH ./build.sh



2. libnuma-devel
https://github.com/numactl/numactl
tar xzf numactl-2.0.13.tar.gz
cd numactl-2.0.13
##--
module load tool_dev/autoconf-2.69b
./autogen.sh
#--
mkdir build && cd build 
../configure --prefix=/home1/p001cao/local/app/tool_dev/numactl-2.0.13


3. openMPI/UCX: libfabric ()
wget https://github.com/ofiwg/libfabric/releases/tag/v1.11.1/libfabric-1.11.1.tar.bz2 
If building directly from the libfabric git tree, run './autogen.sh' before the configure step.
#--
module load tool_dev/autoconf-2.69b
./autogen.sh
##
tar -xvf libfabric-1.11.1.tar.bz2
cd libfabric-1.11.1
module load compiler/gcc-10.2  

## IB cluster
./configure --prefix=/uhome/p001cao/local/app/tool_dev/libfabric-1.11.1-IB

## noIB cluster
./configure --prefix=/uhome/p001cao/local/app/tool_dev/libfabric-1.11.1-noIB

## module 
prepend-path PKG_CONFIG_PATH $topdir/lib/pkgconfig


4. openMPI/UCX: KNEM
https://knem.gitlabpages.inria.fr/
tar zxvf knem-1.1.4.tar.gz 
cd knem-1.1.4
./configure --prefix=/uhome/p001cao/local/app/tool_dev/knem-1.1.4

5. openMPI/UCX: XPMEM
https://github.com/hjelmn/xpmem/releases/tag/v2.6.3
https://github.com/hjelmn/xpmem/wiki/Installing-XPMEM
--> cannot install: require linux kernel 4.x
check: uname -a
##--
tar zxvf xpmem-2.6.3.tar.gz
cd xpmem-2.6.3
##--

./configure --prefix=/home1/p001cao/local/app/tool_dev/xpmem-2.6.2


