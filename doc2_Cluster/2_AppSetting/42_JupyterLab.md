---
sort: 4
---

# Jupyterlab

```note
Should use python 3.7 in base env (mimimum supported by conda, conflict DLL py36 and py37)
```

## 1. Use multil envs in Notebook
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


## 2. Some errors

500 : internal server error jupyterlab

Solution:
```shell
conda upgrade nbconvert 
```

# Cluster

https://researchcomputing.princeton.edu/support/knowledge-base/scaling-analysis

