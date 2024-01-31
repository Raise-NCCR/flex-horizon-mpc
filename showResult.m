load("xHistory3-1-3.mat");
load("mvHistory3-1-3.mat");

xHis3_1 = xHistory;
mvHis1 = mvHistory;

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

% load('zhouState.mat');
% load('zhouHis.mat');
% 
% zhouR = ridecomfort(Ts,zhouState(:, 1:100:end));
% 
% zhouRes = zeros(10,length(time));
% % zhouRes(:,1:length(zhouState(9,1:100:end))) = [zhouState(13,1:100:end);
% %     zhouState(1,1:100:end);
% %     zhouState(9,1:100:end);
% %     zhouState(10,1:100:end);
% %     zhouState(4,1:100:end);
% %     zhouState(3,1:100:end);
% %     zhouR;
% %     zhouState(2,1:100:end)];
% 
% zhouRes(:,1:length(time)-10) = [zhouHistory(1,1:100:6001);
%     zhouHistory(2,1:100:6001);
%     zhouHistory(3,1:100:6001);
%     zhouHistory(4,1:100:6001);
%     zhouHistory(5,1:100:6001);
%     zhouHistory(6,1:100:6001);
%     zhouHistory(7,1:100:6001);
%     zhouHistory(8,1:100:6001);
%     zhouHistory(9,1:100:6001);
%     zhouHistory(10,1:100:6001)];

% zhouMV = zeros(2,length(time));
% zhouMV(:,21:length(zhouState(9,1:100:end))) = zhouHistory(9:10,1:100:end);

% figure;
% subplot(2,5,1);
% plot(time',zhouRes(1,:),'k')
% hold on
% subplot(2,5,2);
% plot(time',zhouRes(2,:),'k')
% hold on
% subplot(2,5,3);
% plot(time',zhouRes(3,:),'k')
% hold on
% subplot(2,5,4);
% plot(time',zhouRes(4,:),'k')
% hold on
% subplot(2,5,5);
% plot(time',zhouRes(5,:),'k')
% hold on
% subplot(2,5,6);
% plot(time',zhouRes(6,:),'k')
% hold on
% subplot(2,5,7);
% plot(time',zhouRes(7,:),'k')
% hold on
% subplot(2,5,8);
% plot(time',zhouRes(8,:),'k')
% hold on
% subplot(2,5,9);
% plot(time',zhouRes(9,:),'k')
% hold on
% subplot(2,5,10);
% plot(time',zhouRes(10,:),'k')
% hold on
% 
% subplot(2,5,1);
% plot(time',xHistory(13,1:length(time)),'b');
% hold on
% subplot(2,5,2);
% plot(time',xHistory(1,1:length(time)),'b')
% hold on
% subplot(2,5,3);
% plot(time',xHistory(9,1:length(time)),'b')
% hold on
% subplot(2,5,4);
% plot(time',xHistory(10,1:length(time)),'b')
% hold on
% subplot(2,5,5);
% plot(time',xHistory(4,1:length(time)),'b')
% hold on
% subplot(2,5,6);
% plot(time',xHistory(3,1:length(time)),'b')
% hold on
% subplot(2,5,7);
% plot(time',r(1:length(time)),'b')
% hold on
% subplot(2,5,8);
% plot(time',xHistory(14,1:length(time)),'b')
% hold on

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

% xHistory1 = xHistory;
% r1 = r;
% 
% load("xHistory2.mat");
% 
% r = ridecomfort(Ts,xHistory);
% 
% tmp = zeros(length(xHistory(:,1)), 10);
% 
% xHistory2 = [xHistory tmp];
% 
% tmp = zeros(1, 10);
% 
% r2 = [r tmp];
% 
% subplot(2,5,1);
% plot(time',xHistory(13,1:length(time)),'r');
% legend('従来法','提案法sim1', '提案法sim2');
% grid on
% xlabel('Time [s]');
% ylabel('xJerk [m/s^3]');
% subplot(2,5,2);
% plot(time',xHistory(1,1:length(time)),'r')
% legend('従来法','提案法sim1', '提案法sim2');
% grid on
% xlabel('Time [s]');
% ylabel('Velocity [m/s]');
% subplot(2,5,3);
% plot(time',xHistory(9,1:length(time)),'r')
% legend('従来法','提案法sim1', '提案法sim2');
% grid on
% xlabel('Time [s]');
% ylabel('Acceleration [m/s^2]');
% subplot(2,5,4);
% plot(time',xHistory(10,1:length(time)),'r')
% legend('従来法','提案法sim1', '提案法sim2');
% grid on
% xlabel('Time [s]');
% ylabel('Lateral acceleration [m/s^2]');
% subplot(2,5,5);
% plot(time',xHistory(4,1:length(time)),'r')
% legend('従来法','提案法sim1', '提案法sim2');
% grid on
% xlabel('Time [s]');
% ylabel('Yaw rate [rad/s]');
% subplot(2,5,6);
% plot(time',xHistory(3,1:length(time)),'r')
% legend('従来法','提案法sim1', '提案法sim2');
% grid on
% xlabel('Time [s]');
% ylabel('Sideslip angle [rad]');
% subplot(2,5,7);
% plot(time',r(1:length(time)),'r')
% legend('従来法','提案法sim1', '提案法sim2');
% grid on
% xlabel('Time [s]');
% ylabel('d(t)');
% subplot(2,5,8);
% plot(time',xHistory(14,1:length(time)),'r')
% legend('従来法','提案法sim1', '提案法sim2');
% grid on
% % xlabel('Time [s]');
% % ylabel('yJerk [m/s^3]');
% % subplot(2,5,9);
% % plot(time',mvHistory(1,1:length(time)),'r')
% % legend('従来法','提案法');
% % grid on
% % xlabel('Time [s]');
% % ylabel('inputJerk [m/s^3]');
% % subplot(2,5,10);
% % plot(time',mvHistory(2,1:length(time)),'r')
% % legend('従来法','提案法');
% % grid on
% % xlabel('Time [s]');
% % ylabel('inputDelta [rad/s]');