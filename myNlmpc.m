mpcverbosity('off');


nx = 9; % ax, vx, vy, wz, ye, wze, psi, px, py
ny = 1; % ye
nu = 2; % j, delta
nlobj = nlmpc(nx, ny, nu);

Ts = 0.5;
k = 0;
xyref = [0, 0];
nlobj.Ts = Ts;
nlobj.PredictionHorizon = 6;
nlobj.ControlHorizon = 3;

nlobj.States(2).Min = 1;
nlobj.States(2).Max = 16.6;
% nlobj.States(3).Min = -16.6;
% nlobj.States(3).Max = 16.6;

nlobj.MV(1).Min = -2;
nlobj.MV(1).Max = 2;
nlobj.MV(2).Min = -1.5;
nlobj.MV(2).Max = 1.5;

% nlobj.OV.Min = -0.65;
% nlobj.OV.Max = 0.65;

nlobj.Model.StateFcn = "carDT";
nlobj.Model.IsContinuousTime = false;
nlobj.Model.NumberOfParameters = 3;
nlobj.Model.OutputFcn = "carOutputFcn";

nlobj.Optimization.CustomCostFcn = "carCostFcn";

x0 = [0; 10; 0; 0; 0; 0; 0; 0; 0];
y0 = x0(5);
u0 = [0; 0];

%nlobj.Optimization.CustomEqConFcn = "endConFcn";
validateFcns(nlobj, x0, u0, [], {Ts, k, xyref});

EKF = extendedKalmanFilter(@carStateFcn, @carMeasurementFcn);
x = x0;
y = y0;
EKF.State = x;
mv = [0; 0];

nloptions = nlmpcmoveopt;
nloptions.Parameters = {Ts, k, xyref};

load('kref.mat');
load('xypath.mat')

Duration = 100;
tLength = Duration / Ts;
xHistory = zeros(length(x(:,1)), tLength);
xHistory(:, 1) = x0;
mvHistory = zeros(length(mv(:,1)), tLength);
mvHistory(:, 1) = mv;
kHistory = zeros(2, tLength);
kHistory(:, 1) = [k; 0];
xyHistory = zeros(2, tLength);
xyHistory(:, 1) = [0; 0];

posPrev = [0; 0];
for t = 1:(tLength-1)
    t
    xk = correct(EKF, y);
    idx = dsearchn(xypath, [xk(8) xk(9)]);
    kref = kRef(t);
    xyref = xypath(t, :);
    [mv,nloptions] = nlmpcmove(nlobj,x,mv,0,[],nloptions);
    predict(EKF,[mv; Ts; kref; xyref']);
    x = carDT(x, mv, Ts, kref, xyref');
    y = x(5);
    xHistory(:, t+1) = x;
    mvHistory(:, t+1) = mv;
    kHistory(:, t+1) = [kref; idx];
    xyHistory(:, t+1) = [xypath(idx, :)];
end

save("xHistory", "xHistory");
save("mvHistory", "mvHistory");
save("kHistory", "kHistory");
save("xyHistory", "xyHistory");
