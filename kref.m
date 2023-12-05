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

% xy = [0, 0;
%       200, -10;
%       500, 100;
%       700, 50;
%       850, 70;
%       1150, -150;];
  
p = 1:length(xy(:,1));
q = 1:0.05:length(xy(:,1));

% create car trajectory via xy points
x = spline(p, xy(:,1), q);
y = spline(p, xy(:,2), q);

xypath = [x', y'];
kRef = curvatures(xypath(:,1), xypath(:,2));

figure;
plot(xypath(:,1), xypath(:,2));
title("car reference trajectory");
xlabel("x");
ylabel("y");

save('xypath', 'xypath');

figure;
plot(1:length(kRef), kRef);
title("curvatures");
xlabel("i")
ylabel("k");

save('kref', 'kRef');