function J = carCostFcn(xState, ~, ~, data, ~, inCurve, inStopping)

v = xState(:,1);
dist = xState(:,8);
ax = xState(:,9);
ay = xState(:,10);
xJerk = xState(:,13);

q1 = 0.5;
q2 = 0.2;
q3 = 0.15;
q4 = 0.15;

p = data.PredictionHorizon;

J = 0;
for i = 2:p+1
    % J = J + ( (q1 * ((16.6-v)^2)) + (q3 * (xJark ^ 2)) + (q4 * (ax^2)) + (q5 * (ay^2)) );
    % if (inCurve)
    %     J = J + (q3 * (xJark ^ 2)) + (q4 * (ax(i)^2)) + (q5 * (ay^2));
    % % elseif (inStopping)
    % %     J = J + (q1 * vx(i)^2) + (q3 * (xJark ^ 2)) + (q4 * (ax(i)^2)) + (q5 * (ay^2));
    % else
    %     J = J + (q1 * (16 - vx(i))^2) + (q3 * (xJark ^ 2)) + (q4 * (ax(i)^2)) + (q5 * (ay^2));
    % end
    J = J + ((2*q2)^2 * (xJerk(i) ^ 2)) + ((2*q3)^2 * (ax(i)^2)) + ((2*q4)^2 * (ay(i)^2));
    if (v(i) > 17)
        J = 10000;
    end
    if(dist(i) > 1)
        J = 10000;
    end
    % J = J + ye(i)^2 + wze(i) ^ 2;
    % J = J + (16 - vx(i))^4;
end

