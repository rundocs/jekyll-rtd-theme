---
sort: 4
---

# Jupyterlab
```note
- Should use python 3.7 in base env (mimimum supported by conda, conflict DLL py36 and py37)
- Jupyterlab is now availabe as a [Desktop App](https://github.com/jupyterlab/jupyterlab-desktop)
```

## 1. Install

**conda 
```shell
conda install -c conda-forge jupyterlab
```

**pip
```shell
pip install jupyterlab
```

**from source
```shell
pip install git+git://github.com/jupyterlab/jupyterlab.git@master
conda install -c conda-forge json5
```


## 2. Use multil envs in Notebook
```note
- must select to open notebook by jupyterlab in base-env
```

```shell
(base)$ conda install -c conda-forge nb_conda
## create new env
conda create -n py37mbuild python=3.7
conda activate py37mbuild
conda install jupyterlab
```

Then we can select env in jupyterlab:
- change kernel (this will be save for the next open of .ipynb file)

Ref: 
https://tinyurl.com/y7hcfvws 
https://tinyurl.com/y7hcfvws 
https://tinyurl.com/2xohogjq

## 3. Some errors

500 : internal server error jupyterlab

Solution:
```shell
conda upgrade nbconvert 
```

## 4. Jupyterlab as Desktop App
JupyterLab App is the cross-platform standalone application distribution of JupyterLab. It is a self-contained desktop application which bundles a Python environment with several popular Python libraries ready to use in scientific computing and data science workflows.

[Download](https://github.com/jupyterlab/jupyterlab-desktop)

See [this link](https://blog.jupyter.org/jupyterlab-desktop-app-now-available-b8b661b17e9a)

## configuration files
https://github.com/jupyterlab/jupyterlab-desktop#configuration-files

```tip
- To use multi envs in App, remember to choose PYTHON-path as the base-env conda. Can change this by change "pythonPath" is this file:
%APPDATA%\jupyterlab-desktop\jupyterlab-desktop-data
- App version may not compatible with some plot packages, not good as web version
```




## Cluster

https://researchcomputing.princeton.edu/support/knowledge-base/scaling-analysis

