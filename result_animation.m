clear all;
clc;

load('path.mat');
% load('zhouXYPath.mat');
load('xHistory3-1.mat');

figure(3);
plot(pathRef(1,:), pathRef(2,:));
axis equal;

%%

carWB = 0.3;
carFrame = 0.2;

hold on;

% point that represents front tire
rearX = xHistory(6,1);
rearY = xHistory(6,2);
rearTire = plot(rearX, rearY, 'o', 'MarkerSize' ,5, 'MarkerFaceColor', 'r');

% % point that represents front tire
% frontX = xHistory(6,1) + carWB * cos(xHistory(6,3));
% frontY = xHistory(6,2) + carWB * sin(xHistory(6,3));
% frontTire = plot(xHistory(6,1), xHistory(6,2), 'o', 'MarkerSize' ,5, 'MarkerFaceColor', 'b');

% rectangle that represents car
% carPos =  [(rearX-carFrame) (rearY-carFrame) (carWB+2*carFrame) (2*carFrame)]';
% carX = [(rearX-carFrame) (rearX+carWB+carFrame) (rearX+carWB+carFrame) (rearX-carFrame)];
% carY = [(rearY-carFrame) (rearY-carFrame) (rearY+carFrame) (rearY+carFrame)];
% car = patch('XData', carX, 'YData', carY, 'FaceColor', 'none');

carPath = plot(xHistory(6,1), xHistory(7,1), 'Color', '#D95319');

xlim([-10, 100]);
ylim([-10, 100]);

legend("reference", "car");
title("Vehicle Control by Non-linear MPC");
xlabel("x");
ylabel("y");

hold off;

myVideo = VideoWriter('MPC_car_result'); %open video file
myVideo.FrameRate = 15;  %can adjust this, 5 - 10 works well for me
open(myVideo)

for t = 1:length(xHistory(6,:))
    rearX = xHistory(6,t); % rear tire position x
    rearY = xHistory(7,t); % front tire position y
    set(rearTire, 'XData', rearX, 'YData', rearY); % update rearTire place
    
    % frontX = xHistory(6,t) + carWB * cos(xHistory(7,t)); % front tire position x
    % frontY = xHistory(7,t) + carWB * sin(xHistory(7,t)); % front tire position y
    % set(frontTire, 'XData', frontX, 'YData', frontY); % update frontTire place
    
    % carX = [(rearX-carFrame) (rearX+carWB+carFrame) (rearX+carWB+carFrame) (rearX-carFrame)];
    % carY = [(rearY-carFrame) (rearY-carFrame) (rearY+carFrame) (rearY+carFrame)];
    % set(car, 'XData', carX, 'YData', carY);
    direction = [0 0 1];
    deg = xHistory(7,t) * 180 / 3.14159265;
    tireOrigin = [rearX, rearY, 0];
    % rotate(car, direction, deg, tireOrigin); % rotate rectangle
    
    set(carPath, 'XData', xHistory(6,1:t), 'YData', xHistory(7,1:t));
    
    drawnow; % update figure
    
    frame = getframe(gcf); % get frame
    writeVideo(myVideo, frame);
    
    pause(0.05);
end

close(myVideo)