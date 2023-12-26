clear all;
clc;

xy = [0, 0; % (x,y) points where car moves
      500, 0;
      800, 200;
      500, 600;
      200, 400;
      0, 100;
      -300, 600;
      -100, 800;
      300, 1000;
      700, 900;
      1000, 600];

xy = xy/4;

% xy = [0, 0;
%       200, -10;
%       500, 100;
%       700, 50;
%       850, 70;
%       1150, -150;];

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
xlabel("x");
ylabel("y");

save('path', 'pathRef');

figure;
plot(1:length(pathRef(3,:)), pathRef(3,:));
title("curvatures");
xlabel("i")
ylabel("k");
