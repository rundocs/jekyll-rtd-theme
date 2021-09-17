---
sort: 1
---

# *class* basis_transform

For tranformation/rotation a vector from an oldAxis to a newAxis, we can express a rotation using either [direction-cosine-matrix](https://en.wikiversity.org/wiki/PlanetPhysics/Direction_Cosine_Matrix) (DCM) or by [Euler-angles](https://en.wikipedia.org/wiki/Euler_angles) ($$(\phi,\theta,\psi)$$ or $$(\alpha,\beta,\gamma)$$). <br>
```note DCM
```
- DCM between 2 basises is unique. Assume a new basis x’y’z’ and old axes xyz, the DCM is defined as: [Bower 2009, p711](http://solidmechanics.org/Text/AppendixA/AppendixA.php)

	$$
	\begin{aligned}
		\mathbf{R} = \left( \begin{array}{ccc}
			R_{11} & R_{12} & R_{13} \\
			R_{21} & R_{22} & R_{23} \\
			R_{31} & R_{32} & R_{33} 
		\end{array} \right)
		= \left( \begin{array}{ccc}
			cos(\theta_{x',x}) & cos(\theta_{x',y}) & cos(\theta_{x',z}) \\
			cos(\theta_{y',x}) & cos(\theta_{y',y}) & cos(\theta_{y',z}) \\
			cos(\theta_{z',x}) & cos(\theta_{z',y}) & cos(\theta_{z',z}) 
		\end{array} \right)
	\end{aligned}
	$$
- but there are several posibilities of Euler-angles which classed into 2 types: **Proper Euler angles** and **Tait–Bryan angles**
- DCM can be decomposed as a product of three elemental rotation matrices of 3 Euler-angles in a **specific order**. The widely used convention in Physic is ZXZ [intrinsic rotations](https://en.wikipedia.org/wiki/Euler_angles#Conventions_by_intrinsic_rotations).
- This class implemented the **Proper Euler angles** using the convension $$Z(\phi)X(\theta)Z(\psi)$$ which the Euler-angles is computed from DCM as:

	$$
	\begin{aligned}
		\phi &= \arctan (R_{13}/R_{23}) \\
		\theta &= \arccos (R_{33}) \\
		\psi &= -\arctan (R_{31}/R_{32})
	\end{aligned}
	$$
- This convension is also be used in [wolfram](https://mathworld.wolfram.com/EulerAngles.html) and [PLUMED](https://www.plumed.org/doc-v2.7/user-doc/html/_f_c_c_u_b_i_c.html). For the derivation of the relation between DCM and Euler-angles, see Note: [Enhanced_Sampling_methods](https://thangckt.github.io/note/).

REFs:
1. [Bower, Allan F. Applied Mechanics of Solids. CRC Press, 2009. page 711](http://solidmechanics.org/Text/AppendixA/AppendixA.php).
2. [https://link.aps.org/doi/10.1103/PhysRevB.92.180102](https://link.aps.org/doi/10.1103/PhysRevB.92.180102)
3. [https://en.wikipedia.org/wiki/Euler_angles](https://en.wikipedia.org/wiki/Euler_angles)


## Construction:
* Inputs Compulsory: 
* Inputs Optional: 
	- Eold: 3x3 `array/list`, contains 3 mutully orthotropic unit vectors of the OLD basis 
	- Enew: 3x3 `array/list`, contains 3 mutully orthotropic unit vectors of the NEW basis
* Usage: 
```python
	oldAxis = [[1, 0, 0], [0, 1, 0], [0, 0, 1]]
	newAxis = [[1, -1, 0], [1, 1, -2], [1, 1, 1,]]
	BT = thaTool.basis_transform(Eold=oldAxis, Enew=newAxis)
```
* **Attributes:**
	- Eold: 3x3 `array/list`, contains 3 mutully orthotropic unit vectors of the OLD basis 
	- Enew: 3x3 `array/list`, contains 3 mutully orthotropic unit vectors of the NEW basis

## .direction_cosine_matrix()
The `method` to calculate direction-cosine-matrix (DCM) between 2 coordinates systems.
* Inputs Compulsory: 
* Inputs Optional:
* Outputs: 
	- Q: 3x3 `array`, the rotation matrix or matrix of direction cosines
* Usage: 
```python
	BT = thaTool.basis_transform(Eold=oldAxis, Enew=newAxis)
	Q = BT.direction_cosine_matrix()
```

## .EulerAngle()
The `method` to alculate Euler Angles (EA) between 2 coordinates systems (intrinsic ZXZ proper Euler angles).
* Inputs Compulsory: 
* Inputs Optional:
	- unit='rad': 'rad', 'deg'      (default is rad)
* Outputs: 
	- Angle: 1x3 `array` (Phi,Theta,Psi)
* Usage: 
```python
	BT = thaTool.basis_transform(Eold=oldAxis, Enew=newAxis) 
	phi,theta,psi = BT.EulerAngle(unit='deg')
```

## .rotate_3d(points)
The `method` to rotate a set of points (or set of vectors) from a OLD-coords to NEW-coords
* Inputs Compulsory:
	- points: Nx3 `array`, contain coords in OLD coordinates systems
* Inputs Optional:
* Output:
	- points: Nx3 `array`, contain coords in NEW coordinates systems
* Usage: 
```python
	BT = thaTool.basis_transform(Eold=oldAxis, Enew=newAxis) 
	newP = BT.rotate_3d(P)
```

