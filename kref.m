clear all;
clc;

xy = [0, 0; % (x,y) points where car moves
      500, 200;
      500, 500;
      100, 500;
      ];

xy = xy/2;

p = 1:length(xy(:,1));
q = 1:0.0002:length(xy(:,1));

% create car trajectory via xy points
x = spline(p, xy(:,1), q);
y = spline(p, xy(:,2), q);

kRef = curvatures(x, y);
pathRef = [x; y; kRef];


figure;
plot(pathRef(1,:), pathRef(2,:));
title("car reference trajectory");
xlabel("x[m]");
ylabel("y[m]");

save('path', 'pathRef');

figure;
plot(1:length(pathRef(3,:)), pathRef(3,:));
title("curvatures");
xlabel("i")
ylabel("k");
