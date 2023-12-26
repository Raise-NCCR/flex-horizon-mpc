function xk1 = carDT(xk, uk, Ts, inCurve)

M = 10;
delta = Ts / M;
xk1 = xk;

ratio = 2;

load('path.mat');

[i, dist] = dsearchn(pathRef(1:2,:)', [xk1(8) xk1(9)]);
k = pathRef(3,i);

pred_px = xk1(8) + 3 * (cos(xk1(7)) * xk1(2) - sin(xk1(7)) * xk1(3));
pred_py = xk1(9) + 3 * (sin(xk1(7)) * xk1(2) + cos(xk1(7)) * xk1(3));
pred_i = dsearchn(pathRef(1:2,:)', [pred_px pred_py]);
max_k = max(pathRef(3,i:pred_i));
min_k = min(pathRef(3,i:pred_i));
if (any(isnan(max_k), 'all'))
    delta = delta / ratio;
elseif (any(isnan(min_k), 'all'))
    delta = delta / ratio;
elseif (max_k > 0.003)
    delta = delta / ratio;
elseif (min_k < -0.003)
    delta = delta / ratio;
end

for ct = 1:M
    dxk = carCT(xk1, uk, k);
    xk1(4) = k * xk1(2);
    xk1(1:9) = xk1(1:9) + delta * dxk(1:9)';
end

[i, dist] = dsearchn(pathRef(1:2,:)', [xk1(8) xk1(9)]);
xk1(10) = pathRef(1, i);
xk1(11) = pathRef(2, i);
xk1(12) = pathRef(3, i);
xk1(13) = dist;

