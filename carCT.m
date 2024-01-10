function dxStatedt = carCT(xState, uInput)

ax = xState(1);
vx = xState(2);
vy = xState(3);
wz = xState(4);
ye = xState(5);
wze = xState(6);
psi = xState(7);
px = xState(8);
py = xState(9);
b = xState(14);

xJerk = uInput(1);
delta = uInput(2);

mass = 1100;
caf = 32000;
car = 32000;
lf = 1.15;
lr = 1.35;
iz = 1600;

vyDot = ((2*caf)/mass)*delta; 
% vyDot = 0;
wzDot = ((2*caf*lf)/iz)*delta;
% wzDot = 0;
bDot = 0;
if (vx ~= 0)
    vyDot = vyDot - ((2*caf+2*car)/(mass*vx))*vy - vx*wz-((2*caf*lf-2*car*lr)/(mass*vx))*wz;
    wzDot = wzDot - ((2*caf*lf-2*car*lr)/(iz*vx))*vy - ((2*caf*(lf^2)+2*car*(lr^2))/(iz*vx))*wz;
    bDot = (vyDot * vx - ax*vy)/(vx^2);
end

axDot = xJerk;
vxDot = ax;
yeDot = vy + vx * wze;
% wzeDot = -k * vx + wz;
wzeDot = 0;
psiDot = wz;
pxDot = cos(psi) * vx - sin(psi) * vy;
pyDot = sin(psi) * vx + cos(psi) * vy;

% axDot = 0;

dxStatedt = [axDot, vxDot, vyDot, wzDot, yeDot, wzeDot, psiDot, pxDot, pyDot, bDot];