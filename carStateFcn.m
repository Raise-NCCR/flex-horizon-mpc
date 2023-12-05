function xk1 = carStateFcn(xk, u)

uk = u(1:2);
Ts = u(3);
k = u(4);
xk1 = carDT(xk, uk, Ts, k);