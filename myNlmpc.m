mpcverbosity('off');

nx = 15; % v, a, b, wz, psi, x, y, dist, ax, ay, bDot, wzDot, xJerk, yJerk, xJerk2
ny = 15; % same as x
nu = 2; % j, delta
nlobj = nlmpc(nx, ny, nu);

ratio = 2;
TsShort = 0.1;
TsLong = TsShort * 2;
Ts = TsShort;
k = 0;
ref = [];
nlobj.Ts = TsShort;
nlobj.PredictionHorizon = 30;
nlobj.ControlHorizon = 18;

nlobj.MV(1).Min = -1;
nlobj.MV(1).Max = 1;
nlobj.MV(2).Min = -1.57;
nlobj.MV(2).Max = 1.57;

nlobj.OV(1).Min = 5;
nlobj.OV(1).Max = 16.7;
nlobj.OV(9).Max = 2;
nlobj.OV(9).Min = -1;
nlobj.OV(13).Min = -1;
nlobj.OV(13).Max = 1;
nlobj.OV(8).Min = -0.65;
nlobj.OV(8).Max = 0.65;
% nlobj.OV(8).Min = -1;
% nlobj.OV(8).Max = 1;

nlobj.Model.StateFcn = "carDT";
nlobj.Model.IsContinuousTime = false;
nlobj.Model.OutputFcn = "carOutputFcn";

nlobj.Optimization.CustomCostFcn = "carCostFcn";
nlobj.Optimization.ReplaceStandardCost = true;

x0 = [16.7; 0; 0; 0; 0; 0; 0; 0; 0; 0; 0; 0; 0; 0; 0];
y0 = x0;
u0 = [0; 0];
inCurve = false;
inStopping = false;

global pathRef
load("path.mat");
% load("zhouXYPath.mat");

% nlobj.Optimization.CustomEqConFcn = "endConFcn";
nlobj.Model.NumberOfParameters = 3;
validateFcns(nlobj, x0, u0, [], {Ts, inCurve, inStopping});

EKF = extendedKalmanFilter(@carStateFcn, @carMeasurementFcn);
x = x0;
y = y0;
EKF.State = x;
mv = [0; 0];

nloptions = nlmpcmoveopt;
nloptions.Parameters = {Ts, inCurve, inStopping};

Duration = 1000;
tLength = Duration / Ts;
xHistory = zeros(length(x(:,1)), 51);
xHistory(:, 1) = x0;
mvHistory = zeros(length(mv(:,1)), tLength);
mvHistory(:, 1) = mv;

index = 1;
t = 0;
started = false;
endPoint = false;
tic
while t < Duration
    t
    xk = correct(EKF, y);
    xk(1)
    i = dsearchn(pathRef(1:2,:)', [xk(6) xk(7)]);
    if (i > length(pathRef(1,:)) - 1000)
       break;
    end
    inStopping = false;
    
    % simple position prediction
    pred_px = xk(6) + 3 * (cos(xk(5)) * xk(1) - sin(xk(5)) * xk(1) * xk(3));
    pred_py = xk(7) + 3 * (sin(xk(5)) * xk(1) + cos(xk(5)) * xk(1) * xk(3));

    pred_i = dsearchn(pathRef(1:2,:)', [pred_px pred_py]);
    max_k = max(pathRef(3,i:pred_i));
    min_k = min(pathRef(3,i:pred_i));
    
    if (any(isnan(max_k), 'all'))
        TsTmp = TsShort;
        inCurve = true;
    elseif(any(isnan(min_k), 'all'))
        TsTmp = TsShort;
        inCurve = true;
    elseif (max_k > 0.006)
        TsTmp = TsShort;
        inCurve = true;
    elseif(min_k < -0.006)
        TsTmp = TsShort;
        inCurve = true;
    else
        % TsTmp = TsShort;
        TsTmp = TsLong;
        inCurve = false;
    end
    nloptions.Parameters = {Ts, inCurve, inStopping};
    [mv,nloptions] = nlmpcmove(nlobj,x,mv,ref,[],nloptions);
    predict(EKF,[mv; Ts; inCurve; inStopping]);
    x = carDT(x, mv, Ts, inCurve, inStopping);
    y = x;
    index = index + 1;
    xHistory(:, index) = x;
    mvHistory(:, index) = mv;
    if (~inCurve)
        index = index + 1;
        xHistory(:, index) = x;
        mvHistory(:, index) = mv;
    end
    

    t = t + TsTmp;
end
toc
save("xHistory", "xHistory");
save("mvHistory", "mvHistory");