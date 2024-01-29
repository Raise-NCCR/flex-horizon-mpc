mpcverbosity('off');

% nx = 9; % ax, vx, vy, wz, ye, wze, psi, px, py
% ny = 9; % same as x
nx = 15; % v, a, b, wz, psi, x, y, dist, ax, ay, bDot, wzDot, xJerk, yJerk, xJerk2
ny = 15; % same as x
nu = 2; % j, delta
nlobj = nlmpc(nx, ny, nu);

ratio = 2;
TsShort = 0.1;
TsLong = TsShort * 2;
Ts = TsShort;
k = 0;
% ref = [0, 0, 0, 0, 0, 0, 0, 0, 0];
% ref = [0, 16.7, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0];
ref = [];
nlobj.Ts = TsShort;
nlobj.PredictionHorizon = 30;
nlobj.ControlHorizon = 18;

% nlobj.States(2).Min = 0;
% nlobj.States(2).Max = 16.6;
% nlobj.States(3).Min = -16.6;
% nlobj.States(3).Max = 16.6;

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

% x0 = [0; 10; 0; 0; 0; 0; 0; 0; 0];
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
% kHistory = zeros(2, tLength);
% kHistory(:, 1) = [k; 0];
% xyHistory = zeros(2, tLength);
% xyHistory(:, 1) = [0; 0];

% % load("path.mat");
% load("zhouXYPath.mat");

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
    % if (~inCurve)
    %     index = index + 1;
    %     xHistory(:, index) = x;
    %     mvHistory(:, index) = mv;
    % end
    

    t = t + TsTmp;
end
toc
save("xHistory", "xHistory");
save("mvHistory", "mvHistory");
% 
% [r,a_y,da_y,xJerk] = ridecsdomfort(Ts,xHistory,mvHistory);
% 
% time = (0:TsShort:5);
% 
% load('zhouState.mat');
% load('zhouHis.mat');
% 
% figure;
% subplot(2,5,1);
% plot(time',zhouHistory(1,1:100:end),'k')
% hold on
% subplot(2,5,2);
% plot(time',zhouState(2,1:100:end),'k')
% hold on
% subplot(2,5,3);
% plot(time',zhouHistory(3,1:100:end),'k')
% hold on
% subplot(2,5,4);
% plot(time',zhouHistory(4,1:100:end),'k')
% hold on
% subplot(2,5,5);
% plot(time',zhouHistory(5,1:100:end),'k')
% hold on
% subplot(2,5,6);
% plot(time',zhouHistory(6,1:100:end),'k')
% hold on
% subplot(2,5,7);
% plot(time',zhouHistory(7,1:100:end),'k')
% hold on
% subplot(2,5,8);
% plot(time',zhouHistory(8,1:100:end),'k')
% hold on
% subplot(2,5,9);
% plot(time',zhouHistory(9,1:100:end),'k')
% hold on
% subplot(2,5,10);
% plot(time',zhouHistory(10,1:100:end),'k')
% hold on
% subplot(2,5,1);
% plot(time',mvHistory(1,1:length(time)),'r');
% legend('従来法','提案法');
% grid on
% xlabel('Time [s]');
% ylabel('Jerk [m/s^3]');
% subplot(2,5,2);
% plot(time',xHistory(2,1:length(time)),'r')
% legend('従来法','提案法');
% grid on
% xlabel('Time [s]');
% ylabel('Velocity [m/s]');
% subplot(2,5,3);
% plot(time',xHistory(1,1:length(time)),'r')
% legend('従来法','提案法');
% grid on
% xlabel('Time [s]');
% ylabel('Acceleration [m/s^2]');
% subplot(2,5,4);
% plot(time',a_y(1:length(time)),'r')
% legend('従来法','提案法');
% grid on
% xlabel('Time [s]');
% ylabel('Lateral acceleration [m/s^2]');
% subplot(2,5,5);
% plot(time',xHistory(4,1:length(time)),'r')
% legend('従来法','提案法');
% grid on
% xlabel('Time [s]');
% ylabel('Yaw rate [rad/s]');
% subplot(2,5,6);
% plot(time',xHistory(14,1:length(time)),'r')
% legend('制御なし','従来法','提案法');
% grid on
% xlabel('Time [s]');
% ylabel('Sideslip angle [rad]');
% subplot(2,5,7);
% plot(time',r(1:length(time)),'r')
% legend('従来法','提案法');
% grid on
% xlabel('Time [s]');
% ylabel('d(t)');
% subplot(2,5,8);
% plot(time',da_y(1:length(time)),'r')
% legend('従来法','提案法');
% grid on
% xlabel('Time [s]');
% ylabel('da_y/dt [m/s^3]');
% subplot(2,5,9);
% plot(time',mvHistory(1,1:length(time)),'r')
% legend('従来法','提案法');
% grid on
% xlabel('Time [s]');
% ylabel('jerk [m/s^3]');
% subplot(2,5,10);
% plot(time',mvHistory(2,1:length(time)),'r')
% legend('従来法','提案法');
% grid on
% xlabel('Time [s]');
% ylabel('jerk [m/s^3]');
% savefig('result.fig')
% 
% figure;
% plot(xHistory(14,:), xHistory(1,:));
% title("a-t");
% xlabel("a");
% ylabel("t");

% figure;
% plot(xHistory(14,:), xHistory(2,:));
% title("v-t");
% xlabel("v");
% ylabel("t");
% 
% figure;
% plot(xHistory(14,:), xHistory(4,:));
% title("omega-t");
% xlabel("omega");
% ylabel("t");
% 
% figure;
% plot(xHistory(14,:), mvHistory(1,:));
% title("jark-t");
% xlabel("jark");
% ylabel("t");
% 
% figure;
% plot(xHistory(14,:), mvHistory(2,:));
% title("delta-t");
% xlabel("delta");
% ylabel("t");

% save("kHistory", "kHistory");
% save("xyHistory", "xyHistory");
