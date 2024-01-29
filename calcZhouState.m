load('zhouHis.mat');
zhouState = zeros(14,2000+length(zhouHistory(9,:)));
zhouState(:,1) = [16.7; 0; 0; 0; 0; 0; 0; 0; 0; 0; 0; 0; 0; 0];
Ts = 0.001;
for i = 1:(2000+length(zhouHistory(9,:))-1)
    jerk = 0;
    delta = 0;
    if (i > 2000)
        jerk = zhouHistory(9,i-2000);
        delta = zhouHistory(10,i-2000);
    end
    dx = carCT(zhouState(:,i), [jerk; delta]);
    zhouState(1:7,i+1) = zhouState(1:7,i) + Ts * dx(1:7)';
    zhouState(8:14,i+1) = [0; dx(8); dx(9); dx(3); dx(4); dx(10); dx(11)];
end
save('zhouState', 'zhouState');

% r = ridecomfort(Ts,zhouState);

% time = (0:Ts:5);
% 
% subplot(2,5,1);
% plot(time',zhouState(13,1:end),'r');
% legend('従来法','提案法');
% grid on
% xlabel('Time [s]');
% ylabel('xJerk [m/s^3]');
% subplot(2,5,2);
% plot(time',zhouState(1,1:end),'r')
% legend('従来法','提案法');
% grid on
% xlabel('Time [s]');
% ylabel('Velocity [m/s]');
% subplot(2,5,3);
% plot(time',zhouState(9,1:end),'r')
% legend('従来法','提案法');
% grid on
% xlabel('Time [s]');
% ylabel('Acceleration [m/s^2]');
% subplot(2,5,4);
% plot(time',zhouState(10,1:end),'r')
% legend('従来法','提案法');
% grid on
% xlabel('Time [s]');
% ylabel('Lateral acceleration [m/s^2]');
% subplot(2,5,5);
% plot(time',zhouState(4,1:end),'r')
% legend('従来法','提案法');
% grid on
% xlabel('Time [s]');
% ylabel('Yaw rate [rad/s]');
% subplot(2,5,6);
% plot(time',zhouState(3,1:end),'r')
% legend('制御なし','従来法','提案法');
% grid on
% xlabel('Time [s]');
% ylabel('Sideslip angle [rad]');
% subplot(2,5,7);
% plot(time',r(1:end),'r')
% legend('従来法','提案法');
% grid on
% xlabel('Time [s]');
% ylabel('d(t)');
% subplot(2,5,8);
% plot(time',zhouState(2,1:end),'r')
% legend('従来法','提案法');
% grid on
% xlabel('Time [s]');
% ylabel('yJerk [m/s^3]');
% subplot(2,5,9);
% plot(time',mvHistory(1,1:length(time)),'r')
% legend('従来法','提案法');
% grid on
% xlabel('Time [s]');
% ylabel('inputJerk [m/s^3]');
% subplot(2,5,10);
% plot(time',mvHistory(2,1:length(time)),'r')
% legend('従来法','提案法');
% grid on
% xlabel('Time [s]');
% ylabel('inputDelta [rad/s]');
% 

kRef = curvatures(zhouState(6,:), zhouState(7,:));
pathRef = zeros(3,2000+length(zhouHistory(9,:)));
pathRef(1:3,:) = [zhouState(6,:); zhouState(7,:); kRef];

save('zhouXYPath', 'pathRef');

