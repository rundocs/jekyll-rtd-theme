---
sort: 1
---

# *class* lmpFRAME

This class create a data-object (single configuration) for the analysis of computing data from LAMMPS. The file formats implemented in this class
	- [LAMMPS DATA Format](https://docs.lammps.org/2001/data_format.html)
	- [LAMMPS DUMP Format](https://docs.lammps.org/dump.html)
	- [PDB format](https://ftp.wwpdb.org/pub/pdb/doc/format_descriptions/Format_v33_Letter.pdf)
	- [XYZ format](https://www.cgl.ucsf.edu/chimera/docs/UsersGuide/xyz.html)

![pic](https://icme.hpc.msstate.edu/mediawiki/images/e/e7/4kovito.gif)

This class implemented several ways to create `lmpFRAME` object
	- create an empty data object
	- read from DUMP file 
	- read from DATA file 
	- read frome PDB file 


REFs:


## Initilization
* Inputs Compulsory: 
* Inputs Optional: 
	- readDUMP='fileName': imput `string', is the name of DUMP file
	- readDATA='fileName': imput `string', is the name of DATA file
		- atom_style = 'atomic'	: option to input type of atomistic system
		- nFlag = False/True`		: read image flag or not
	- readPDB='fileName': imput `string', is the name of PDB file
	- createFRAME=df: df is `pandas.DataFrame` contain atomic positions and properties of system
		- box = [[0,1],[0,1],[0,1]]	: option to input boxSize
		- boxAngle = [0,0,0]				: option to input boxAngle
		- mass = []									: option to input atomic masses

* Usage: 
```python
	da = thaFileType.lmpFRAME()
	da = thaFileType.lmpFRAME(readDUMP='dump.cfg')
	da = thaFileType.lmpFRAME(readDATA='mydata.dat', atom_style='atomic', nFlag=False)
```
* **Attributes:**
	- .fmtSTR 			: `string`, default format for float numbers.
	- .name 		: `string`, name of input file
	- .timestep : `integer`, the timestep of configuration
	- .propKey  : `list`, column-names of properties
	- .box      : 3x2 `array`, dimension of box
	- .boxAngle	: 1x3 `array`, angles of box
	- .mass			: nx1 `array`, atomic masses
	- .frame    : `pandas.DataFrame`, data of configuration

## .readDUMP()
The **method** create FRAME object by reading DUMP file.
* Inputs Compulsory: 
	- fileName: `string', is the name of DUMP file
* Inputs Optional:
* Outputs: alternate the lmpFRAME object attributes.S
* Usage: 
```python
	da = thaFileType.lmpFRAME()
	da.readDUMP('dump.cfg')
```

## .readDATA()
The **method** create FRAME object by reading DATA file.
* Inputs Compulsory: 
	- fileName: `string', is the name of DUMP file
* Inputs Optional:
	- atom_style='atomic'/'charge'/'molecular'/'full': The format of "data file" depend on the definition of ["atom_style"](https://lammps.sandia.gov/doc/atom_style.html)
	- nFlag = False/True: read nFlag or not.
* Outputs: alternate the lmpFRAME object attributes.
* Usage: 
```python
	da = thaFileType.lmpFRAME()
	da.readDUMP('mydata.dat', atom_style='atomic', nFlag=False)
```

## .createFRAME()
The **method** create FRAME object with input data.
* Inputs Compulsory: 
	- DataFrame: `pandas.DataFrame`, data of configuration
* Inputs Optional:
	- box = [[0,1],[0,1],[0,1]]	: option to input boxSize
	- boxAngle = [0,0,0]				: option to input boxAngle
	- mass = []									: option to input atomic masses
* Outputs: 
	- modifying the lmpFRAME object attributes.
* Usage: 
```python
	da = thaFileType.lmpFRAME()
	da.createFRAME(DataFrame=df)
```


## .writeDUMP()
The **method** to write DUMP file.
* Parameters:

	| Inputs-Compulsory | Type    | Description |
	|:------------------|:-------:|:------------|
	| fileName   		| `string`| the name of DATA file |

	| Inputs-Optional   | Default/Possible 	| Type    | Description |
	|:------------------|:------------------|:-------:|:------------|
	| column        	| ['id','type',...] | `list` list 1xN| contains columns to be written, by default all columns will be written |
	| fmtSTR		 		| '%.6f'   			| `string`| string format for output values |

	| Outputs 			| Type    | Description |
	|:------------------|:-------:|:------------|
	| 					| '.cfg'  | the DUMP file |

* Usage: 
```python
	da.writeDUMP('test.cfg', column=['id','type','x','y','z'], fmtSTR='%.4f')
```

## .writeDATA()
The **method** to write DATA file.
* Inputs-Compulsory: <br>
	- fileName   		| `string`| the name of DATA file 
* Inputs-Optional: <br> 
	atom_style = 'atomic'| `string` | 'atomic', 'charge', 'molecular', 'full': the style of atomistic system 
	nFlag		= False    | `boolean`| whether or not include nFlag 
	vel 		= False    | `boolean`| whether or not write Velocity 
	fmtSTR		= '%.6f'   | `string` | string format for output values 
	comment   	= ''      | `string` | the comment 
* Outputs: <br> 			
	- file | '.dat'  | the DATA file 
* Usage:
```python
	da.writeDATA('test.dat', atom_style='atomic', nFlag=False, vel=False, fmtSTR='%.4f')
```

## .writeXYZ()
The **method** to write XYZ file.
* Parameters:

	| Inputs-Compulsory | Type    | Description |
	|:------------------|:-------:|:------------|
	| fileName   		| `string`| the name of XYZ file |

	| Inputs-Optional   | Default/Possible 	| Type    | Description |
	|:------------------|:------------------|:-------:|:------------|
	| column        	| ['xu','yu','zu']	| `list` 1xN| list contains columns to be written  |
	| fmtSTR		 		| '%.6f'   			| `string`| string format for output values |

	| Outputs 			| Type    | Description |
	|:------------------|:-------:|:------------|
	| 					| '.cfg'  | the DUMP file |

* Usage:
```python
	da.writeXYZ('test.xyz')
```

## .writePDB()
The **method** to write PDB file.
* Parameters:

	| Inputs-Compulsory | Type    | Description |
	|:------------------|:-------:|:------------|
	| fileName   		| `string`| the name of PDB file |

	| Inputs-Optional   | Default/Possible 	| Type    | Description |
	|:------------------|:------------------|:-------:|:------------|
	| fmtSTR		 		| '%.6f'   			| `string`| string format for output values |

	| Outputs 			| Type    | Description |
	|:------------------|:-------:|:------------|
	| 					| '.pdb'  | the PDB file |

* Usage:
```python
	da.writePDB('test.pdb')
```


