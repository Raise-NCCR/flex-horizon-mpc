%ホライズン可変
load("xHistory3-1-3.mat");
load("mvHistory3-1-3.mat");

xHis3_1 = xHistory;
mvHis1 = mvHistory;

%ホライズン固定
load("xHistory3-2-3.mat");
load("mvHistory3-2-3.mat");
xHis3_2 = xHistory;
mvHis2 = mvHistory;

Ts = 0.1;

r1 = ridecomfort(Ts,xHis3_1);
r2 = ridecomfort(Ts,xHis3_2);

mean(r1)
mean(r2)

len = length(xHis3_2(1,:));

tmp = zeros(length(xHis3_1(:,1)), len-length(xHis3_1(1,:)));
xHis3_1 = [xHis3_1 tmp];
tmp = zeros(1,len-length(r1(1,:)));
r1 = [r1 tmp];
tmp = zeros(2,len-length(r1(1,:))+1);


time = (0:0.1:(len/10)-0.1);

figure;
plot(time',xHis3_2(13,:),'k');
hold on
plot(time',xHis3_1(13,1:length(time)),'r');
legend('ホライズン固定', 'ホライズン可変');
grid on
xlabel('Time [s]');
ylabel('xJerk [m/s^3]');
savefig('xJerk.fig');

figure;
plot(time',xHis3_2(1,:),'k')
hold on
plot(time',xHis3_1(1,1:length(time)),'r')
legend('ホライズン固定', 'ホライズン可変');
grid on
xlabel('Time [s]');
ylabel('Velocity [m/s]');
savefig('velocity.fig');

figure;
plot(time',xHis3_2(9,:),'k')
hold on
plot(time',xHis3_1(9,1:length(time)),'r')
legend('ホライズン固定', 'ホライズン可変');
grid on
xlabel('Time [s]');
ylabel('xAcceleration [m/s^2]');
savefig('xAcceleration.fig');

figure;
plot(time',xHis3_2(10,:),'k')
hold on
plot(time',xHis3_1(10,1:length(time)),'r')
legend('ホライズン固定', 'ホライズン可変');
grid on
xlabel('Time [s]');
ylabel('yAcceleration [m/s^2]');
savefig('yAcceleration.fig');

figure;
plot(time',r2(1,:),'k')
hold on
plot(time',r1(1:length(time)),'r')
legend('ホライズン固定', 'ホライズン可変');
grid on
xlabel('Time [s]');
ylabel('d(t)');
savefig('dt.fig');

figure;
plot(time',xHis3_2(14,:),'k')
hold on
plot(time',xHis3_1(14,1:length(time)),'r')
legend('ホライズン固定', 'ホライズン可変');
grid on
xlabel('Time [s]');
ylabel('yJerk [m/s^3]');
savefig('yJerk.fig');

figure;
plot(time',xHis3_2(4,:),'k')
hold on
plot(time',xHis3_1(4,1:length(time)),'r')
legend('ホライズン固定', 'ホライズン可変');
grid on
xlabel('Time [s]');
ylabel('Yaw rate [rad/s]');
savefig('yawrate.fig');

figure;
plot(time',xHis3_2(3,:),'k')
hold on
plot(time',xHis3_1(3,1:length(time)),'r')
legend('ホライズン固定', 'ホライズン可変');
grid on
xlabel('Time [s]');
ylabel('Sideslip angle [rad]');
savefig('slipside.fig');

figure;
plot(time',mvHis2(1,1:length(time)),'k')
hold on
plot(time',mvHis1(1,1:length(time)),'r')
legend('ホライズン固定', 'ホライズン可変');
grid on
xlabel('Time [s]');
ylabel('jerk [m/s^3]');
savefig('inputJerk.fig');

figure;
plot(time',mvHis2(2,1:length(time)),'k')
hold on
plot(time',mvHis1(2,1:length(time)),'r')
legend('ホライズン固定', 'ホライズン可変');
grid on
xlabel('Time [s]');
ylabel('delta [rad]');
savefig('inputDelta.fig');