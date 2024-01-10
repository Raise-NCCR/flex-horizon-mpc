load('zhouXHistory.mat');

Ts = 0.001;

px = 0;
py = 0;
psi = 0;

pathRef = zeros(3,length(X(1,:))+1);
pathRef(:,1) = [px; py; 0];

i = 1;
while i < length(X(1,:))+1
    v = X(2,i);
    beta = X(4,i);
    wz = X(5,i);
    px = px + Ts * (cos(psi) * v - sin(psi) * sin(beta) * v);
    py = py + Ts * (sin(psi) * v + cos(psi) * sin(beta) * v);
    psi = psi + Ts * wz;
    i = i + 1;
    pathRef(1,i) = px;
    pathRef(2,i) = py;
end

kRef = curvatures(pathRef(1,:), pathRef(2,:));
pathRef(3,:) = kRef;

save('zhouXYPath', 'pathRef');