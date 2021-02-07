TITLE 'H7.1 b'     { the problem identification }
COORDINATES cartesian3  { coordinate system, 1D,2D,3D, etc }
VARIABLES        { system variables }
u
v
w
SELECT         { method controls }
ngrid =5
DEFINITIONS    { parameter definitions }
Lx = .03
Ly =.03
Lz =.03

mag =5e5



E = 1e9
nu = 0.4
G = E/(2*(1+nu))

C11 = E/((1+nu)*(1-2*nu))*(1-nu)
C12 = E/((1+nu)*(1-2*nu))*nu
C13 =C12
C21 =C12
C22 = C11
C23 = C12
C31 = C12
C32 = C12
C33 = C11



ex=dx(u)
ey=dy(v)
ez=dz(w)

gxy=(dx(v)+dy(u))
gyz=(dy(w)+dz(v))
gxz=(dz(u)+dx(w))


sx = C11*ex+C12*ey+C13*ez
sy = C21*ex+C22*ey+C23*ez
sz = C31*ex+C32*ey+C33*ez

sxy=G*gxy
sxz=G*gxz
syz=G*gyz

EQUATIONS        { PDE's, one for each variable }
u: dx(sx) + dy(sxy) + dz(sxz) = 0
v: dx(sxy) + dy(sy) + dz(syz) = 0
w: dx(sxz) + dy(syz) + dz(sz) = 0


EXTRUSION
surface 'bottom' z = 0 
surface 'top' z = Lz

BOUNDARIES       { The domain definition }
surface 'bottom'
load(u)=0
load(v)=0
load(w)=0
surface 'top'
load(u)=0
load(v)=0
load(w)=0

  REGION 1       { For each material region }
    START(0,0)   !y=0
load(u)=0
load(v)=0
load(w)=0
    LINE TO (Lx,0) !x = Lx
load(u)=-1e3
load(v)=0
load(w)=0
	LINE TO (Lx,Ly) !y= Ly
load(u)=0
load(w)=0
load(v)=0
 	LINE TO (0,Ly) !x = 0
value(u)=0
value(v)=0
value(w)=0
	LINE TO CLOSE
PLOTS            { save result displays }
  	contour(sz) on surface z = 0 painted
	grid(x+u*mag,y+v*mag,z+w*mag)
summary
 report val(u, Lx,Ly,Lz)
 report val(v, Lx,Ly,Lz)
 report val(w, Lx,Ly,Lz)
 report val(u, Lx/2,Ly/2,Lz/2)
 report val(v, Lx/2,Ly/2,Lz/2)
 report val(w, Lx/2,Ly/2,Lz/2)
 report val(u, Lx,Ly/2, Lz/2)
END
