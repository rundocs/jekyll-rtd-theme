---
sort: 10
---

# Use git

## download use Git
```shell
git clone --branch <tag_name> <repo_url>
```

### Download specific TAG:  
```shell
git checkout <tag_name>
git pull origin <tag_name>
```
Instance:
```shell
git clone https://github.com/lammps/lammps.git    lammps_master
cd lammps_master
git pull origin master
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

