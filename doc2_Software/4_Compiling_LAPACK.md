---
sort: 
---

# Compiling LAPACK & ScaLAPACK



## BLAS
```shell
git clone --branch <tag_name> <repo_url>
```

## LAPACK & BLAS
- LAPACK is a library of Fortran subroutines for solving the most commonly occurring problems in numerical linear algebra.
- BLAS is need to install LAPACK
- BLAS & LAPACK can be install separately (see here)
    - BLAS, see [http://www.netlib.org/blas/]
    - LAPACK, see [http://www.netlib.org/lapack/]
[soureCode LAPACK](https://github.com/Reference-LAPACK/lapack) also includes BLAS

```shell
git checkout <tag_name>
git pull origin <tag_name>
```

Instance:
```shell
cd lapack
mkdir build && cd build

cmake -DCMAKE_INSTALL_LIBDIR=/home/user/lapack ..

cmake --build . -j --target install
```

### Some possible error of Git
- git error (if any): Couldn't resolve host 'github.com' while ....
```shell
git config --global --unset http.proxy    
git config --global --unset https.proxy 
```
- local change git
```shell
git reset --hard 
```

