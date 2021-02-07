TITLE 'Normal Elasticity Snorlax Q'    
COORDINATES cartesian3  
VARIABLES        { system variables }
u !x
v !y 
w !z
! SELECT         { method controls }
DEFINITIONS    { parameter definitions }
ex = dx(u)
ey = dy(v)
ez = dz(w)

!Parameters
E=70e9
nu=0.3
Ws=1000
Lx = 4
Ly = 0.5
Lz = 0.5


C11 = E/((1+nu)*(1-2*nu))*(1-nu)
C12 = E/((1+nu)*(1-2*nu))*nu
C13 =C12
C21 =C12
C22 = C11
C23 = C12
C31 = C12
C32 = C12
C33 = C11
!Hoook
sx = C11*ex + C12*ey+C13*ez
sy = C21*ex + C22*ey+C23*ez
sz = C31*ex + C32*ey+C33*ez


! INITIAL VALUES
EQUATIONS        { PDE's, one for each variable }
u: dx(sx) = 0
v: dy(sy) = 0
w: dz(sz) = 0

EXTRUSION
surface 'bottom' z = 0
surface 'top' z = Lz

BOUNDARIES       { The domain definition }
surface 'bottom'
value(w)=0
surface 'top'
load(u)=0
		load(v)=0
		load(w)=0

  REGION 1       { For each material region }
    START(0,0)   
		load(u)=0
		value(v)=0
		load(w)=0
LINE TO (Lx,0)
		load(u)=Ws/(Lz)
		load(v)=0
		load(w)=0
LINE TO (Lx,Ly)
		load(u)=0
		load(v)=0
		load(w)=0
LINE TO (0,Ly)
		value(u)=0
		load(v)=0
		load(w)=0
LINE TO CLOSE

! TIME 0 TO 1    { if time dependent }
MONITORS         { show progress }
PLOTS            { save result displays }
	grid(x+u, y+v,z+w)
	grid(x+u*1000, y+v*1000,z+w*1000)
	contour(u) on surface z=0

SUMMARY
END



