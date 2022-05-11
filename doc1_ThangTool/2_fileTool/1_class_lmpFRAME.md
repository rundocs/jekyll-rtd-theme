---
sort: 1
---

# *class* LmpFrame
[source](https://hide_url.com\blob\main\../thatool/filetool/LmpFrame.py\#L17)
```python
LmpFrame(
   dump_file = None, data_file = None, atom_style = 'auto', pdb_file = None,
   xyz_file = None, from_df = None
)
```


---
Create an Object of single-FRAME of LAMMPS (use for both DATA/DUMP files). The docstring is in Google-style.

This class create a data-object (single configuration) for the analysis of computing data from LAMMPS. The file formats implemented in this class
- [LAMMPS DATA Format](https://docs.lammps.org/2001/data_format.html)
- [LAMMPS DUMP Format](https://docs.lammps.org/dump.html)
- [PDB format](https://ftp.wwpdb.org/pub/pdb/doc/format_descriptions/Format_v33_Letter.pdf)
- [XYZ format](https://www.cgl.ucsf.edu/chimera/docs/UsersGuide/xyz.html)

![image](https://icme.hpc.msstate.edu/mediawiki/images/e/e7/4kovito.gif)

---
This class implemented several ways to create `lmpFRAME` object
- create an empty data object
- createFRAME object with input data
- read from DUMP file
- read from DATA file
- read frome PDB file


**Args**

* **dump_file** (str, optional) : filename of DUMP file. Defaults to None.
* **data_file** (str, optional) : filename of DATA file. Defaults to None.
* **pdb_file** (str, optional) : filename of PBD file. Defaults to None.
* **xyz_file** (str, optional) : filename of XYZ file. Defaults to None.
* **from_df** (pd.DataFrame, optional) : create FRAME from data. Defaults to None.


**Attributes**

* **file_name** (str) : name of input file
* **timestep** (int) : the timestep of configuration
* **box** (3x2 np.array) : the box size
* **box_angle** (1x3 np.array) : the box angle
atom(pd.DataFrame) DataFrame of per-atom values
prop_key(list) column-names of properties
mass(pd.DataFrame) DataFrame of per-type masses
FMTstr(str) default format for float numbers, don't use %g because it will lost precision


**Examples**

```python
# empty object
da = thatool.lmpFRAME()
# oject with input data
da = thatool.lmpFRAME(from_df=df)
# from DUMP file
da = thatool.lmpFRAME(dump_file='test.cfg')
# from DATA file
da = thatool.lmpFRAME(data_file='mydata.dat')
# from PDB file
da = thatool.lmpFRAME(pdb_file='test.pdb')
```

---
.. _Use chain mutator calls
        https://stackoverflow.com/questions/36484000/use-an-object-method-with-the-initializer-same-line


**Methods:**


## .createFRAME
[source](https://hide_url.com\blob\main\../thatool/filetool/LmpFrame.py\#L134)
```python
.createFRAME(
   DataFrame, box = None, box_angle = None## .
)
```

---
The method to create new FRAME object with input data.


**Args**

* **DataFrame** (pd.DataFrame) :  of input data
* **box** (3x2 np.array, optional) : option to input boxSize. Defaults to None.
* **box_angle** (1x3 np.array, optional) : option to input box_angle. Defaults to None.


**Returns**

* **Obj** (LmpFrame) : update FRAME


**Examples**

```python
        da = filetool.lmpFRAME()
        da.createFRAME(DataFrame=df)
        # or
        da = filetool.lmpFRAME(from_df=df)
```

## .readDUMP
[source](https://hide_url.com\blob\main\../thatool/filetool/LmpFrame.py\#L171)
```python
.readDUMP(
   file_name
)
```

---
The method to create FRAME object by reading DUMP file.


**Args**

* **file_name** (str) : name of input file


**Returns**

* **Obj** (LmpFrame) : update FRAME


**Examples**

```python
        da = filetool.lmpFRAME()
        da.readDUMP(DataFrame=df)
        # or
        da = filetool.lmpFRAME(dump_file='mydata.cfg')
```
---
        use list comprehension in code to get better performance

## .readDATA
[source](https://hide_url.com\blob\main\../thatool/filetool/LmpFrame.py\#L234)
```python
.readDATA(
   file_name, atom_style = 'auto'
)
```

---
The method to create FRAME object by reading DATA file.
The style of atomistic system.The format of "data file" depend on the definition of ["atom_style"](https://lammps.sandia.gov/doc/atom_style.html).
See [list of atom_style format](https://lammps.sandia.gov/doc/read_data.html#description). Can be detected automatically, or explicitly setting
- atomic      : atom-ID atom-type x y z
- charge      : atom-ID atom-type q x y z
- molecular   : atom-ID molecule-ID atom-type x y z
- full        : atom-ID molecule-ID atom-type q x y z


**Args**

* **file_name** (str) : name of input file
* **atom_style** (str, optional) : option to choose atom_style. Defaults to 'auto'.


**Returns**

* **Obj** (LmpFrame) : update FRAME


**Examples**

```python
        da = filetool.lmpFRAME(data_file='mydata.dat')
```

---
        ```

## .readPDB
[source](https://hide_url.com\blob\main\../thatool/filetool/LmpFrame.py\#L449)
```python
.readPDB(
   file_name
)
```

---
The method to create FRAME object by reading PDB file.


**Args**

* **file_name** (str) : name of input file


**Returns**

* **Obj** (LmpFrame) : update FRAME
        record_name(str)
        atom_symbol(str): same as column 'type' in DUMP format
        residue_name(str)
        residue_id(int)
        chain(str)
        occupancy(float)
        beta(float)


**Examples**

```python
da = filetool.lmpFRAME(pdb_file='mydata.pdb')
```

## .readXYZ
[source](https://hide_url.com\blob\main\../thatool/filetool/LmpFrame.py\#L507)
```python
.readXYZ(
   file_name
)
```

---
The method to create FRAME object by reading XYZ file.


**Args**

* **file_name** (str) : name of input file


**Returns**

* **Obj** (LmpFrame) : update FRAME


**Examples**

```python
da = filetool.lmpFRAME(pdb_file='mydata.pdb')
```

## .writeDUMP
[source](https://hide_url.com\blob\main\../thatool/filetool/LmpFrame.py\#L525)
```python
.writeDUMP(
   file_name, column = None, FMTstr = None
)
```

---
The method to write DUMP file.


**Args**

* **file_name** (str) : name of input file
* **column** (list-of-str, optional) : contains columns to be written. Defaults to None, mean all columns will be written
* **FMTstr** (str, optional) : string format for output values. Defaults to None, mean use self.FMTstr


**Returns**

* **file**  : the DUMP file


**Examples**

```python
da.writeDUMP('test.cfg', column=['id','type','x','y','z'], FMTstr='%.4f')
```

## .writeDATA
[source](https://hide_url.com\blob\main\../thatool/filetool/LmpFrame.py\#L594)
```python
.writeDATA(
   file_name, atom_style = 'atomic', vel = False, iFlag = False, comment = '',
   FMTstr = None
)
```

---
The method to write DATA file.


**Args**

* **file_name** (str) : name of input file
* **atom_style** (str, optional) : the style of atomistic system, can be 'atomic', 'charge', 'molecular', 'full' . Defaults to 'atomic'.
* **vel** (bool, optional) : to write Velocity values. Defaults to False.
* **iFlag** (bool, optional) : to write iFlag tag. Defaults to False.
* **comment** (str, optional) : comment on second line in DATA file. Defaults to ''.
* **FMTstr** (str, optional) : string format for output values. Defaults to None, mean use self.FMTstr


**Returns**

* **file**  : the DUMP file


**Examples**

```python
da.writeDATA('test.dat', atom_style='atomic', iFlag=False, vel=False, FMT='%.4f')
```

## .writeXYZ
[source](https://hide_url.com\blob\main\../thatool/filetool/LmpFrame.py\#L773)
```python
.writeXYZ(
   file_name, column = ['X', 'xu', 'yu', 'zu'], FMTstr = None
)
```

---
The `method` to write XYZ file.


**Args**

* **file_name** (str) : name of input file
* **column** (list-of-str, optional) : contains columns to be written. Defaults to ['X','xu','yu','zu']
* **FMTstr** (str, optional) : string format for output values. Defaults to None, mean use self.FMTstr


**Returns**

* **file**  : the XYZ file


**Examples**

```python
da.writeXYZ('test.xyz')
```

## .writePDB
[source](https://hide_url.com\blob\main\../thatool/filetool/LmpFrame.py\#L824)
```python
.writePDB(
   file_name, writeBox = False
)
```

---
The method to write [PDB file](https://zhanggroup.org/SSIPe/pdb_atom_format.html)


**Args**

* **file_name** (str) : name of input file
* **writeBox** (bool, optional) : write box or not. Defaults to False.


**Returns**

* **file**  : the PDB file


**Examples**

```python
da.writePDB('test.pdb')
```

## .addColumn
[source](https://hide_url.com\blob\main\../thatool/filetool/LmpFrame.py\#L931)
```python
.addColumn(
   data, newColumn = None, replace = False
)
```

---
The method to add new columns to da.atom.


**Args**

* **data** (pd.DataFrame, pd.Series, list) : Nxm data of new columns
* **newColumn** (list) : 1xN list contains names of columns. Default to None, mean it will take columnNames from DataFrame
* **replace** (bool, optional) : replace column if existed. Defaults to False.


**Returns**

* **Obj** (LmpFrame) : Update da.atom


**Examples**

```python
da.addColumn(df, myColumn=['col1','col2'], replace=True)
```

## .deleteColumn
[source](https://hide_url.com\blob\main\../thatool/filetool/LmpFrame.py\#L971)
```python
.deleteColumn(
   delColumns
)
```

---
The method to delete columns from da.atom.


**Args**

* **data** (pd.DataFrame, pd.Series, list) : Nxm data of new columns
* **delColumns** (list) : 1xN list contains names of columns to be deleted.


**Returns**

* **Obj** (LmpFrame) : Update da.atom


**Examples**

```python
da.deleteColumn(delColumns=['col1','col2'])
```

## .set_mass
[source](https://hide_url.com\blob\main\../thatool/filetool/LmpFrame.py\#L992)
```python
.set_mass(
   element_dict
)
```

---
The method to set masses of atoms in system. Before use it, need to define element_dict with 2 keys: 'type', 'atom_symbol'
element_dict={'type': list_values, 'atom_symbol':list_values}


**Args**

* **element_dict** (dict) : a dict to define atom-types and atom-symbols.


**Returns**

* **Obj** (LmpFrame) : Update da.atom


**Examples**

```python
da.set_mass(element_dict={'type':[1,2,3], 'atom_symbol':['C','H','N']})
```

## .combine_frame
[source](https://hide_url.com\blob\main\../thatool/filetool/LmpFrame.py\#L1027)
```python
.combine_frame(
   LmpFrame, merge_type = False, alignment = 'comXYZ', shift_XYZ = [0, 0, 0],
   separate_XYZ = [0, 0, 0], merge_box = True, use_box = 'box1'
)
```

---
The method to combine 2 Lammps Frames.


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

        ```

TO DO:
        combine box_angle

## .unwrap_coord_DATA
[source](https://hide_url.com\blob\main\../thatool/filetool/LmpFrame.py\#L1197)
```python
.unwrap_coord_DATA(
   iFlag = ['x', 'y', 'z'], atom_types = []
)
```

---
The method to upwrap coords in DATA file.


**Args**

* **iFlag** (list, optional) : image Flags in data file. Defaults to ['x','y','z'].
* **atom_types** (list, optional) : just unwrap some atom-types. Defaults to [], mean unwrap all-types.


**Returns**

* **Obj** (LmpFrame) : update FRAME

---
        cannot unwrap_coord_data if iFlags are not available.

## .change_atom_type
[source](https://hide_url.com\blob\main\../thatool/filetool/LmpFrame.py\#L1237)
```python
.change_atom_type(
   old_type, new_type
)
```

---
The method to change types of atoms in system.



**Args**

* **old_type** (list) : a list of old-types.
* **new_type** (int) :  one new-type.


**Returns**

* **Obj** (LmpFrame) : update FRAME


**Examples**

```python
da.chage_atom_type([1,2,3], 2)
```
