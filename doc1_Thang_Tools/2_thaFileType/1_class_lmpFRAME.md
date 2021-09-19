---
sort: 1
---

# *class* lmpFRAME

This class create a data-object (single configuration) for the analysis of computing data from LAMMPS. The file formats implemented in this class <br>
	- [LAMMPS DATA Format](https://docs.lammps.org/2001/data_format.html)
	- [LAMMPS DUMP Format](https://docs.lammps.org/dump.html)
	- [PDB format](https://ftp.wwpdb.org/pub/pdb/doc/format_descriptions/Format_v33_Letter.pdf)
	- [XYZ format](https://www.cgl.ucsf.edu/chimera/docs/UsersGuide/xyz.html)

![pic](https://icme.hpc.msstate.edu/mediawiki/images/e/e7/4kovito.gif)

This class implemented several ways to create `lmpFRAME` object <br>
	- create an empty data object
	- createFRAME object with input data
	- read from DUMP file 
	- read from DATA file 
	- read frome PDB file 

REFs:


## Initilization
The constructor of class, there are several ways to initilize the lmpFRAME object
* Inputs-Compulsory: <br>
* Inputs-Optional: <br> 
	- readDUMP='fileName' |`string` | is the name of DUMP file
	- readDATA='fileName' |`string` | is the name of DATA file
		- atom_style = 'atomic'|`string` | option to input type of atomistic system
		- nFlag = False        |`boolean` | read nFlag or not
	- readPDB='fileName' |`string` | is the name of PDB file
	- createFRAME=df |`DataFrame`| pd.DataFrame contains atomic positions and properties of system
		- box = [[0,1],[0,1],[0,1]]	|`array` `list`3x2| option to input boxSize
		- boxAngle = [0,0,0]        |`array` `list`1x3| option to input boxAngle
* Usage: <br> 
```python
	da = thaFileType.lmpFRAME()
	da = thaFileType.lmpFRAME(readDUMP='dump.cfg')
	da = thaFileType.lmpFRAME(readDATA='mydata.dat', atom_style='atomic', nFlag=False)
```
* **Attributes:** <br> 
	- .name     = 'Frame created by Thang' |`string` | name of input file
	- .timestep = 0   |`integer`| the timestep of configuration
	- .frame    = None |`DataFrame`| DataFrame of per-atom values
	- .propKey  = None |`list`| column-names of properties
	- .box		= np.asarray([[0,1],[0,1],[0,1]]) |`array` `list`3x2| option to input boxSize
	- .boxAngle = np.zeros(3)   				|`array` `list`1x3| option to input boxAngle
	- .mass		= np.asarray([])  |`array`nx1|	atomic masses
	- .fmtSTR 	= "%.6f" |`string` | default format for float numbers, don't use %g because it will lost precision


## .createFRAME()
The **method** create new FRAME object with input data.
* Inputs-Compulsory: <br>
	- DataFrame			|`DataFrame`| pd.DataFrame of input data
* Inputs-Optional: <br> 
	- box = [[0,1],[0,1],[0,1]]	|`array` `list`3x2| option to input boxSize
	- boxAngle = [0,0,0]        |`array` `list`1x3| option to input boxAngle
* Outputs: <br> 
	- modifying the lmpFRAME object attributes.
* Usage: <br> 
```python
	da = thaFileType.lmpFRAME()
	da.createFRAME(DataFrame=df)
```

## .readDUMP()
The **method** create FRAME object by reading DUMP file.
* Inputs-Compulsory: <br>
	- fileName   			| `string` | the name of DUMP file 
* Inputs-Optional: <br> 
* Outputs: <br> 
	- modifying the lmpFRAME object attributes.
* Usage: <br> 
```python
	da = thaFileType.lmpFRAME()
	da.readDUMP('dump.cfg')
```

## .readDATA()
The **method** create FRAME object by reading DATA file.
* Inputs-Compulsory: <br>
	- fileName   			| `string` | the name of DATA file 
* Inputs-Optional: <br> 
	- atom_style = 'atomic'	| `string` | 'atomic', 'charge', 'molecular', 'full': the style of atomistic system.The format of "data file" depend on the definition of ["atom_style"](https://lammps.sandia.gov/doc/atom_style.html). See [list of atom_style format](https://lammps.sandia.gov/doc/read_data.html#description)
		- atomic      : atom-ID atom-type x y z
		- charge      : atom-ID atom-type q x y z
		- molecular   : atom-ID molecule-ID atom-type x y z
		- full        : atom-ID molecule-ID atom-type q x y z
	- nFlag		= False    	| `boolean`| whether or not include nFlag 
* Outputs: <br> 
	- modifying the lmpFRAME object attributes.
* Usage: <br> 
```python
	da = thaFileType.lmpFRAME()
	da.readDATA('mydata.dat', atom_style='atomic', nFlag=False)
```



## .writeDUMP()
The **method** to write DUMP file.
* Inputs-Compulsory: <br>
	- fileName   			| `string` | the name of DUMP file 
* Inputs-Optional: <br> 
	- column =['id','type',...] | `list`1xN| contains columns to be written, by default all columns will be written 
	- fmtSTR	= '%.6f'   	| `string` | string format for output values 
* Outputs: <br> 			
	- file 					| `*.cfg`  | the DUMP file 
* Usage: <br> 
```python
	da.writeDUMP('test.cfg', column=['id','type','x','y','z'], fmtSTR='%.4f')
```

## .writeDATA()
The **method** to write DATA file.
* Inputs-Compulsory: <br>
	- fileName   			| `string` | the name of DATA file 
* Inputs-Optional: <br> 
	- atom_style = 'atomic'	| `string` | 'atomic', 'charge', 'molecular', 'full': the style of atomistic system 
	- nFlag		= False    	| `boolean`| whether or not include nFlag 
	- vel 		= False    	| `boolean`| whether or not write Velocity 
	- fmtSTR	= '%.6f'   	| `string` | string format for output values 
	- comment   = ''      	| `string` | the comment 
* Outputs: <br> 			
	- file 					| `*.dat`  | the DATA file 
* Usage: <br> 
```python
	da.writeDATA('test.dat', atom_style='atomic', nFlag=False, vel=False, fmtSTR='%.4f')
```

## .writeXYZ()
The **method** to write XYZ file.
* Inputs-Compulsory: <br>
	- fileName   			| `string` | the name of XYZ file 
* Inputs-Optional: <br> 
	- column 	= ['X','xu','yu','zu'] | `list` 1xN| list contains columns to be written  
	- fmtSTR	= '%.6f'   	| `string` | string format for output values 
* Outputs: <br> 			
	- file 					| `*.cfg`  | the XYZ file 
* Usage: <br> 
```python
	da.writeXYZ('test.xyz')
```

## .writePDB()
The **method** to write PDB file.
* Inputs-Compulsory: <br>
	- fileName   			| `string` | the name of XYZ file 
* Inputs-Optional: <br> 
	- fmtSTR	= '%.6f'   	| `string` | string format for output values 
* Outputs: <br> 			
	- file 					| `*.pdb`  | the PDB file 
* Usage: <br> 
```python
	da.writePDB('test.pdb')
```

## .addColumn()
The **method** to add new columns to da.frame.
* Inputs-Compulsory: <br>
	- data   			| `DataFrame` `Series` `List` | Nxm data of new columns
* Inputs-Optional: <br> 
	- newColumn	= data.columns | `list-string` | 1xN list contains names of columns, if do not provide, it take columnNames from DataFrame
	- replace	= False | `boolean`| replace column if existed
* Outputs: <br> 			
	- modify da.frame
* Usage: <br> 
```python
	da.addColumn(df, myColumn=['col1','col2'], replace=True)
```

## .deleteColumn()
The **method** to delete columns from da.frame.
* Inputs-Compulsory: <br>
	- delColumns	      | `list-string` | 1xN list contains names of columns to be deleted
* Inputs-Optional: <br> 
* Outputs: <br> 			
	- modify da.frame
* Usage: <br> 
```python
	da.deleteColumn(delColumns=['col1','col2'])
```