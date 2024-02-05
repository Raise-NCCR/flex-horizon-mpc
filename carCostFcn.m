function J = carCostFcn(xState, ~, ~, data, ~, inCurve) %#codegen

v = xState(:,1);
dist = xState(:,8);
ax = xState(:,9);
ay = xState(:,10);
xJerk = xState(:,11);

q1 = 0.5;
q2 = 0.2;
q3 = 0.15;
q4 = 0.15;

p = data.PredictionHorizon;

J = 0;
for i = 2:p+1
    if (inCurve == true)
        J = J + ((2*q2)^2 * (xJerk(i) ^ 2)) + ((2*q3)^2 * (ax(i)^2)) + ((2*q4)^2 * (ay(i)^2));
    else
        J = J + ((q1^2)*((16.7-v(i))^2)) + ((q2)^2 * (xJerk(i) ^ 2)) + ((q3)^2 * (ax(i)^2)) + ((q4)^2 * (ay(i)^2));
    end
    if (v(i) > 17)
        J = 10000;
    end
    if(dist(i) > 1)
        J = 10000;
    end
end

