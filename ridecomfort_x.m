function r = ridecomfort_x(Ts,xState)

ax = xState(9,:);
xJerk = xState(13,:);

%debug%
%N=0.1;Tf=3.5;
%a=[0,randi([-5,5],1,34)];
%da=[0,randi([-5,5],1,34)];
%debug%
num = length(xState(13,:));
pt = 3;
s = pt/Ts;
b_1 = 0.19;
b_2 = 0.53;
b_3 = 0.27;
b_4 = 0.34;
% b_1 = 0.15;
% b_2 = 0.57;
% b_3 = 0.2;
% b_4 = 0.29;
for i=1:1:num
    
        
            tmp_a(i) = ax(i);
            %tmp_ma = find(tmp_a < 0); %負の値を探す
            tmp_da(i) = xJerk(i);
            
     if(i <= s) %3秒間まで
%             ap(i) = max(tmp_a); %正のピーク値を探す
%             am(i) = abs(min(tmp_a(find(tmp_a<=0)))); %負のピーク値の絶対値を探す

        if (isempty((find(tmp_a >= 0)))) %正の値がなかったら
            ap(i) = 0;
            am(i) = abs(min(tmp_a(find(tmp_a<=0))));
            
        elseif(isempty((find(tmp_a < 0)))) %負の値がなかったら
            ap(i) = max(tmp_a);
            am(i) = 0;
        elseif(max(tmp_a) >= abs(min(tmp_a(find(tmp_a<=0)))))
            ap(i) = max(tmp_a);
            am(i) = 0; 
        else
            ap(i) =0;
            am(i) = abs(min(tmp_a(find(tmp_a<=0)))); 
    
        end
        
            heikin = mean(tmp_da);
            sum = 0;
            
        if(heikin > 0)
           for j=1:1:i
             sum = sum + tmp_da(j)^2;
           end
             jrp(i) = sqrt(sum/i);  
             jrm(i) = 0;
        else
           for j=1:1:i
             sum = sum+tmp_da(j)^2;
           end
             jrm(i) = sqrt(sum/i); 
             jrp(i) = 0;
        end
    
    else %3秒以上のとき
       l=1;
        for k=i-s:1:i
            tmp_a2(l) = ax(k);
            tmp_da2(l) = xJerk(k);
          l=l+1;
        end
        
        if (isempty((find(tmp_a2 >= 0))))
            ap(i) = 0;
            am(i) = abs(min(tmp_a2(find(tmp_a2<=0))));
            
        elseif(isempty((find(tmp_a2 < 0))))
            ap(i) = max(tmp_a2);
            am(i) = 0;
        elseif(max(tmp_a2) >= abs(min(tmp_a2(find(tmp_a2<=0)))))
            ap(i) = max(tmp_a2);
            am(i) = 0; 
        else
            ap(i) =0;
            am(i) = abs(min(tmp_a2(find(tmp_a2<=0)))); 
        end
        
       
        
        heikin = mean(tmp_da2);
        sum=0;
        
         if(heikin > 0)
           for j=1:1:s
             sum = sum + tmp_da2(j)^2;
           end
             jrp(i) = sqrt(sum*Ts/pt);  
             jrm(i) = 0;
        else
           for j=1:1:s
             sum = sum+tmp_da2(j)^2;
           end
             jrm(i) = sqrt(sum*Ts/pt); 
             jrp(i) = 0;
        end
        
         
    end
    
    r(i) = b_1*ap(i) + b_2*am(i) + b_3*jrp(i) + b_4*jrm(i);
    
end
end