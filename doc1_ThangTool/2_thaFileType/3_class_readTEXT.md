---
sort: 3
---

# *class* readTEXT

This class contains functions to read data from text file.

REFs:


## Initilization
This is a container class


## .logMFD()
The **method** create new FRAME object with input data.
* Inputs-Compulsory: <br>
	- DataFrame			|`DataFrame`| pd.DataFrame of input data
* Inputs-Optional: <br> 
	- box = [[0,1],[0,1],[0,1]]	|`array` `list`3x2| option to input boxSize
	- boxAngle = [0,0,0]        |`array` `list`1x3| option to input boxAngle
* Outputs: <br> 
	- .frame  |`DataFrame`| pd.DataFrame contains positions and properties of configuration
* Usage: <br> 
```python
	da = thaFileType.lmpFRAME()
	da.createFRAME(DataFrame=df)
```

## .misValueMatrixData()
The **method** create FRAME object by reading DUMP file.
* Inputs-Compulsory: <br>
	- fileName   			| `string` | the name of DUMP file 
* Inputs-Optional: <br> 
* Outputs: <br> 
	- .frame  |`DataFrame`| pd.DataFrame contains positions and properties of configuration
* Usage: <br> 
```python
	da = thaFileType.lmpFRAME()
	da.readDUMP('dump.cfg')
```

## .MatrixData()
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
	- .frame  |`DataFrame`| pd.DataFrame contains positions and properties of configuration
* Usage: <br> 
```python
	da = thaFileType.lmpFRAME()
	da.readDATA('mydata.dat', atom_style='atomic', nFlag=False)
```

## .LammpsVAR()
The **method** create FRAME object by reading PDB file.
* Inputs-Compulsory: <br>
	- fileName   			| `string` | the name of PDB file 
* Inputs-Optional: <br> 
* Outputs: <br> 
	- .frame  |`DataFrame`| pd.DataFrame contains positions and properties of configuration
	- .frame['record_name'] |`string`|
	- .frame['element'] |'string'| same as column 'type' in DUMP format
	- .frame['residue_name'] |`string`|
	- .frame['residue_num'] |`integer`|
	- .frame['chain'] |`string`|
	- .frame['occupancy'] |`float`|
	- .frame['beta'] |`float`|
* Usage: <br> 
```python
	da = thaFileType.lmpFRAME()
	da.readPDB('dump.pdb')
```

## .PlumedVAR()
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

## .PlumedBLOCK()
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

## .LINE()
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

