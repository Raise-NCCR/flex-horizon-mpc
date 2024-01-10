function [r,a_y,da_y,xJerk] = ridecomfort(Ts,xHistory,mvHistory)
    q_r = 0.5;
    r1 = ridecomfort_x(Ts,xHistory(1,:),mvHistory(1,:));
    [r2,a_y,da_y,xJerk] = ridecomfort_y(Ts,xHistory,mvHistory);
    r = r1+q_r*r2;
end

