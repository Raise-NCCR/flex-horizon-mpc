function r = ridecomfort_y(Ts,xState)

ay = xState(10,:);
yJerk = xState(14,:);

num = length(xState(1,:));

pt = 2;
s = pt/Ts;
c_1 = 1.08;%1.572
c_2 = 0.125;%0.343
for i=1:1:num
    
        
        tmp_a_y(i) = ay(i);
        tmp_da_y(i) = yJerk(i);
            
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