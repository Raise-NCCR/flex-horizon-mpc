function xk1 = carStateFcn(xk, u)

uk = u(1:2);
Ts = u(3);
inCurve = u(4);
inStopping = u(5);
xk1 = carDT(xk, uk, Ts, inCurve, inStopping);