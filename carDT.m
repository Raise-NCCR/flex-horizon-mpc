function xk1 = carDT(xk, uk, Ts, k, xyref)

M = 10;
delta = Ts / M;
xk1 = xk;

for ct = 1:M
    dxk = carCT(xk1, uk, k);
    xk1 = xk1 + delta * dxk';
end