TITLE 'H3.1 zhanx279 part 4'
COORDINATES cartesian2
VARIABLES
  V ! Electric Potential Distribution
DEFINITIONS

!Wire
sigWire = 1/(1.68e-8) !sigma = 1/rho, given rho in question
ww = 1e-3 ! Width of the wire 
Lwx = 2e-2 ! Length of the wire in x 
Lwy = 2e-2 !Length of the wire in y 

Vdiff=12

sigma
J = -sigma*grad(V) !current density, parrellel to heat flow

! R1
sigR1 = 1/(5e-6)! *** What is the conductivity of R1? ***
wR1 = (3e-3)/2
LR1 = 1e-2
! R2
sigR2 = 1/(5e-6) ! *** What is the conductivity of R2? ***
wR2 =  (3e-3)*3
LR2 = 1e-2

!Rnew
sigR3 = 1/(5e-6)
wR3 = (3e-3)*3
LR3 = 5e-3

thickness = 0.001
right = vector(1,0)
down = vector(0,-1) 
left = vector(-1,0) 

I1 = thickness * surf_integral(dot(J, right), 'Branch0')
I2 = thickness * surf_integral(dot(J,  down), 'Branch1')
R1 = LR1/(sigR1*thickness*wR1)
R2 = LR2/(sigR2*thickness*wR2)

EQUATIONS
   div(J)=0 !steady state, charge density is constant
BOUNDARIES

REGION 'Wire'
    sigma = sigWire 
    START(0,0)
        value(V) = 0
    LINE TO (0,ww) 
        load(V) = 0
    LINE TO (Lwx/2-ww/2,ww) TO (Lwx/2-ww/2,Lwy) TO (0,Lwy) 
        value(V) = Vdiff
    LINE TO (0,Lwy+ww) 
        load(V) = 0
    LINE TO (Lwx+ww,Lwy+ww) TO (Lwx+ww,0) TO CLOSE
    START(Lwx/2+ww/2,ww) LINE TO (Lwx,ww) TO (Lwx,Lwy) TO (Lwx/2+ww/2, Lwy) TO CLOSE

  REGION 'R1'
    sigma = sigR1 
    START(Lwx/2-wR1/2, (Lwy/2+ww/2)-LR1/2)
    LINE TO (Lwx/2+wR1/2, (Lwy/2+ww/2)-LR1/2)
    LINE TO (Lwx/2+wR1/2, (Lwy/2+ww/2)+LR1/2)
    LINE TO (Lwx/2-wR1/2, (Lwy/2+ww/2)+LR1/2)
    LINE TO CLOSE

  REGION 'R2'
    sigma = sigR2 
    START(Lwx+ww/2-wR2/2, (Lwy/2+ww/2)-LR2/2)
    LINE TO (Lwx+ww/2+wR2/2, (Lwy/2+ww/2)-LR2/2)
    LINE TO (Lwx+ww/2+wR2/2, (Lwy/2+ww/2)+LR2/2)
    LINE TO (Lwx+ww/2-wR2/2, (Lwy/2+ww/2)+LR2/2)
    LINE TO CLOSE


  REGION 'R3'sigma = sigR3
	START (12.5e-3, Lwy-ww) 
	LINE TO (17.5e-3, Lwy-ww) 
	LINE TO (17.5e-3, Lwy+2*ww)
	LINE TO (12.5e-3, Lwy+2*ww)
	LINE TO CLOSE

FEATURE
  START 'Branch0' (Lwx/4,Lwy)
 LINE TO (Lwx/4,Lwy+ww) 

  START 'Branch1' (Lwx/2-ww/2, 0.85*(Lwy+ww))
 LINE TO (Lwx/2+ww/2, 0.85*(Lwy+ww)) 

  START 'Branch2' (Lwx/2+ww, Lwy) 
LINE TO (Lwx/2+ww,Lwy+ww) 

PLOTS
  CONTOUR(V) painted
  vector(V)
	vector(J)


SUMMARY
  REPORT I1 AS 'I1 Simulation [A]'
  REPORT I2 AS 'I2 Simulation [A]'
  REPORT Vdiff/R1 AS 'I2 Theory [A]'
! [?The rest of your code here?]
END


