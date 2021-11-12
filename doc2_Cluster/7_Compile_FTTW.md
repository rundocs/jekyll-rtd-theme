---
sort: 7
---

# Compiling FFTW

- NOTE: To compile with mpi-enable, need to use openMPI-compiler: MPICC=mpicc
- [Installation guide](http://www.fftw.org/fftw3_doc/Installation-on-Unix.html#Installation-on-Unix)

## Download FFTW
[Download FFTW-3.3.10](http://www.fftw.org/download.html)

```shell
tar -xvzf fftw-3.3.10.tar.gz
cd fftw-3.3.10
mkdir build && cd build
```

## OMPI + GCC
Compiling FFTW 3.3.10 (Single,Double) 
```
--enable-sse2: Single, Double
--enable-long-double : Long-Double Precision 
--enable-float : Single
```

### USC1
```shell
module load mpi/ompi5.0.0-gcc11.2
export PATH=/uhome/p001cao/local/app/openmpi/5.0.0-gcc11.2-eagle/bin:$PATH
export CC=mpicc  export CXX=mpic++  export FORTRAN=mpifort  export F90=mpif90

../configure --enable-sse2 \
--enable-threads --enable-openmp --enable-mpi \
--prefix=/uhome/p001cao/local/app/fftw/3.3.10-ompi5.0-gcc11.2
```

### USC2
```shell
module load mpi/ompi4.1.1-gcc10.3
export PATH=$PATH:/home1/p001cao/local/app/openmpi/4.1.1-gcc10.3/bin 
export CC=mpicc  export CXX=mpic++  export FORTRAN=mpifort  export F90=mpif90

../configure --enable-sse2 \
--enable-threads --enable-openmp --enable-mpi \
--prefix=/home1/p001cao/local/app/fftw/3.3.8-ompi4.1-gcc10.3
```

### CAN-GPU
```shell
module load mpi/ompi4.1-gcc7.4-cuda
export PATH=$PATH:/home/thang/local/app/openmpi/4.1.1-gcc7.4-cuda/bin 
export CC=mpicc  export CXX=mpic++  export FORTRAN=mpifort  export F90=mpif90

../configure --enable-sse2 \
--enable-threads --enable-openmp --enable-mpi \
--prefix=/home/thang/local/app/fftw/3.3.8-ompi4.1-gcc7.4
```

make -j 12
make install


validate: 
Inside "/uhome/p001cao/local/app/fftw/3.3.8-ompi4.1-gcc10.3/lib" you should see at least the files below
libfftw3.a libfftw3_mpi.a libfftw3_omp.a libfftw3_threads.a .... ....
