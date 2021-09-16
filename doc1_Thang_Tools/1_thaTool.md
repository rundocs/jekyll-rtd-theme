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

------
## class basis_transform
------
For tranformation/rotation a vector from an oldAxis to a newAxis, we can express a rotation using [direction-cosines-matrix](https://en.wikiversity.org/wiki/PlanetPhysics/Direction_Cosine_Matrix) (DCM) or by [Euler-angles](https://en.wikipedia.org/wiki/Euler_angles) (Phi,Theta,Psi). <br>
```note
- DCM between 2 basis is unique. Assume a new basis x’y’z’, an old axes xyz, the DCM is: [Bower 2009, p711](http://solidmechanics.org/Text/AppendixA/AppendixA.php)
$$\begin{aligned}
	\mathbf{R} = \left( \begin{array}{ccc}
		R_{11} & R_{12} & R_{13} \\
		R_{21} & R_{22} & R_{23} \\
		R_{31} & R_{32} & R_{33} 
	\end{array} \right)
	= \left( \begin{array}{ccc}
		cos(\theta_{x',x}) & cos(\theta_{x',y}) & cos(\theta_{x',z}) \\
		cos(\theta_{y',x}) & cos(\theta_{y',y}) & cos(\theta_{y',z}) \\
		cos(\theta_{z',x}) & cos(\theta_{z',y}) & cos(\theta_{z',z}) \\
	\end{array} \right)
\end{aligned}$$

- but there are several posibility of Euler-angles which classed into 2 types: **Proper Euler angles** and **Tait–Bryan angles**
- DCM can be decomposed as a product of three elemental rotation matrices of 3 Euler-angles, with a **specific order**. The widely used convension in Physic is ZXZ [intrinsic rotations](https://en.wikipedia.org/wiki/Euler_angles#Conventions_by_intrinsic_rotations).
- The implementation in this class use the convension $Z(\phi)X(\theta)Z(\psi)$ which the Euler-angles is computed from DCM as:
$$\begin{aligned}
	\phi = \arctan (R_{13}/R_{23} \\
	\theta = \arccos (R_{33} \\
	\psi = -\arctan (R_{31}/R_{32}
\end{aligned}$$
- For fully derivation of the relation between DCM and Euler-angles, see the Enhanced_Sampling_methods note.
REFs:
1. [Bower, Allan F. Applied Mechanics of Solids. CRC Press, 2009. page 711](http://solidmechanics.org/Text/AppendixA/AppendixA.php).
2. https://link.aps.org/doi/10.1103/PhysRevB.92.180102.
3. https://en.wikipedia.org/wiki/Euler_angles.
```

---
### parameters:
* Inputs: (optional)
  - Eold: 3x3 array/list, contains 3 mutully orthotropic unit vectors of the OLD basis 
  - Enew: 3x3 array/list, contains 3 mutully orthotropic unit vectors of the NEW basis
* Usage: BT = thaTool.basis_transform(Eold=oldAxis, Enew=newAxis)

### basis_transform.direct_cosine_matrix()
Calculate direction-cosines-matrix (DCM) between 2 coordinates systems.
* Inputs: None
* Output: 
  - Q: 3x3 array, the rotation matrix or matrix of direction cosines
* Usage: Q = basis_transform.direct_cosine_matrix()


