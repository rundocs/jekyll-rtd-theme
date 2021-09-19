---
sort: 1
---

# *class* coord_transformation

For tranformation/rotation a vector from an old_orient ([coordinate sytem](https://en.wikipedia.org/wiki/Coordinate_system)) to a new_orient, we can express a rotation using either the [direction-cosine-matrix](https://en.wikiversity.org/wiki/PlanetPhysics/Direction_Cosine_Matrix) (DCM), a set of three angles ([Euler-angles](https://en.wikipedia.org/wiki/Euler_angles) $$(\phi,\theta,\psi)$$ or the Tait–Bryan angles (yaw, pitch, roll) $$(\alpha,\beta,\gamma)$$. Sometimes, Tait–Bryan angles are also called "Euler angles", then the former should be called *proper/classic Euler angles* (used in Physic and Algebra)) or the [Hamilton Quaternion](https://en.wikipedia.org/wiki/Quaternion) (Q). There are relations between DCM, Euler angles and Q [Henderson 1977](https://ntrs.nasa.gov/api/citations/19770019231/downloads/19770019231).<br>
	![pic](https://upload.wikimedia.org/wikipedia/commons/thumb/8/85/Euler2a.gif/255px-Euler2a.gif)
	![pic](https://upload.wikimedia.org/wikipedia/commons/thumb/4/4a/Intermediateframes.svg/225px-Intermediateframes.svg.png)

- DCM between a new basis XYZ and old basis xyz is defined as: ([Bower 2009, p711](http://solidmechanics.org/Text/AppendixA/AppendixA.php))

	$$
	\begin{aligned}
		\mathbf{R} = \left( \begin{array}{ccc}
			R_{11} & R_{12} & R_{13} \\
			R_{21} & R_{22} & R_{23} \\
			R_{31} & R_{32} & R_{33} 
		\end{array} \right)
		= \left( \begin{array}{ccc}
			cos(\theta_{X,x}) & cos(\theta_{X,y}) & cos(\theta_{X,z}) \\
			cos(\theta_{Y,x}) & cos(\theta_{Y,y}) & cos(\theta_{Y,z}) \\
			cos(\theta_{Z,x}) & cos(\theta_{Z,y}) & cos(\theta_{Z,z}) 
		\end{array} \right)
	\end{aligned}
	$$
- There are several posibilities of Euler-angles (Different authors may use different sets of rotation axes to define Euler angles, or different names for the same angles. Therefore, it's prerequisite to know what is their definition). 
- DCM can be decomposed as a product of three *elemental rotation matrices* of 3 Euler-angles in a *specific order*. There are 12 possible Euler angle sets using three rotations, which classed into 2 groups: 	
	- **Proper Euler angles** (z-x-z, x-y-x, y-z-y, z-y-z, x-z-x, y-x-y)
	- **Tait–Bryan angles** (x-y-z, y-z-x, z-x-y, x-z-y, z-y-x, y-x-z).
- The most commonly used convention in Physic is ZXZ, which is impelemented in this class to compute *classic Euler angles* (For the derivation of the relation between DCM and Euler-angles, see Note: [Enhanced_Sampling_methods](https://thangckt.github.io/note/))

	$$
	\begin{aligned}
		\mathbf{R} = Z(\phi)X(\theta)Z(\psi)
		= \left( \begin{array}{ccc}
			(c_\phi c_\psi - s_\phi c_\theta s_\psi) 		& (c_\phi s_\psi + s_\phi c_\theta c_\psi)	&  	s_\phi s_\theta \\
			(-s_\phi c_\psi - c_\phi c_\theta s_\psi ) 	& (-s_\phi s_\psi + c_\phi c_\theta c_\psi)	&  c_\phi s_\theta\\
			s_\theta c_\psi			  							        &  -s_\theta c_\psi							          	&  c_\theta\\
		\end{array} \right)
	\end{aligned}
	$$
- The classic Euler-angles is then computed from DCM as:

	$$
	\begin{aligned}
		\phi &= \arctan \left( \frac{R_{13}}{R_{23}} \right) \\
		\theta &= \arctan \left( \frac{\sqrt{1- R^2_{33} }}{R_{33}} \right) \\
		\psi &= \arctan \left( \frac{R_{31}}{-R_{32}} \right) 
	\end{aligned}
	$$
- This convension may also be used in [wolfram](https://mathworld.wolfram.com/EulerAngles.html) and [PLUMED](https://www.plumed.org/doc-v2.7/user-doc/html/_f_c_c_u_b_i_c.html)

REFs:
1. [Bower, Allan F. Applied Mechanics of Solids. CRC Press, 2009. page 711](http://solidmechanics.org/Text/AppendixA/AppendixA.php).
2. [https://en.wikipedia.org/wiki/Euler_angles](https://en.wikipedia.org/wiki/Euler_angles)
3. [Henderson, D. M. Euler angles, quaternions, and transformation matrices for space shuttle analysis, NASA, 1977](https://ntrs.nasa.gov/api/citations/19770019231/downloads/19770019231.pdf)


## Initilization
* Inputs Compulsory: 
* Inputs Optional: 
	- old_orient: 3x3 `array/list`, contains 3 mutully orthotropic unit vectors of the OLD basis 
	- new_orient: 3x3 `array/list`, contains 3 mutully orthotropic unit vectors of the NEW basis
* Usage: 
```python
	oldAxis = [[1, 0, 0], [0, 1, 0], [0, 0, 1]]
	newAxis = [[1, -1, 0], [1, 1, -2], [1, 1, 1,]]
	BT = thaTool.coord_transformation(old_orient=oldAxis, new_orient=newAxis)
```
* **Attributes:**
	- old_orient: 3x3 `array/list`, contains 3 mutully orthotropic unit vectors of the OLD basis 
	- new_orient: 3x3 `array/list`, contains 3 mutully orthotropic unit vectors of the NEW basis

## .direction_cosine_matrix()
The `method` to calculate direction-cosine-matrix (DCM) between 2 coordinates systems.
* Inputs Compulsory: 
* Inputs Optional:
* Outputs: 
	- DCM: 3x3 `array`, the rotation matrix or matrix of direction cosines
* Usage: 
```python
	BT = thaTool.coord_transformation(old_orient=oldAxis, new_orient=newAxis)
	R = BT.direction_cosine_matrix()
```

## .EulerAngle()
The `method` to alculate Euler Angles (EA) between 2 coordinates systems (intrinsic ZXZ proper Euler angles).
* Inputs Compulsory: 
* Inputs Optional:
	- unit='rad': 'rad' or 'deg'      (default is rad)
* Outputs: 
	- Angle: 1x3 `array` $$(\phi,\theta,\psi)$$
* Usage: 
```python
	BT = thaTool.coord_transformation(old_orient=oldAxis, new_orient=newAxis) 
	phi,theta,psi = BT.EulerAngle(unit='deg')
```

## .rotate_3d()
The `method` to rotate a set of points (or set of vectors) from a OLD-coords to NEW-coords
* Inputs Compulsory:
	- points: Nx3 `array`, contain coords in OLD coordinates systems
* Inputs Optional:
* Output:
	- points: Nx3 `array`, contain coords in NEW coordinates systems
* Usage: 
```python
	BT = thaTool.coord_transformation(old_orient=oldAxis, new_orient=newAxis) 
	newP = BT.rotate_3d(P)
```

