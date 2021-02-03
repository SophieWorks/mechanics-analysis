TITLE 'H1.3'     { the problem identification }
COORDINATES cartesian2  { coordinate system, 1D,2D,3D, etc }
VARIABLES        { system variables }
u  (threshold =0.01)            { choose your own names }
v  (threshold =0.01)

SELECT         { method controls }
ngrid = 1
penwidth = 3

DEFINITIONS    { parameter definitions }
m =60
g = 9.81
muk = 0.17
beta = pi/6
theta = pi/4
Fa = 450-(1.3*(ln(t+1)))
a =((2*Fa*cos(theta))-(muk*m*g*cos(beta))-(m*g*sin(beta)))/m

INITIAL VALUES
v=0

EQUATIONS        { PDE's, one for each variable }
v: dt(v)=a
u: dt(u)=v


BOUNDARIES       { The domain definition }
REGION 1       { For each material region }
START(0,0)   { Walk the domain boundary }
LINE TO (1,0) TO (1,1) TO (0,1) TO CLOSE
TIME 0 TO 5 by 0.01 halt (u>10)  { if time dependent }

PLOTS            { save result displays }
for t=1 by 0.01 to endtime
history(u,v,a) at (0,0) as "position, velocty, acceleration"

SUMMARY
report t as "Total Time[s]"
END
