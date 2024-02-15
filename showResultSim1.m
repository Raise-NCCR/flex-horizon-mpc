%sim1
load("xHistory1.mat");
% load("mvHistory1.mat");

xHis1 = xHistory;
% mvHis1 = mvHistory;

Ts = 0.1;

r1 = ridecomfort(Ts,xHis1);

len = length(xHis1(1,:));

tmp = zeros(1,len-length(r1(1,:)));
r1 = [r1 tmp];

time = (0:0.1:(len/10)-0.1);

%従来法
load('zhouState.mat');
load('zhouHis.mat');

zhouR = ridecomfort(Ts,zhouState(:, 1:100:end));

zhouRes = zeros(10,length(time));

zhouRes(:,1:61) = [zhouHistory(1,1:100:6001);
    zhouHistory(2,1:100:6001);
    zhouHistory(3,1:100:6001);
    zhouHistory(4,1:100:6001);
    zhouHistory(5,1:100:6001);
    zhouHistory(6,1:100:6001);
    zhouHistory(7,1:100:6001);
    zhouHistory(8,1:100:6001);
    zhouHistory(9,1:100:6001);
    zhouHistory(10,1:100:6001)];

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

subplot(2,5,1);
plot(time',xHis1(13,1:length(time)),'r');
legend('従来法','提案法sim1', '提案法sim2');
grid on
xlabel('Time [s]');
ylabel('xJerk [m/s^3]');
subplot(2,5,2);
plot(time',xHis1(1,1:length(time)),'r')
legend('従来法','提案法sim1', '提案法sim2');
grid on
xlabel('Time [s]');
ylabel('Velocity [m/s]');
subplot(2,5,3);
plot(time',xHis1(9,1:length(time)),'r')
legend('従来法','提案法sim1', '提案法sim2');
grid on
xlabel('Time [s]');
ylabel('Acceleration [m/s^2]');
subplot(2,5,4);
plot(time',xHis1(10,1:length(time)),'r')
legend('従来法','提案法sim1', '提案法sim2');
grid on
xlabel('Time [s]');
ylabel('Lateral acceleration [m/s^2]');
subplot(2,5,5);
plot(time',xHis1(4,1:length(time)),'r')
legend('従来法','提案法sim1', '提案法sim2');
grid on
xlabel('Time [s]');
ylabel('Yaw rate [rad/s]');
subplot(2,5,6);
plot(time',xHis1(3,1:length(time)),'r')
legend('従来法','提案法sim1', '提案法sim2');
grid on
xlabel('Time [s]');
ylabel('Sideslip angle [rad]');
subplot(2,5,7);
plot(time',r1(1:length(time)),'r')
legend('従来法','提案法sim1', '提案法sim2');
grid on
xlabel('Time [s]');
ylabel('d(t)');
subplot(2,5,8);
plot(time',xHis1(14,1:length(time)),'r')
legend('従来法','提案法sim1', '提案法sim2');
grid on
xlabel('Time [s]');
ylabel('yJerk [m/s^3]');
subplot(2,5,9);
% plot(time',mvHis1(1,1:length(time)),'r')
% legend('従来法','提案法');
% grid on
% xlabel('Time [s]');
% ylabel('inputJerk [m/s^3]');
% subplot(2,5,10);
% plot(time',mvHis1(2,1:length(time)),'r')
% legend('従来法','提案法');
% grid on
% xlabel('Time [s]');
% ylabel('inputDelta [rad/s]');