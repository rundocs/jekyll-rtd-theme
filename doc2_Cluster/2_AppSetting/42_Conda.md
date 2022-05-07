---
sort: 1
---

# Conda

## Installation
### I. Install Anaconda on Linux (USC-locally installation)
Download Anaconda installer for Linux.
https://repo.anaconda.com/miniconda/
                          Anaconda3-2019.03-Linux-x86_64

Consider Miniconda for light, and reduce error
wget https://repo.continuum.io/miniconda/Miniconda3-latest-Linux-x86_64.sh

Put this file in folder: /uhome/p001cao/local/W_Source_Code

```shell
cd /uhome/p001cao/local/W_Source_Code
# Installing:
module load compiler/gcc-11.2
export PATH=/uhome/p001cao/local/app/compiler/gcc-11.2/bin:$PATH
export CC=gcc
export CXX=g++
export FORTRAN=gfortran
##
bash Miniconda3-py37_4.9.2-Linux-x86_64.sh -u
#or bash Miniconda3-py37_4.9.2-Linux-x86_64.sh 
choose folder to install:   /uhome/p001cao/local/app/miniconda3
running conda init?  NO
... finish
```

 3. Create Conda module
```
set     topdir          /uhome/p001cao/local/miniconda3
prepend-path    PATH                    $topdir/bin
prepend-path    LD_LIBRARY_PATH         $topdir/lib
prepend-path    INCLUDE                 $topdir/include
and put this file into folder:  /uhome/p001cao/local/share/lmodfiles
```

4. Create Python Environments in conda
https://manjusri.ucsc.edu/2017/09/08/environment-modules/
create 2 evironments: python37, python27
```
module load conda/conda3
conda create -n py37Lammps python=3.7.5
conda create -n py27env python=2.7
```

create module files for 2 environments
```
set     topdir          /uhome/p001cao/local/Miniconda3/envs/py37ompi

prepend-path    PATH                    $topdir/bin
prepend-path    LD_LIBRARY_PATH         $topdir/lib
prepend-path    INCLUDE                 $topdir/include
or :
## python27env_conda3
set     topdir          /uhome/p001cao/local/Anaconda3
module load conda3
```
if [ module-info mode load ] {
   puts stdout "source   $topdir/bin/activate py27env"
}
Note: in each env, using pip to install or update pkgs. 
module   load python37env_conda3
pip    install       numpy scipy tess
pip     update     --all

Or use conda with specific name of env
module load conda3
conda install -n py37env numpy scipy

```
# or 
module load conda3
source activate py37env 
pip install tess              #  voro++ library
```

References:
https://stackoverflow.com/questions/22885134/how-to-load-virtualenv-using-environmental-module-file-tcl-script
1) How To Install the Anaconda Python Distribution on Ubuntu 16.04
2) Installing Anaconda on linux
3) No bashrc file in my home directory
4) Using vi, the Unix Visual Editor


### II. Install Miniconda on Windows
Anaconda: https://www.anaconda.com/distribution/#windows
Miniconda: https://repo.anaconda.com/miniconda/
make anaconda available in cmd windows, and can double click to open jypyter file
add 3 new environment variable path: Environment Variables --> System Variables --> path --> edit

```
C:\DevProgram\miniconda3
C:\DevProgram\miniconda3\Scripts
C:\DevProgram\miniconda3\Library\bin
```

- for environment named py37 (should not use to avoid errors, maybe in tf)
C:\DevProgram\miniconda3\envs\py37
C:\DevProgram\miniconda3\envs\py37\Scripts
C:\DevProgram\miniconda3\envs\py37\Library\bin

- Set default environment in anaconda On Windows: https://tinyurl.com/y2meq2wm
right-lick on: Anaconda Powershell Prompt (miniconda3) shorcut --> properties -->Target:
change: ...; conda activate 'C:\DevProgram\miniconda3'
to : ...; conda activate 'C:\DevProgram\miniconda3\envs\py37'

## III. Environments management & install packages
With conda, you can create, export, list, remove, and update environments that have different versions of Python and/or packages installed in them. Switching or moving between environments is called activating the environment
1. To see list of all environments:
conda info --envs             # or
conda env list
(default just only 1 root environment with name : base) The active environment is marked with an asterisk
Viewing a list of the packages in an environment
conda list -n myenv
conda list -n py37env 
If the environment is activated,
conda list
 2. Create an environment
To create an environment with a specific version of Python:
conda create -n py36mpi python=3.6
conda create -n py27env python=2.7
To create an environment with a specific version of a package:
conda create -n py36mpi python=3.6 scipy=1.3.1 numpy=1.16.5
OR:
conda create -n py37env python=3.7 
conda install -n py37env scipy=1.3.1 numpy=1.16.5

The default packages are installed every time you create a new environment. To create an environment with no install default packages:
conda create --no-default-packages -n myenv python
Cloning an environment You can make an exact copy of an environment by creating a clone of it:
conda create --name NewcloneEnv --clone oldEnv

we can create as many additional environments as you want. And the whole point is that these additional environments can contain different versions of Pythons and other packages.
D:\Miniconda3-64\. It contains the root environment and two important directories (the other directories are irrelevant for now):
\pkgs (it contains the cached packages in compressed and uncompressed formats)
\envs (it contains the environments — except for the root environment — in separate subdirectories)
The most significant executable files and directories inside a Conda environment (placed in the \envs\environmentname directory) are:
\python.exe — the Python executable for command line applications. So for instance, if you are in the directory of the Example App, you can execute it by: python.exe exampleapp.py
\pythonw.exe — the Python executable for GUI applications, or completely UI-less applications
\Scripts — executables that are parts of the installed packages. Upon activation of an environment, this directory is added to the system path, so the executables become available without their full path
\Scripts\activate.exe — activates the environment
And if you’ve installed Jupyter, this is also an important file:
\Scripts\jupyter-notebook.exe— Jupyter notebook launcher (part of the jupyter package).
3. Activating and leaving (deactivating) an environment
the root environment is activated by default, so you can use it without activation. In other cases, if you want to use an environment (for instance manage packages, or run Python scripts inside it) you need to first activate it
conda activate py37env
source activate py37env
* on linux can use module-file (see above)
Remove env:  conda  env  remove   -n  myenv


### Install & Update packages in Conda
install a package also replaces the current package. open Anaconda_Prompt

#### Uninstall all packages
```
conda clean --yes --all
```

4.1 Searching for packages: To see if a specific package, such as SciPy, is available for installation:
conda search  scipy
conda search -c conda-forge mpi4py     # find package
conda search -c intel       mpi4py      # in used
conda search -c anaconda    mpi4py  

4.2 Installing packages: in conda prompt, activated environment
conda activate  myenv
conda install python=3.6     # to use intel-mpi4py on window
conda install -c intel mpi4py=3.0.0=py36_intel_0
Install into specific environment:
conda install -n py37ompi scipy=1.3.1 numpy=1.16.5 python=3.7.4 
Ref:
https://docs.conda.io/projects/conda/en/latest/user-guide/tasks/manage-environments.html
https://protostar.space/why-you-need-python-environments-and-how-to-manage-them-with-conda

IV. Useful packages
IV.1 jupyter notebook --> jypyterLab
Jupyter Lab: Evolution of the Jupyter Notebook. JupyterLab is a next-generation web-based user interface for Project Jupyter.
https://jupyterlab.readthedocs.io/en/stable/user/notebook.html
https://jupyterlab.readthedocs.io/en/stable/getting_started/overview.html
conda install -c conda-forge jupyterlab nodejs
pip install jupyterlab==2.2.0rc1
pip install jupyterlab==3.0.0a4

##pre-release
 pip install jupyterlab --pre
conda install -c conda-forge/label/jupyterlab_rc -c conda-forge/label/jupyterlab_server_rc -c conda-forge jupyterlab=3
conda install -c conda-forge/label/prerelease-jupyterlab jupyterlab
 

Use jupyter-Lab: right-click on ipynb files --> properties --> opens with: (change) --> jupyter-lab
Use jupyter-clasic: right-click on ipynb files --> properties --> opens with: (change) --> jupyter-notebok 
- Monokai++ theme: https://www.npmjs.com/package/@hokyjack/jupyterlab-monokai-plus
- consider monokai++, identical-sublime-monokai theme for VScode

## IV. Some useful packages Numpy, scipy, pandas, matplotlib:

```
conda install numpy scipy scikit-learn pandas matplotlib

# mpi4py with openmpi:
conda install -c conda-forge mpi4py
conda install -c intel mpi4py

# openmpi: (linux)
conda install -c conda-forge openmpi 
conda install -c conda-forge openmpi-mpicc openmpi-mpicxx openmpi-mpifort 

# Voro++, Ovito, shapely:
https://shapely.readthedocs.io/en/latest/manual.html
pip install tess ovito shapely

# OpenEye toolkit:
https://www.eyesopen.com/
conda search -c openeye openeye-toolkits
conda install -c openeye openeye-toolkits

3. lmfit 
python lib for curve fitting
https://lmfit.github.io/lmfit-py/model.html
pip install lmfit
```
#### reset all packages in an environment
```python
conda install --revision 0
```


## Some setting envs
```note 
- Should use python 3.7 in base-env (mimimum supported by conda, conflict DLL py36 and py37)
- use mamba for faster
- Use multi python in jupyterlab: `conda install -n base nb_conda`, and must select to open notebook by jupyterlab in base-env
```

Install mamba into the base environment:
```python
conda install -n base mamba -c conda-forge
conda install -n base nb_conda
conda -y -c conda-forge jupyterlab=3.4
```

Install in envs
```python
## env for general use
conda create -n py37 python=3.7
conda activate py37
conda install -y -c conda-forge jupyterlab ele numpy pandas matplotlib shapely scipy

## env for polymer package: mbuild
conda create -n py37mbuild python=3.7
conda activate py37mbuild
mamba install -y -c conda-forge jupyterlab ele numpy pandas matplotlib shapely scipy mbuild

## env for polymer package: pysimm
conda create -n py37pysimm python=3.7
conda activate py37pysimm
conda install -y -c conda-forge jupyterlab numpy pandas matplotlib scipy


## env for ovito interpreter
conda create -n py36ovito python=3.6
conda activate py36ovito
conda install -y -c conda-forge jupyterlab

```







