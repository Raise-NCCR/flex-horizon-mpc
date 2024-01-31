function dxStatedt = carCT(xState, uInput)

v = xState(1);
a = xState(2);
b = xState(3);
wz = xState(4);
psi = xState(5);
bDot = xState(11);
wzDot = xState(12);

jerk = uInput(1);
delta = uInput(2);

mass = 1100;
caf = 32000;
car = 32000;
lf = 1.15;
lr = 1.25;
iz = 1600;

a1 = -(caf+car)/mass;
a2 = (car*lr-caf*lf)/mass-1;
a3 = caf/mass;
a4 = -1/mass;
b1 = (car*lr-caf*lf)/iz;
b2 = -(caf*(lf^2)+car*(lr^2))/iz;
b3 = (caf*lf)/iz;

ax = a - v*b*wz;
ay = v*bDot + a*b + v*wz;
xDot = (cos(psi) * v - sin(psi) * v * b);
yDot = (sin(psi) * v + cos(psi) * v * b);

vDot = a;
aDot = jerk;
bDot = a1*b/v + a2*wz/(v^2) - wz + a3*delta/v + a4*a*b/v;
wzDot = b1*b + b2*wz/v + b3*delta;
psiDot = wz;

xJerk = jerk - a*b*wz - v*bDot*wz - v*b*wzDot;
yJerk = a*bDot + jerk*b + a*bDot + a*wz + v*wzDot;
xJerk2 = - a*b*wz - v*bDot*wz - v*b*wzDot;

dxStatedt = [vDot, aDot, bDot, wzDot, psiDot, xDot, yDot, ax, ay, xJerk, yJerk, xJerk2];