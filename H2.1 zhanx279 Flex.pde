TITLE 'H2.1 zhanx279 FlexPDE'     { the problem identification }
COORDINATES cartesian2  { coordinate system, 1D,2D,3D, etc }
VARIABLES        { system variables }
  Temp(threshold=0.1)
!SELECT         { method controls }
DEFINITIONS    { parameter definitions }
!part B
!k = if(Temp<1300) then 100/(11.75+.0235*Temp) else 2.2	! thermal conductivity

!part C
tC=(Temp+273.15)/1000
k=(115.8/(7.5408+17.692*tC+(3.6142*tC^2)))+7410.5*tC^(-5/2)*exp(-16.35/tC)

D = 0.012/2			!radius = D/2=12mm/2
qdotvol = 493e6*1.4	!40% increase 


qdot = -k*grad(Temp)
!INITIAL VALUES

EQUATIONS        { PDE's, one for each variable }
div(k*grad(Temp))=-qdotvol

! CONSTRAINTS    { Integral constraints }
BOUNDARIES       { The domain definition }
  REGION 1       { For each material region }
   START(D,0) 
		value(Temp)=550 
	arc(center=0,0) angle 90
		load(Temp) = 0 
	line to (0,0)
	line to (D,0)


!TIME 0 TO 300    { if time dependent }
MONITORS         { show progress }
PLOTS            { save result displays }
!for t = 0 by 2 to endtime
  CONTOUR(Temp) painted
vector(qdot)
SUMMARY
!report surf_integral(normal(qdot)) 
END

