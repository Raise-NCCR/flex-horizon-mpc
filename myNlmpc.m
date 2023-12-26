mpcverbosity('off');


% nx = 9; % ax, vx, vy, wz, ye, wze, psi, px, py
% ny = 9; % same as x
nx = 13; % ax, vx, vy, wz, ye, wze, psi, px, py
ny = 13; % same as x
nu = 2; % j, delta
nlobj = nlmpc(nx, ny, nu);

ratio = 2;
TsShort = 0.1;
TsLong = TsShort * 2;
Ts = TsLong;
k = 0;
% ref = [0, 0, 0, 0, 0, 0, 0, 0, 0];
% ref = [0, 16.7, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0];
ref = [];
nlobj.Ts = Ts;
nlobj.PredictionHorizon = 5;
nlobj.ControlHorizon = 2;

% nlobj.States(2).Min = 0;
% nlobj.States(2).Max = 16.6;
% nlobj.States(3).Min = -16.6;
% nlobj.States(3).Max = 16.6;

nlobj.MV(1).Min = -10;
nlobj.MV(1).Max = 10;
nlobj.MV(2).Min = -0.61;
nlobj.MV(2).Max = 0.61;

nlobj.OV(2).Min = 0;
nlobj.OV(2).Max = 16.7;
% nlobj.OV(3).Min = -1;
% nlobj.OV(3).Max = 1;
nlobj.OV(13).Min = -0.65;
nlobj.OV(13).Max = 0.65;

nlobj.Model.StateFcn = "carDT";
nlobj.Model.IsContinuousTime = false;
nlobj.Model.OutputFcn = "carOutputFcn";

nlobj.Optimization.CustomCostFcn = "carCostFcn";
nlobj.Optimization.ReplaceStandardCost = true;

% x0 = [0; 10; 0; 0; 0; 0; 0; 0; 0];
x0 = [0; 5; 0; 0; 0; 0; 0; 0; 0; 0; 0; 0; 0];
y0 = x0;
u0 = [0; 0];
inCurve = false;

nlobj.Optimization.CustomEqConFcn = "endConFcn";
nlobj.Model.NumberOfParameters = 2;
validateFcns(nlobj, x0, u0, [], {Ts, inCurve});

EKF = extendedKalmanFilter(@carStateFcn, @carMeasurementFcn);
x = x0;
y = y0;
EKF.State = x;
mv = [0; 0];

nloptions = nlmpcmoveopt;
nloptions.Parameters = {Ts, inCurve};

Duration = 100;
tLength = Duration / Ts;
xHistory = zeros(length(x(:,1)), tLength);
xHistory(:, 1) = x0;
mvHistory = zeros(length(mv(:,1)), tLength);
mvHistory(:, 1) = mv;
% kHistory = zeros(2, tLength);
% kHistory(:, 1) = [k; 0];
% xyHistory = zeros(2, tLength);
% xyHistory(:, 1) = [0; 0];

load("path.mat");

index = 0;
t = 0;
while t < Duration
    t
    xk = correct(EKF, y);
    i = dsearchn(pathRef(1:2,:)', [xk(8) xk(9)]);
    TsTmp = TsLong;
    inCurve = false;
    
    % simple position prediction
    pred_px = xk(8) + 3 * (cos(xk(7)) * xk(2) - sin(xk(7)) * xk(3));
    pred_py = xk(9) + 3 * (sin(xk(7)) * xk(2) + cos(xk(7)) * xk(3));
    pred_i = dsearchn(pathRef(1:2,:)', [pred_px pred_py]);
    max_k = max(pathRef(3,i:pred_i));
    min_k = min(pathRef(3,i:pred_i));
    if (any(isnan(max_k), 'all'))
        TsTmp = TsShort;
        inCurve = true;
    elseif(any(isnan(min_k), 'all'))
        TsTmp = TsShort;
        inCurve = true;
    elseif (max_k > 0.003)
        TsTmp = TsShort;
        inCurve = true;
    elseif(min_k < -0.003)
        TsTmp = TsShort;
        inCurve = true;
    end
    [mv,nloptions] = nlmpcmove(nlobj,x,mv,ref,[],nloptions);
    predict(EKF,[mv; Ts; inCurve]);
    x = carDT(x, mv, Ts, inCurve);
    y = x;
    xHistory(:, index+1) = x;
    mvHistory(:, index+1) = mv;
    index = index + 1;
    t = t + TsTmp;
end

save("xHistory", "xHistory");
save("mvHistory", "mvHistory");
% save("kHistory", "kHistory");
% save("xyHistory", "xyHistory");
