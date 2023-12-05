function J = carCostFcn(x, u, e, data, Ts, k, xyref)

ax = x(1);
vx = x(2);
vy = x(3);
wz = x(4);
ye = x(5);
wze = x(6);
psi = x(7);
px = x(8);
py = x(9);

mass = 1270;
caf = 65765;
car = 49517;
lf = 1.02;
lr = 1.9;
iz = 1550;

jark = u(1);
delta = u(2);

q1 = 10;
q2 = 1;
q3 = 1;
q4 = 1;
q5 = 1;

p = data.PredictionHorizon;

ay1 = 0;
wzDot1 = 0;
if (vx == 0)
    ay1 = 0;
    wzDot1 = 0;
else
    ay1 = -((2*caf+2*car)/(mass*vx))*vy - (vx+((2*caf*lf-2*car*lr)/(mass*vx)))*wz;
    wzDot1 = -((2*caf*lf-2*car*lr)/(iz*vx))*vy - ((2*caf*lf^2+2*car*lr^2)/(iz*vx))*wz;
end

ay = ay1 + ((2*caf)/mass)*delta;
wzDot = wzDot1 + ((2*caf*lf)/iz)*delta;
xJark = jark^2 - ay * wz - vy * wzDot;
v = sqrt((cos(psi) * vx)^2 + (sin(psi) * vy)^2);

J = 0;
for i = 1:p
    % J = J + ( (q1 * ((16.6-v)^2)) + (q2 * (wze^2)) + (q3 * (xJark ^ 2)) + (q4 * (ax^2)) + (q5 * (ay^2)) );
    J = J + (px - xyref(1))^2 + (py-xyref(2))^2;
end

