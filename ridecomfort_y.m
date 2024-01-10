function[r,a_y,da_y,xJerk] = ridecomfort_y(N,x,u)

ax = x(1,:);
vx = x(2,:);
vy = x(3,:);
wz = x(4,:);
ye = x(5,:);
wze = x(6,:);
psi = x(7,:);
px = x(8,:);
py = x(9,:);
b = x(14,:);

xJerk = u(1,:);
delta = u(2,:);

mass = 1100;
caf = 32000;
car = 32000;
lf = 1.15;
lr = 1.35;
iz = 1600;


num = length(x(1,:));
a_y = zeros(1, num);
da_y = zeros(1, num);
for i=1:1:(num-1)
    bDot = 0;
    wzDot = ((2*caf*lf)/iz)*delta(i);
    a_y(i) = ((2*caf)/mass)*delta(i);
    if (vx(i) ~= 0)
        wzDot = wzDot - ((2*caf*lf-2*car*lr)/(iz*vx(i)))*vy(i) - ((2*caf*(lf^2)+2*car*(lr^2))/(iz*vx(i)))*wz(i);
        a_y(i) = a_y(i) - ((2*caf+2*car)/(mass*vx(i)))*vy(i) - vx(i)*wz(i)-((2*caf*lf-2*car*lr)/(mass*vx(i)))*wz(i);
        bDot = (a_y(i) * vx(i) - ax(i)*vy(i))/(vx(i)^2);
    end
    da_y(i) = ((2*caf+2*car)/mass)*bDot - ax(i)*wz(i) - vx(i)*wzDot
end

pt = 2;
s = pt/N;
c_1 = 1.08;%1.572
c_2 = 0.125;%0.343
for i=1:1:(num-1)
    
        
        tmp_a_y(i) = a_y(i);
        tmp_da_y(i) = da_y(i);
            
        sum1 = 0;
        sum2 = 0;
     if(i <= s) %2秒間まで
             

            
        for j=1:1:i
             sum1 = sum1 + tmp_a_y(j)^2;
             sum2 = sum2 + tmp_da_y(j)^2;
        end
             a_y_r(i) = sqrt(sum1/i);  
             j_y_r(i) = sqrt(sum2/i);
        
     else %2秒以上のとき  
        for k=i-s:1:i
             sum1 = sum1 + tmp_a_y(k)^2;
             sum2 = sum2 + tmp_da_y(k)^2;
        end   
             a_y_r(i) = sqrt(sum1/s);  
             j_y_r(i) = sqrt(sum2/s);
        
         
    end
    
    r(i) = c_1*a_y_r(i) + c_2*j_y_r(i);
    
end
end