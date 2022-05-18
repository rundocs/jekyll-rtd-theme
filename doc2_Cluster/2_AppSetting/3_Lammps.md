---
sort: 3
---

# LAMMPS
Some techniques using Lammps

[Manual ppt](https://www.osti.gov/servlets/purl/1563110)

## Compute Coulombic force in Non-periodic box

```note
Just can be used with Kspace_style MSM
```

Compute with shrinkwap boundaries
- read data with fix boundary `boundary p p f`
- use "run 0" command to update current data
- use `change_box all boundary p p s` to switch switch to shrinkwap

References:
- https://tinyurl.com/y42bqz2v
