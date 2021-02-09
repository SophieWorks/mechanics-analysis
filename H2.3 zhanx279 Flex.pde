TITLE 'H2.3 zhanx279 FlexPDE'     { the problem identification }
COORDINATES cartesian2  { coordinate system, 1D,2D,3D, etc }
SELECT
ngrid = 15
VARIABLES        { system variables }
  Temp(threshold=1e-5)
DEFINITIONS


tfinal = 30 !final time in seconds
initTemp

k
cp
rho

ro = 0.03 !outside radius of Rubber
ri = 0.01 !inside radius of copper

qdot = -k*grad(Temp)
INITIAL VALUES
Temp = initTemp
EQUATIONS        { PDE's, one for each variable }
 div(k*grad(Temp))=0
BOUNDARIES       { The domain definition }

REGION 1 'Outside Rubber'       
		k = 0.016
		rho = 1380
		cp = 0.9
		initTemp = 100
	START'BoundaryWire' (ro,0)
	load(Temp) = 700*(Temp-20)
	ARC(CENTER=0,0)  ANGLE=360 
	
REGION 2 'Inside Copper'        { the embedded circle}
		k = 401
		rho = 8960
		cp = 0.385
		initTemp = 500
	START (ri,0)
value(Temp) = 500
	ARC(CENTER=0,0)  ANGLE=360 

TIME 0 TO tfinal
PLOTS            { save result displays }
for time=0 by endtime/10 to endtime
contour(Temp) painted
!surface(Temp)
!vector(qdot)
	vector (-k*grad(Temp)) norm
SUMMARY
report integral(Temp, 'Outside Rubber' )/ integral(1, 'Outside Rubber' ) as "avg temp of rubber"  
report integral(Temp, 'Inside Copper')/ integral(1, 'Inside Copper') as "avg temp of copper"   

report line_integral(normal(qdot), 'BoundaryWire')as "Rate of heat flux out of wire"

END

