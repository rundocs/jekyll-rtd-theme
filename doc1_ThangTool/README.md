---
sort: 1
---

# thang_tool

This section contains the docs for several in-house codes to handle some specific tasks.

Some of them are encapsulated into the `thatool` package.

```python
pip install -e .
```

![pic](https://upload.wikimedia.org/wikipedia/commons/thumb/8/85/Euler2a.gif/255px-Euler2a.gif)
<!-- ![pic](https://icme.hpc.msstate.edu/mediawiki/images/e/e7/4kovito.gif) -->
![pic](figure/hBN_PMMA.gif)



| | |
|-|-|
{% include list.liquid all=true %} |  <pre> ```
thatool
    │   data.py  
    │
    └───filetool
    │   │   define_script.py
    |   |   LmpFrame.py
    │   │   ...
    │   
    └───free_energy_cal
    │   │   Helmholtz_excess_UF.py
    │   |   replica_logPD_intergration.py
    │   │   ...
    └───modeling
    │   │   box_orientation.py
    │   |   crystal3D.py
    │   │   ...
    └───utils
    │   │   coord_rotation.py
    │   |   unit_convert.py
    │   │   ...
    |   
``` </pre>
