---
sort: 42
---

# Jupyterlab

## Use multil envs in Notebook
- ref: https://tinyurl.com/y7hcfvws ;  https://tinyurl.com/y7hcfvws

```shell
## create new env
conda create -n py37polymer python=3.7
conda activate py37polymer
conda install jupyterlab

## intall extension
conda install -n base nb_conda
```

Then we can select env in jupyterlab:
- change kernel (this will be save for the next open of .ipynb file)

## Some errors

500 : internal server error jupyterlab

Solution:
```shell
conda upgrade nbconvert 
```

# Cluster

https://researchcomputing.princeton.edu/support/knowledge-base/scaling-analysis

