#


## LmpFrame
[source](https://github.com/thangckt/thatool\blob\main\./thatool/filetool/LmpFrame.py\#L17)
```python 
LmpFrame(
   **kwargs
)
```


---
Create an Object of single-FRAME of LAMMPS (use for both DATA/DUMP files)
This class implemented several ways to create `lmpFRAME` object <br>
- create an empty data object
- createFRAME object with input data
- read from DUMP file 
- read from DATA file 
- read frome PDB file 


**Methods:**


### .createFRAME
[source](https://github.com/thangckt/thatool\blob\main\./thatool/filetool/LmpFrame.py\#L120)
```python
.createFRAME(
   DataFrame, **kwargs
)
```

---
The **method** create new FRAME object with input data.
* Inputs-Compulsory: <br>
- DataFrame                     |`DataFrame`| pd.DataFrame of input data
---
        - box_angle = [0,0,0]        |`array` `list`1x3| option to input box_angle
        - .atom  |`DataFrame`| pd.DataFrame contains positions and properties of configuration
        da.createFRAME(DataFrame=df)

### .readDUMP
[source](https://github.com/thangckt/thatool\blob\main\./thatool/filetool/LmpFrame.py\#L148)
```python
.readDUMP(
   file_name
)
```

---
The **method** create FRAME object by reading DUMP file.
* Inputs-Compulsory: <br>
- file_name                     | `string` | the name of DUMP file 
---
* Inputs-Optional: <br> 
        - .atom  |`DataFrame`| pd.DataFrame contains positions and properties of configuration
        da.readDUMP('dump.cfg')

NOTEs: use list comprehension to get better performance

### .readDATA
[source](https://github.com/thangckt/thatool\blob\main\./thatool/filetool/LmpFrame.py\#L203)
```python
.readDATA(
   file_name, **kwargs
)
```

---
The **method** create FRAME object by reading DATA file.
The style of atomistic system.The format of "data file" depend on the definition of ["atom_style"](https://lammps.sandia.gov/doc/atom_style.html). See [list of atom_style format](https://lammps.sandia.gov/doc/read_data.html#description)
- atomic      : atom-ID atom-type x y z
- charge      : atom-ID atom-type q x y z
- molecular   : atom-ID molecule-ID atom-type x y z
- full        : atom-ID molecule-ID atom-type q x y z
---
        - file_name                     | `string` | the name of DATA file 
        - atom_style: will be auto dectected
        - .atom  |`DataFrame`| pd.DataFrame contains positions and properties of configuration
        da.readDUMP('mydata.dat', atom_style='atomic', iFlag=False)
###
                - np.char.split(C[index1:idx_vel]).tolist()      return list-of-lists (2d list)

### .readPDB
[source](https://github.com/thangckt/thatool\blob\main\./thatool/filetool/LmpFrame.py\#L415)
```python
.readPDB(
   file_name
)
```

---
The **method** create FRAME object by reading PDB file.
* Inputs-Compulsory: <br>
- file_name                     | `string` | the name of PDB file 
---
* Inputs-Optional: <br> 
        - .atom['beta'] |`float`|
        da.readPDB('dump.pdb')

### .writeDUMP
[source](https://github.com/thangckt/thatool\blob\main\./thatool/filetool/LmpFrame.py\#L469)
```python
.writeDUMP(
   file_name, **kwargs
)
```

---
The **method** to write DUMP file.
* Inputs-Compulsory: <br>
- file_name                     | `string` | the name of DUMP file 
---
        - FMTstr        = '%.6f'        | `string` | string format for output values 
        - file                                  | `*.cfg`  | the DUMP file 
        da.writeDUMP('test.cfg', column=['id','type','x','y','z'], FMTstr='%.4f')

### .writeDATA
[source](https://github.com/thangckt/thatool\blob\main\./thatool/filetool/LmpFrame.py\#L535)
```python
.writeDATA(
   file_name, **kwargs
)
```

---
The **method** to write DATA file.
* Inputs-Compulsory: <br>
- file_name                     | `string` | the name of DATA file 
---
        - comment   = ''        | `string` | the comment 
        - file                                  | `*.dat`  | the DATA file 
        da.writeDATA('test.dat', atom_style='atomic', iFlag=False, vel=False, FMT='%.4f')

### .writeXYZ
[source](https://github.com/thangckt/thatool\blob\main\./thatool/filetool/LmpFrame.py\#L718)
```python
.writeXYZ(
   file_name, **kwargs
)
```

---
The `method` to write XYZ file.
* Inputs-Compulsory: <br>
- file_name                     | `string` | the name of XYZ file 
---
        - FMTstr        = '%.6f'        | `string` | string format for output values 
        - file                                  | `*.cfg`  | the XYZ file 
        da.writeXYZ('test.xyz')

### .writePDB
[source](https://github.com/thangckt/thatool\blob\main\./thatool/filetool/LmpFrame.py\#L765)
```python
.writePDB(
   file_name, **kwargs
)
```

---
The **method** to write PDB file; https://zhanggroup.org/SSIPe/pdb_atom_format.html
* Inputs-Compulsory: <br>
- file_name                     | `string` | the name of XYZ file 
---
        - writeBox = False : write box or not
        - file                                  | `*.pdb`  | the PDB file 
        da.writePDB('test.pdb')

### .addColumn
[source](https://github.com/thangckt/thatool\blob\main\./thatool/filetool/LmpFrame.py\#L873)
```python
.addColumn(
   data, **kwargs
)
```

---
The **method** to add new columns to da.atom.
* Inputs-Compulsory: <br>
- data                          | `DataFrame` `Series` `List` | Nxm data of new columns
---
        - replace       = False | `boolean`| replace column if existed
        - .atom  |`DataFrame`| pd.DataFrame contains positions and properties of configuration
        da.addColumn(df, myColumn=['col1','col2'], replace=True)

### .deleteColumn
[source](https://github.com/thangckt/thatool\blob\main\./thatool/filetool/LmpFrame.py\#L916)
```python
.deleteColumn(
   delColumns
)
```

---
The **method** to delete columns from da.atom.
* Inputs-Compulsory: <br>
- delColumns          | `list-string` | 1xN list contains names of columns to be deleted
---
* Inputs-Optional: <br> 
        - .atom  |`DataFrame`| pd.DataFrame contains positions and properties of configuration
        da.deleteColumn(delColumns=['col1','col2'])

### .set_mass
[source](https://github.com/thangckt/thatool\blob\main\./thatool/filetool/LmpFrame.py\#L932)
```python
.set_mass(
   element_dict
)
```

---
The **method** to set masses of atoms in system.
difine element_dict with 2 keys: 'type', 'atom_symbol'
element_dict = {'type':[1,2,3], 'atom_symbol'=['C','H','N']}
* Inputs-Compulsory: <br>
- element_dict={'type': list_values, 'atom_symbol':list_values}   | `dict` | 1xN list contains names of columns to be deleted
---
* Inputs-Optional: <br> 
        - .mass  |`DataFrame`| pd.DataFrame contains positions and properties of configuration
        da.set_mass(element_dict={'type':[1,2,3], 'atom_symbol':['C','H','N']})

### .combine_frame
[source](https://github.com/thangckt/thatool\blob\main\./thatool/filetool/LmpFrame.py\#L964)
```python
.combine_frame(
   LmpFrame, merge_type = False, alignment = 'comXYZ', shift_XYZ = [0, 0, 0],
   separate_XYZ = [0, 0, 0], merge_box = True, use_box = 'box1'
)
```

---
The **method** to combine 2 Lammps Frames.


**Args**

* **LmpFrame** (LmpFrame Obj) : an Object of LmpFrame
* **merge_type** (bool, optional) : merge the same type in 2 LmpFrame. Defaults to False.
* **alignment** (str, optional) : choose how to align 2 frame. Defaults to 'comXYZ'.
        + 'comXYZ': align based on COM
        + 'minXYZ': align based on left corner
        + 'maxXYZ': align based on right corner
* **shift_XYZ** (list, optional) : shift a distance from COM aligment. Defaults to [0,0,0].    
* **separate_XYZ** (list, optional) : Separate 2 frame with a specific value. Defaults to [0,0,0].
* **merge_box** (bool, optional) : choose to merge box or not. Defaults to True.
* **use_box** (str, optional) : be used as the box size if merge_box=False. Defaults to 'box1'.

---
Return:
        Update LmpFrame da1


**Raises**

* **ValueError**  : _description_
* **Exception**  : _description_

---
        da1.combine_frame(da2)

NOTEs: cannot combine box_angle

### .unwrap_coord_DATA
[source](https://github.com/thangckt/thatool\blob\main\./thatool/filetool/LmpFrame.py\#L1135)
```python
.unwrap_coord_DATA(
   iFlag = ['x', 'y', 'z'], atom_types = []
)
```

---
The **method** to upwrap coords in DATA file.
* Inputs-Compulsory: <br>
* Inputs-Optional: <br> 
- iFlag=['x','y','z']: image Flags in data file
- type=[]: just unwrap some atom-types, default = all-types
---
        - new Object of LmpFrame
* Usage: <br> 
* NOTEs: cannot unwrap_coord_data if iFlags are not available.

### .change_atom_type
[source](https://github.com/thangckt/thatool\blob\main\./thatool/filetool/LmpFrame.py\#L1172)
```python
.change_atom_type(
   old_type, new_type
)
```

---
The **method** to change types of atoms in system.
* Inputs-Compulsory: <br>
- old_type=[1,2,3]: a list
- new_type=2 :      a scalar (int)
---
* Inputs-Optional: <br> 

        da.chage_atom_type([1,2,3], 2)
