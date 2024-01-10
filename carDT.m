function xk1 = carDT(xk, uk, Ts, inCurve, inStopping)

M = 10;
delta = Ts / M;
xk1 = xk;
finished = false;

ratio = 2;

% load('path.mat');
load("zhouXYPath.mat");

[i, dist] = dsearchn(pathRef(1:2,:)', [xk1(8) xk1(9)]);
k = pathRef(3,i);

if (i == length(pathRef(1,:)))
    finished = true;
end

pred_px = xk1(8) + 3 * (cos(xk1(7)) * xk1(2) - sin(xk1(7)) * xk1(3));
pred_py = xk1(9) + 3 * (sin(xk1(7)) * xk1(2) + cos(xk1(7)) * xk1(3));
pred_i = dsearchn(pathRef(1:2,:)', [pred_px pred_py]);
max_k = max(pathRef(3,i:pred_i));
min_k = min(pathRef(3,i:pred_i));
if (any(isnan(max_k), 'all'))
    delta = delta;
elseif (any(isnan(min_k), 'all'))
    delta = delta;
elseif (max_k > 0.003)
    delta = delta;
elseif (min_k < -0.003)
    delta = delta;
else
    delta = delta * ratio;
end

for ct = 1:M
    if (finished)
        xk(1:7) = zeros(1,7);
        xk(8:9) = pathRef(1:2,end);
    else
        dxk = carCT(xk1, uk);
        xk1(1:9) = xk1(1:9) + delta * dxk(1:9)';
        xk1(14) = xk1(14) + delta * dxk(10)';
    end
end
[i, dist] = dsearchn(pathRef(1:2,:)', [xk1(8) xk1(9)]);
xk1(10) = pathRef(1, i);
xk1(11) = pathRef(2, i);
xk1(12) = pathRef(3, i);
xk1(13) = dist;

