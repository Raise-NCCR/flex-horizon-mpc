function J = carCostFcn(x, u, e, data, Ts)

ax = x(:,1);
vx = x(:,2);
vy = x(:,3);
wz = x(:,4);
ye = x(:,5);
wze = x(:,6);
psi = x(:,7);
px = x(:,8);
py = x(:,9);

mass = 1270;
caf = 65765;
car = 49517;
lf = 1.02;
lr = 1.9;
iz = 1550;

jark = u(:,1);
delta = u(:,2);

q1 = 10;
q2 = 1;
q3 = 1;
q4 = 1;
q5 = 1;

p = data.PredictionHorizon;

J = 0;
for i = 2:p+1
    % J = J + ( (q1 * ((16.6-v)^2)) + (q2 * (wze^2)) + (q3 * (xJark ^ 2)) + (q4 * (ax^2)) + (q5 * (ay^2)) );
    ay1 = 0;
    wzDot1 = 0;
    if (vx(i) == 0)
        ay1 = 0;
        wzDot1 = 0;
    else
        ay1 = -((2*caf+2*car)/(mass*vx(i)))*vy(i) - (vx(i)+((2*caf*lf-2*car*lr)/(mass*vx(i))))*wz(i);
        wzDot1 = -((2*caf*lf-2*car*lr)/(iz*vx(i)))*vy(i) - ((2*caf*lf^2+2*car*lr^2)/(iz*vx(i)))*wz(i);
    end
    
    ay = ay1 + ((2*caf)/mass)*delta(i);
    wzDot = wzDot1 + ((2*caf*lf)/iz)*delta(i);
    xJark = jark(i)^2 - ay * wz(i) - vy(i) * wzDot;
    v = sqrt((cos(psi(i)) * vx(i))^2 + (sin(psi(i)) * vy(i))^2);
    J = J + ye(i)^2 + wze(i) ^ 2;
end

