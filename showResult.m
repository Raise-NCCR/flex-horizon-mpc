load("xHistory.mat");
load("mvHistory.mat");

Ts = 0.1;

r = ridecomfort(Ts,xHistory);

time = (0:0.1:(length(xHistory(1,:))/10-0.1));

load('zhouState.mat');
load('zhouHis.mat');

zhouR = ridecomfort(Ts,zhouState(:, 1:100:end));

zhouRes = zeros(10,length(time));
% zhouRes(:,1:length(zhouState(9,1:100:end))) = [zhouState(13,1:100:end);
%     zhouState(1,1:100:end);
%     zhouState(9,1:100:end);
%     zhouState(10,1:100:end);
%     zhouState(4,1:100:end);
%     zhouState(3,1:100:end);
%     zhouR;
%     zhouState(2,1:100:end)];

zhouRes(:,1:length(zhouHistory(1,1:100:end))) = [zhouHistory(1,1:100:end);
    zhouHistory(2,1:100:end);
    zhouHistory(3,1:100:end);
    zhouHistory(4,1:100:end);
    zhouHistory(5,1:100:end);
    zhouHistory(6,1:100:end);
    zhouHistory(7,1:100:end);
    zhouHistory(8,1:100:end);
    zhouHistory(9,1:100:end);
    zhouHistory(10,1:100:end)];

% zhouMV = zeros(2,length(time));
% zhouMV(:,21:length(zhouState(9,1:100:end))) = zhouHistory(9:10,1:100:end);

figure;

subplot(2,5,1);
plot(time',zhouRes(1,:),'k')
hold on
subplot(2,5,2);
plot(time',zhouRes(2,:),'k')
hold on
subplot(2,5,3);
plot(time',zhouRes(3,:),'k')
hold on
subplot(2,5,4);
plot(time',zhouRes(4,:),'k')
hold on
subplot(2,5,5);
plot(time',zhouRes(5,:),'k')
hold on
subplot(2,5,6);
plot(time',zhouRes(6,:),'k')
hold on
subplot(2,5,7);
plot(time',zhouRes(7,:),'k')
hold on
subplot(2,5,8);
plot(time',zhouRes(8,:),'k')
hold on
subplot(2,5,9);
plot(time',zhouRes(9,:),'k')
hold on
subplot(2,5,10);
plot(time',zhouRes(10,:),'k')
hold on

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
% plot(time',zhouHistory(11,1:100:end),'k')
% hold on
% subplot(2,5,9);
% plot(time',zhouHistory(9,1:100:end),'k')
% hold on
% subplot(2,5,10);
% plot(time',zhouHistory(10,1:100:end),'k')
% hold on

subplot(2,5,1);
plot(time',xHistory(13,1:length(time)),'r');
legend('従来法','提案法');
grid on
xlabel('Time [s]');
ylabel('xJerk [m/s^3]');
subplot(2,5,2);
plot(time',xHistory(1,1:length(time)),'r')
legend('従来法','提案法');
grid on
xlabel('Time [s]');
ylabel('Velocity [m/s]');
subplot(2,5,3);
plot(time',xHistory(9,1:length(time)),'r')
legend('従来法','提案法');
grid on
xlabel('Time [s]');
ylabel('Acceleration [m/s^2]');
subplot(2,5,4);
plot(time',xHistory(10,1:length(time)),'r')
legend('従来法','提案法');
grid on
xlabel('Time [s]');
ylabel('Lateral acceleration [m/s^2]');
subplot(2,5,5);
plot(time',xHistory(4,1:length(time)),'r')
legend('従来法','提案法');
grid on
xlabel('Time [s]');
ylabel('Yaw rate [rad/s]');
subplot(2,5,6);
plot(time',xHistory(3,1:length(time)),'r')
legend('制御なし','従来法','提案法');
grid on
xlabel('Time [s]');
ylabel('Sideslip angle [rad]');
subplot(2,5,7);
plot(time',r(1:length(time)),'r')
legend('従来法','提案法');
grid on
xlabel('Time [s]');
ylabel('d(t)');
subplot(2,5,8);
plot(time',xHistory(2,1:length(time)),'r')
legend('従来法','提案法');
grid on
xlabel('Time [s]');
ylabel('yJerk [m/s^3]');
subplot(2,5,9);
plot(time',mvHistory(1,1:length(time)),'r')
legend('従来法','提案法');
grid on
xlabel('Time [s]');
ylabel('inputJerk [m/s^3]');
subplot(2,5,10);
plot(time',mvHistory(2,1:length(time)),'r')
legend('従来法','提案法');
grid on
xlabel('Time [s]');
ylabel('inputDelta [rad/s]');
savefig('result.fig')
