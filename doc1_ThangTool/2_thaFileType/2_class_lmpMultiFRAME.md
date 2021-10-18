---
sort: 2
---

# *class* lmpMultiFRAME

This class create a data-object (multi configurations) for the analysis of computing data from LAMMPS. The file formats implemented in this class <br>
- [XYZ format](https://www.cgl.ucsf.edu/chimera/docs/UsersGuide/xyz.html)

This class implemented the ways to create `lmpFRAME` object <br>
- read frome XYZ file 

REFs:


## Initilization
The constructor of class, there are several ways to initilize the lmpFRAME object
* Inputs-Compulsory: <br>
* Inputs-Optional: <br> 
	- readXYZ='fileName' |`string` | is the name of DUMP file
* Usage: <br> 
```python
	# from XYZ file 
	ldf = thaFileType.lmpFRAME(readXYZ='test.xyz')
```
* **Attributes:** <br> 
	- .name     = 'Frame created by Thang' |`string` | name of input file
	- .frame    = ldf  |`list-DataFrame`| list-of-frames of configurations


## .readXYZ()
The **method** create Multi-FRAME object by reading XYZ file.
* Inputs-Compulsory: <br>
	- fileName   			| `string` | the name of XYZ file 
* Inputs-Optional: <br> 
* Outputs: <br> 
	- .frame = ldf  |`list-DataFrame`| list-of-frames of configurations
* Usage: <br> 
```python
	da = thaFileType.lmpFRAME()
	da.readXYZ('dump.xyz')
```