load('zhouHis.mat');
zhouState = zeros(14,length(zhouHistory(9,:))+1);
zhouState(:,1) = [0; 16.7; 0; 0; 0; 0; 0; 0; 0; 0; 0; 0; 0; 0];
Ts = 0.001;
for i = 1:length(zhouHistory(9,:))
    dx = carCT(zhouState(:,i), zhouHistory(9:10,i));
    zhouState(1:9,i+1) = zhouState(1:9,i) + Ts * dx(1:9)';
    zhouState(10:13,i+1) = [0;0;0;0];
    zhouState(14,i+1) = zhouState(14,i) + Ts * dx(10)';
end
save('zhouState', 'zhouState');

kRef = curvatures(zhouState(8,:), zhouState(9,:));
pathRef(3,:) = kRef;

save('zhouXYPath', 'pathRef');

