load("xHistory.mat");
load("mvHistory.mat");

Ts = 0.1;

[r,a_y,da_y,xJerk] = ridecomfort(Ts,xHistory,mvHistory);

time = (0:TsShort:5);

load('zhouState.mat');
load('zhouHis.mat');

[zhouR,zhouAy,zhouDay,zhouXJerk] = ridecomfort(Ts,zhouState(:,1:100:end),zhouHistory(9:10,1:100:end));

figure;
subplot(2,5,1);
plot(time',zhouHistory(9,1:100:end),'k')
hold on
subplot(2,5,2);
plot(time',zhouState(2,1:100:end),'k')
hold on
subplot(2,5,3);
plot(time',zhouState(1,1:100:end),'k')
hold on
subplot(2,5,4);
plot(time',zhouAy,'k')
hold on
subplot(2,5,5);
plot(time',zhouState(4,1:100:end),'k')
hold on
subplot(2,5,6);
plot(time',zhouState(14,1:100:end),'k')
hold on
subplot(2,5,7);
plot(time',zhouR,'k')
hold on
subplot(2,5,8);
plot(time',zhouDay,'k')
hold on
subplot(2,5,9);
plot(time',zhouHistory(9,1:100:end),'k')
hold on
subplot(2,5,10);
plot(time',zhouHistory(10,1:100:end),'k')
hold on
subplot(2,5,1);
plot(time',mvHistory(1,1:length(time)),'r');
legend('従来法','提案法');
grid on
xlabel('Time [s]');
ylabel('Jerk [m/s^3]');
subplot(2,5,2);
plot(time',xHistory(2,1:length(time)),'r')
legend('従来法','提案法');
grid on
xlabel('Time [s]');
ylabel('Velocity [m/s]');
subplot(2,5,3);
plot(time',xHistory(1,1:length(time)),'r')
legend('従来法','提案法');
grid on
xlabel('Time [s]');
ylabel('Acceleration [m/s^2]');
subplot(2,5,4);
plot(time',a_y(1:length(time)),'r')
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
plot(time',xHistory(14,1:length(time)),'r')
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
plot(time',da_y(1:length(time)),'r')
legend('従来法','提案法');
grid on
xlabel('Time [s]');
ylabel('da_y/dt [m/s^3]');
subplot(2,5,9);
plot(time',mvHistory(1,1:length(time)),'r')
legend('従来法','提案法');
grid on
xlabel('Time [s]');
ylabel('jerk [m/s^3]');
subplot(2,5,10);
plot(time',mvHistory(2,1:length(time)),'r')
legend('従来法','提案法');
grid on
xlabel('Time [s]');
ylabel('jerk [m/s^3]');
savefig('result.fig')
