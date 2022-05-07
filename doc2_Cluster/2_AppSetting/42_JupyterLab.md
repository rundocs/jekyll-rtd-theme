---
sort: 42
---

# Jupyterlab

```note
Some packages such as: ovito, pysimm,... just support py36. So, python on env-base conda must be installed with python36, then create env py36 to avoid conflict errors.
```

```python
## revert your environment back to the original state before you installed any additional packages:
conda activate base
conda install --revision 0
python install -y python=3.6
```

## 1. Use multil envs in Notebook
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

