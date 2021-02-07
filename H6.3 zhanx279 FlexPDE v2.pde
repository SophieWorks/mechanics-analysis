TITLE 'H6.3'     { the problem identification }
COORDINATES cartesian3  { coordinate system, 1D,2D,3D, etc }
VARIABLES        { system variables }
u
v
w
! SELECT         { method controls }
DEFINITIONS    { parameter definitions }
mag=100
Lx = 0.1
Ly =3
Lz = 0.1

E = 0.5e9
nu = .25

ex = dx(u)
ey = dy(v)
ez = dz(w)

C11 = E/((1+nu)*(1-2*nu))*(1-nu)
C12 = E/((1+nu)*(1-2*nu))*nu
C13 =C12
C21 =C12
C22 = C11
C23 = C12
C31 = C12
C32 = C12
C33 = C11

sx = C11*ex + C12*ey+C13*ez
sy = C21*ex + C22*ey+C23*ez
sz = C31*ex + C32*ey+C33*ez

LxNew = val(Lx+u,Lx,Ly,Lz)
LyNew = val(Ly+v,Lx,Ly,Lz)
LzNew = val(Lz+w,Lx,Ly,Lz)
VolOriginal =Lx*Ly*Lz
VolNew = LxNew*LyNew*LzNew
VolChange = VolNew-VolOriginal

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

  REGION 1       { For each material region }
    START(0,0)   { Walk the domain boundary }
	value(v) = 0	    LINE TO (Lx,0)  !y=0
	load(v) = 0 LINE TO (Lx,Ly)  !x=Lx
	load(v) = 224963.3605 LINE TO (0,Ly) !y=Ly 	
	load(v) = 0  value(u) = 0 	LINE TO CLOSE !x=0
! TIME 0 TO 1    { if time dependent }
MONITORS         { show progress }
PLOTS            { save result displays }
	grid(x+u*mag, y+v*mag,z+w*mag)
  CONTOUR(sz) on z = 0 painted

SUMMARY
report val(ex,.5*Lx,.5*Ly,.5*Lz)
report val(ey,.5*Lx,.5*Ly,.5*Lz)
report val(ez,.5*Lx,.5*Ly,.5*Lz)
report LxNew
report LyNew
report LzNew
report VolOriginal
report VolNew
report VolChange
END

