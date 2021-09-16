---
sort: 1
---

# thaTool Module

This modle contains several functions to handle some kinds of data.

## class SwitchFunc

### class RATIONAL:
Create an Object of SWITCHING FUNCTION
		* Attributes:
			swType       : (default='RATIONAL') Type of witching function, 
			r0, d0       : The r_0 parameter of the switching function
			n            : (default=6) The n parameter of the switching function    
			m            : (default=2*m) The m parameter of the switching function 
			Dmin, Dmax   : interval in which scaling take effect
			
		* Methods:
			fFunc    : compute & return value and derivation of sw function
			fDmax    : estimate value of Dmax
			
		Ex: sw = thaTool.SwitchFunc(r0=6.3, swType='RATIONAL', d0=0.0, n=10)


## class basis_transform
For tranformation/rotation a vector from an oldAxis to a newAxis, we can express a rotation using [direction-cosines-matrix](https://en.wikiversity.org/wiki/PlanetPhysics/Direction_Cosine_Matrix) (DCM) or [Euler-angles](https://en.wikipedia.org/wiki/Euler_angles) (Phi,Theta,Psi).
```note
	1. Bower, Allan F. Applied Mechanics of Solids. CRC Press, 2009. page 711.
	2. https://link.aps.org/doi/10.1103/PhysRevB.92.180102.
	3. https://en.wikipedia.org/wiki/Euler_angles.
```
---
### parameters:
	- Eold: 3x3 array/list, contains 3 mutully orthotropic unit vectors of the OLD basis 
	- Enew: 3x3 array/list, contains 3 mutully orthotropic unit vectors of the NEW basis
### basis_transform.direct_cosine_matrix()

2. Methods:
3. 

