function r = ridecomfort(Ts,xHistory)
    q_r = 0.5;
    r1 = ridecomfort_x(Ts,xHistory);
    r2 = ridecomfort_y(Ts,xHistory);
    r = r1+q_r*r2;
end

