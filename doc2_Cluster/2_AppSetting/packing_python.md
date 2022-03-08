---
sort: 42
---

# Orgarnize and packing python Lib

## Directory & File Structure
Create folders and files as following structure:

```
project_folder  # (thatool_package)
│   README.md
│   setup.py    
│
└───thatool
    │   __init__.py
    │   data.py  
    │
    └───filetool
    │   │   __init__.py
    │   │   define_script.py
    |   |   LmpFrame.py
    │   │   ...
    │   
    └───free_energy_cal
    │   │   __init__.py
    │   │   Helmholtz_excess_UF.py
    │   |   replica_logPD_intergration.py
    │   │   ...
    └───modeling
    │   │   __init__.py
    │   │   box_orientation.py
    │   |   crystal3D.py
    │   │   ...
    └───utils
    │   │   __init__.py
    │   │   coord_rotation.py
    │   |   unit_convert.py
    │   │   ...
    |   
```

## Testing a local pip install
To make the package pip-installable we need to add `setup.py` file into the topest level of project-folder:
```py
from setuptools import setup, find_packages

setup(
  name = 'thatool',         # How you named your package folder (MyLib)
  version = '0.1',      # Start with a small number and increase it with every change you make
  author = 'Cao Thang',                   # Type in your name
  author_email = 'caothangckt@gmail.com',      # Type in your E-Mail
  # description = 'TYPE YOUR DESCRIPTION HERE',   # Give a short description about your library
  # long_description='long_description',
  # license='MIT',        # Chose a license from here: https://help.github.com/articles/licensing-a-repository
#   url = 'https://github.com/user/reponame',   # Provide either the link to your github or to your website
#   download_url = 'https://github.com/user/reponame/archive/v_01.tar.gz',    # I explain this later on
#   keywords = ['SOME', 'MEANINGFULL', 'KEYWORDS'],   # Keywords that define your package best

  packages = find_packages(),
  install_requires=[            # I get to this in a second
          'scipy', 
          'pandas', 
          'matplotlib', 
          'lmfit', 
          'shapely',
      ],

  python_requires='>=3.6',

  classifiers=[
    'Development Status :: 3 - Alpha',      # Chose either "3 - Alpha", "4 - Beta" or "5 - Production/Stable" as the current state of your package
    'Intended Audience :: Developers',      # Define that your audience are developers
    'Topic :: Software Development :: Build Tools',
    'Programming Language :: Python :: 3.7',
  ],

)
```
The try this command in `project-folder`:
```
cd project_folder
pip install .
```

## Public package via PyPI




## Install requirement
### Windows 
conda install  conda-build git 
conda install -c msys2 m2-patch

### Linux 
conda install  conda-build git patch

## Create files
1. Create a meta.yaml file
2. Create your build.sh and/or bld.bat files
   
### Creating a meta.yaml file
Your `meta.yaml` file is the recipe that tells conda how to build your library. It is similar to the `setup.py` used to create a library for pip.

```yaml
package:
  name:
  version:

source:
  git_rev:
  git_url:

requirements:
  build:
    - python
    - setuptools

  run:
    - python

test:
  imports:
    -

about:
  home:
```
In the `requirements` section, the list under `run:` holds all of the dependencies your library requires

### Create build.sh and/or bld.bat Files
- build.sh is the shell script for macOS and linux
- bld.bat is the batch file for windows
These files are quite simple, and should be exactly as show below:

bld.bat
```bash
"%PYTHON%" setup.py install
if errorlevel 1 exit 1
```

build.sh
```shell
$PYTHON setup.py install     # Python command to install the script.
```

## Build Your Package
Now, in the root directory of your package, run the following command:
```
conda build .
```
Once that is complete it will display the path to the build file. It should looks something like this:
```
~/anaconda/conda-bld/linux-64/packagename-py37_0.tar.bz2
```



## Ref.
[1]. https://aaltoscicomp.github.io/python-for-scicomp/packaging/

