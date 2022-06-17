---
sort: 5
---

# Compiling CMake

- need C++ compiler to install CMAKE, so need to load C++ compiler before install
- Source code repo: [https://github.com/Kitware/CMake](https://github.com/Kitware/CMake)
- or download CMake from: [https://cmake.org/download](https://cmake.org/download)
```shell
wget https://cmake.org/files/v3.20/cmake-3.20.3.tar.gz
tar zxvf cmake-3.21.2.tar.gz
cd cmake-3.21.2
```

## USC 1 (Eagle)
```shell
module load compiler/gcc-10.3

./configure --prefix=/uhome/p001cao/local/app/tool_dev/cmake-3.21

make -j 20
make install
```

## USC 2 (Tacheon)

```shell
module load compiler/gcc-11.2

./configure --prefix=/home1/p001cao/local/app/tool_dev/cmake-3.24
```

## create module file
cd /uhome/p001cao/local/Imodfiles  -->  create file "cmake-3.20.3"
```shell
# for Tcl script use only 
set         topdir                  /uhome/p001cao/local/app/tool_dev/cmake-3.18.0
set         version                cmake-3.20.3

setenv              cmake           $topdir
prepend-path        PATH            $topdir/bin
```

Validate installation:
```shell
module load cmake-3.20.3
cmake --version
```

Ref:
- [https://pachterlab.github.io/kallisto/local_build.html](https://pachterlab.github.io/kallisto/local_build.html)
- [https://github.com/Kitware/CMake](https://github.com/Kitware/CMake)
