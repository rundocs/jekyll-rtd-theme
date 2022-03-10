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
The file `project-folder/thatool/__init__.py` should contain:
```py
__author__ = "thangckt"
__version__ = '0.1'
from .                  import  data
from .filetool          import  *
from .free_energy_cal   import  *
from .modeling          import  *
from .parameter         import  *
from .utils             import  *
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
Once the package is able to pip-install locally, it is ready for upload. \\
We need two more things:
- We will do this using 'Twine' so you need to pip install that, too. `pip install twine`
- You need an account on [PyPI](https://pypi.org/account/login/).

In `project-folder` folder:
1. create a source distribution with the following command:
  ```
  python setup.py sdist
  ```
2. upload to PyPI
  ```
  twine upload dist/*
  ```

  ```
  Uploading distributions to https://pypi.org/legacy/
  Enter your username:
  Enter your password:
  ```

Now, the package is availabe for install 
```
pip install thatool 
pip install thatool --upgrade
```
May need:
```
pip3 install --upgrade requests
```

## Public package via Conda
We will need `conda-build`: `conda install conda-build`

There are many ways to upload into conda, The simplest way for creating a conda package for your python script is to first publish it in PyPI following the steps explained above.

### Building a python package with conda skeleton PyPI
We will working with a package named 'thatool' that is hosted on PyPI.\\

1. Create pypi skeleton: run this command from any folder
   
```
conda skeleton pypi thatool
```
this will generate a folder `thatool` contains file `meta.yaml`

2. Edit meta.yaml and update requirements:
   
```py
extra:
  recipe-maintainers:
    thangckt
```

3. Build your package with conda
The package is now ready to be build with conda:

```shell
conda-build thatool 
conda-build thatool -c conda-forge       # -c conda-forge -c anaconda   
```
This will generate a conda-package at location: `C:\DevProgram\miniconda3\conda-bld\win-64`. The conda package we have created is specific to your platform (here win-64). It can be converted to other platforms using [conda convert](https://tinyurl.com/y8k2qzrh).

4. Upload package to anaconda/conda-forge/bioconda
Upload to Anaconda.org ([see this](https://tinyurl.com/y7xkbht2))

```
conda install anaconda-client
anaconda login
anaconda upload C:\DevProgram\miniconda3\conda-bld\win-64\thatool-0.8-py37_0.tar.bz2
```

```
conda convert --platform linux-64 C:\DevProgram\miniconda3\conda-bld\win-64\thatool-0.8-py37_0.tar.bz2 -o C:\DevProgram\miniconda3\conda-bld\
anaconda upload C:\DevProgram\miniconda3\conda-bld\linux-64\thatool-0.8-py37_0.tar.bz2
```

if upload completes, the conda package located at:
https://anaconda.org/thangckt/thatool

To install this package: 

```
conda install thatool -c thangckt
```

## Ref.
[1]. https://aaltoscicomp.github.io/python-for-scicomp/packaging/

