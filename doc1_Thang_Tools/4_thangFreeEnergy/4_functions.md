---
sort: 3
---

# *functions* 

The functions to read data from text files.

REFs:


## .replica_logPD_intergration()
The **function** to compute LogPD-based MeanForce
Ref: <br>
[1].https://pubs.acs.org/doi/10.1021/acs.jctc.7b00252 Free Energy Reconstruction from Logarithmic Mean-Force Dynamics Using Multiple Nonequilibrium TrajectoriesFree
[2] Exp-normalize trick: https://timvieira.github.io/blog/post/2014/02/11/exp-normalize-trick/

NOTEs: About the printed values in <replica.out> and <logmfd.out> as reply from Tetsuya Morishita
```
<logmfd.out>
1:iter_md, 2:Flog(t), …, 6: X(t), 7: V(t), 8: Force(t)
1   F(1), …, X(1), V(1), Force(0)
2   F(3), …, X(2), V(2), Force(1)

<replica.out>
iter_md, work, weight, cv
1  work(1)   weight(1)  cv(0)
2  work(2)   weight(2)  cv(1)
```
Requisites:
1. Run logMFD simulations to produce "replica_*/logmfd.out" and "replica_*/replica.out"

Cao Thang, Jul2020 (update: Sep 2021)

* Inputs-Compulsory: <br>
	- logmfdFiles: |`list`| of "logmfd.out" files
	- replicaFiles: |`list`| of "replica.out" files
* Outputs: <br> 
	- logPD file: contains logPD-based MeanForce
* Usage: <br> 
```python
	thaFreeEnergy.replica_logPD_intergration(logmfdFiles, replicaFiles)
```


## .replica_MD_average()
The **function** to compute Replica_MD_Average from output of MD.
Requisites:
1. Replica_* files from separate MD simulations

* Inputs-Compulsory: <br>
	- MDoutFiles: |`list`| of "MDout_replica.txt" files
* Outputs: <br> 
	- logPD file: contains logPD-based MeanForce
* Usage: <br> 
```python
	thaFreeEnergy.replica_MD_average(MDoutFiles)
```

