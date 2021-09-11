---
sort: 1
---

# thaTool Module

# class SwitchFunc

## 1. class RATIONAL:
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

