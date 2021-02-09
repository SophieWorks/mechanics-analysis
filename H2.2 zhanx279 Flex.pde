TITLE 'H2.2 zhanx279 FlexPDE'     { the problem identification }
COORDINATES cartesian2  { coordinate system, 1D,2D,3D, etc }
SELECT
!ngrid = 18
VARIABLES        { system variables }
  Temp(threshold=1e-4)
DEFINITIONS
ht = 0.1 ! rectanlge height (cm)
wdt = 0.2 ! rectanlge width (cm)
r = 0.05 ! circle radius (cm)

tfinal = 120
initTemp

k
cp
rho


qdot = -k*grad(Temp)
INITIAL VALUES
Temp = initTemp
EQUATIONS        { PDE's, one for each variable }
rho*cp*dt(Temp) - div(k*grad(Temp))=0
BOUNDARIES       { The domain definition }

!REGION 1 'Metal A'   
!		k = 90
!		rho = 400
!		cp = 3400
!		initTemp = 5
!	START(-ht,-wdt)
!	LINE TO(ht,-wdt)
!value(Temp)=5 
!	LINE TO (ht,wdt)
!	LINE TO (-ht,wdt)
!	value(Temp)=5 
!	LINE TO CLOSE

REGION 1 'Metal B'       
		k = 90
		rho = 400
		cp = 3400
		initTemp = 5
	START(-ht,-wdt)
	LINE TO(ht,-wdt)
value(Temp)=5 
	LINE TO (ht,wdt)
	LINE TO (-ht,wdt)
value(Temp)=5 
	LINE TO CLOSE

REGION 2 'Circle'        { the embedded circle}
		k = 30
		rho = 640
		cp = 240
		initTemp = 45
	START (r,0)
	ARC(CENTER=0,0)  ANGLE=360 TO CLOSE

TIME 0 TO tfinal
PLOTS            { save result displays }
for time=0 by endtime/10 to endtime
!for time = tfinal !don't need to specify a time range if you just want one particular time
contour(Temp) painted !fixed range(5,45)
surface(Temp)
vector(qdot)
END
