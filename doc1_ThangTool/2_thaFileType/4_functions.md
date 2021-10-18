---
sort: 3
---

# *functions* 

The functions to read data from text files.

REFs:


## .write_scirpt()
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

## .Plot_Param()
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

