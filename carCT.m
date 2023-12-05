function dxStatedt = carCT(xState, uInput, kInput)

ax = xState(1);
vx = xState(2);
vy = xState(3);
wz = xState(4);
ye = xState(5);
wze = xState(6);
psi = xState(7);
px = xState(8);
py = xState(9);

u = uInput(1);
delta = uInput(2);
k = kInput;

mass = 1100;
caf = 32000;
car = 32000;
lf = 1.15;
lr = 1.35;
iz = 1600;

vyDot1 = 0;
wzDot1 = 0;
if (vx == 0)
    vyDot1 = 0;
    wzDot1 = 0;
else
    vyDot1 = -((2*caf+2*car)/(mass*vx))*vy - vx*sin(wz)+(((2*caf*lf-2*car*lr)/(mass*vx)))*wz;
    wzDot1 = -((2*caf*lf-2*car*lr)/(iz*vx))*vy - ((2*caf*lf^2+2*car*lr^2)/(iz*vx))*wz;
end

axDot = u;
vxDot = ax;
vyDot = vyDot1 + ((2*caf)/mass)*delta; 
wzDot = wzDot1  + ((2*caf*lf)/iz)*delta;
yeDot = vy * cos(wze) + vx * sin(wze);
wzeDot = -k * vx + wz;
psiDot = wze;
pxDot = cos(psi) * vx - sin(psi) * vy;
pyDot = sin(psi) * vx + cos(psi) * vy;


dxStatedt = [axDot, vxDot, vyDot, wzDot, yeDot, wzeDot, psiDot, pxDot, pyDot];