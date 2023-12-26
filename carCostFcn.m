function J = carCostFcn(x, u, e, data, Ts, inCurve)

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

% q1 = 1;
% q2 = 1;
% q3 = 0.65;
% q4 = 0.34;
% q5 = 0.01;

q1 = 0.25;
q2 = 1;
q3 = 0.1625;
q4 = 0.085;
q5 = 0.0025;

p = data.PredictionHorizon;

J = 0;
for i = 2:p+1
    ay = ((2*caf)/mass)*delta(i); 
    wzDot = ((2*caf*lf)/iz)*delta(i);
    if (vx(i) ~= 0)
       ay = ay - ((2*caf+2*car)/(mass*vx(i)))*vy(i) - vx(i)*wz(i)-((2*caf*lf-2*car*lr)/(mass*vx(i)))*wz(i);
       wzDot = wzDot - ((2*caf*lf-2*car*lr)/(iz*vx(i)))*vy(i) - ((2*caf*(lf^2)+2*car*(lr^2))/(iz*vx(i)))*wz(i);
    end
     
    xJark = jark(i)^2 - ay * wz(i) - vy(i) * wzDot;
    v = sqrt((cos(psi(i)) * vx(i))^2 + (sin(psi(i)) * vy(i))^2);
    % J = J + ( (q1 * ((16.6-v)^2)) + (q3 * (xJark ^ 2)) + (q4 * (ax^2)) + (q5 * (ay^2)) );
    if (inCurve)
        J = J + (q3 * (xJark ^ 2)) + (q4 * (ax(i)^2)) + (q5 * (ay^2));
    else
        J = J + (q1 * (16 - vx(i))^2) + (q3 * (xJark ^ 2)) + (q4 * (ax(i)^2)) + (q5 * (ay^2));
    end
    if (vx(i) > 17)
        J = 10000;
    end
    % J = J + ye(i)^2 + wze(i) ^ 2;
    % J = J + (16 - vx(i))^4;
end

