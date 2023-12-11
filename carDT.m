function xk1 = carDT(xk, uk, Ts)

M = 10;
delta = Ts / M;
xk1 = xk;

load('path.mat');

xypath = pathRef(1:2,:);

for ct = 1:M
    [i, dist] = dsearchn(xypath', [xk1(8) xk1(9)]);
    k = pathRef(3,i);
    dxk = carCT(xk1, uk, k);
    xk1(1:9) = xk1(1:9) + delta * dxk(1:9)';
    xk1(10) = dxk(10);
end

[i, dist] = dsearchn(xypath', [xk1(8) xk1(9)]);
xk1(11) = xypath(1, i);
xk1(12) = xypath(2, i);
xk1(13) = dist;

