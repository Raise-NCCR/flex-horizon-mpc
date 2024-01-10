function y = endConFcn(x, u, wb, Ts, inCurve, inStopping)
    y = [u(end,1); x(end,2);];
end