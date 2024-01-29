function xk1 = carDT(xk, uk, Ts, ~, ~)

M = 10;
delta = Ts / M;
xk1 = xk;
finished = false;

ratio = 2;

% % load('path.mat');
% load("zhouXYPath.mat");

global pathRef

[i, ~] = dsearchn(pathRef(1:2,:)', [xk1(6) xk1(7)]);
% k = pathRef(3,i);

if (i == length(pathRef(1,:)))
    finished = true;
end

pred_px = xk1(6) + 3 * (cos(xk1(5)) * xk1(1) - sin(xk1(5)) * xk1(1) * xk1(3));
pred_py = xk1(7) + 3 * (sin(xk1(5)) * xk1(1) + cos(xk1(5)) * xk1(1) * xk1(3));
pred_i = dsearchn(pathRef(1:2,:)', [pred_px pred_py]);
max_k = max(pathRef(3,i:pred_i));
min_k = min(pathRef(3,i:pred_i));
if (any(isnan(max_k), 'all'))
    delta = delta;
elseif (any(isnan(min_k), 'all'))
    delta = delta;
elseif (max_k > 0.006)
    delta = delta;
elseif (min_k < -0.006)
    delta = delta;
else
    delta = delta * ratio;
end

ax = 0;
ay = 0;
bDot = 0;
wzDot = 0;
xJerk = 0;
yJerk = 0;
xJerk2 = 0;
for ct = 1:M
    if (finished)
        xk1(1:5) = zeros(1,5);
        xk1(6:7) = pathRef(1:2,end);
    else
        dxk = carCT(xk1, uk);
        xk1(1:7) = xk1(1:7) + delta * dxk(1:7)';
        bDot = dxk(3);
        wzDot = dxk(4);
        ax = dxk(8);
        ay = dxk(9);
        xJerk = xJerk + dxk(10);
        yJerk = yJerk + dxk(11);
        xJerk2 = dxk(12);
    end
end
[i, dist] = dsearchn(pathRef(1:2,:)', [xk1(6) xk1(7)]);
xk1(8) = dist;
xk1(9) = ax;
xk1(10) = ay;
xk1(11) = bDot;
xk1(12) = wzDot;
xk1(13) = xJerk;
xk1(14) = yJerk;
xk1(15) = xJerk2;

