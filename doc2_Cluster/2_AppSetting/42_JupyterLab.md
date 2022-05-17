---
sort: 4
---

# Jupyterlab

```note
- Should use python 3.7 in base env (mimimum supported by conda, conflict DLL py36 and py37)
- Jupyterlab is now availabe as a [Desktop App](https://github.com/jupyterlab/jupyterlab-desktop)
```

## 1. Jupyterlab as Desktop App
JupyterLab App is the cross-platform standalone application distribution of JupyterLab. It is a self-contained desktop application which bundles a Python environment with several popular Python libraries ready to use in scientific computing and data science workflows.

[Download](https://github.com/jupyterlab/jupyterlab-desktop)

See [this link](https://blog.jupyter.org/jupyterlab-desktop-app-now-available-b8b661b17e9a)



## 2. Use multil envs in Notebook
- ref: https://tinyurl.com/y7hcfvws ;  https://tinyurl.com/y7hcfvws
- must select to open notebook by jupyterlab in base-env

```shell
## intall extension
conda install -n base nb_conda

## create new env
conda create -n py37polymer python=3.7
conda activate py37polymer
conda install jupyterlab
```

Then we can select env in jupyterlab:
- change kernel (this will be save for the next open of .ipynb file)


## 3. Some errors

500 : internal server error jupyterlab

Solution:
```shell
conda upgrade nbconvert 
```

# Cluster

https://researchcomputing.princeton.edu/support/knowledge-base/scaling-analysis

