TITLE 'H7.3 3 attempting to put into pure shear'
COORDINATES cartesian3
VARIABLES
u
v
w
DEFINITIONS
mag = .5*globalmax(magnitude(x,y,z))/globalmax(magnitude(u,v,w))
Lx = 0.2
Ly = 0.2
Lz = 0.2
nu=0.25
E=9e9
G = E/(2*(1+nu))
sApplied = 60/(Lx*Ly)
sTApplied = 100/(Lx*Ly)
{matrix}
C11 = E/((1+nu)*(1-2*nu))*(1-nu)
C22 = C11
C33 = C11
C12 = E/((1+nu)*(1-2*nu))*nu
C13 =C12
C21 =C12
C23 = C12
C31 = C12
C32 = C12
{strain}
ex = dx(u)
ey = dy(v)
ez = dz(w)
gyz = dz(v) + dy(w)
gxz = dz(u) + dx(w)
gxy = dy(u) + dx(v)
{Stress}
sx = C11*ex + C12*ey+C13*ez
sy = C21*ex + C22*ey+C23*ez
sz = C31*ex + C32*ey+C33*ez
syz = G*gyz
sxz = G*gxz
sxy = G*gxy
EQUATIONS
u: dx(sx) + dy(sxy) + dz(sxz) = 0
v: dx(sxy) + dy(sy) + dz(syz) = 0
w: dx(sxz) + dy(syz) + dz(sz) = 0
EXTRUSION
surface 'bottom' z = 0
surface 'top' z = Lz
	BOUNDARIES
	surface 'bottom'
	value(u)=0
	value(v)=0
	value(w)=0
	surface 'top'
	load(u)=sApplied
	load(v)=0
	load(w)=0
 
REGION 1
 START(0,0) !y=0
load(u) = 0 load(v) = 0 load(w) =  0

LINE TO (Lx,0) !x=Lx
load(u) = 0 load(v) = 0 load(w) = sApplied

LINE TO (Lx,Ly) !y=Ly
load(u) = 0 load(v) = 0 load(w) = 0

LINE TO (0,Ly)!x=0
load(u) = 0 load(v) = 0 load(w) = -sApplied

LINE TO CLOSE 

MONITORS
PLOTS
grid(x+u*mag, y+v*mag,z+w*mag)
 CONTOUR(sy) on y=0 painted
 CONTOUR(sxy) on y=0 painted
 CONTOUR(syz) on y=0 painted
SUMMARY
report val(u,Lx,Ly,Lz)
report val(v,Lx,Ly,Lz)
report val(w,Lx,Ly,Lz)
END