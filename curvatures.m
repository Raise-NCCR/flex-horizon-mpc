function c = curvatures(x, y)
    % c = 0.0;

    % for i = 2:length(x)-1
    %     dxn = x(i) - x(i - 1);
    %     dxp = x(i + 1) - x(i);
    %     dyn = y(i) - y(i - 1);
    %     dyp = y(i + 1) - y(i);
    %     dn = sqrt(dxn^2 + dyn^2);
    %     dp = sqrt(dxp^2 + dyp^2);
    %     dx = 1.0 / (dn + dp) * (dp / dn * dxn + dn / dp * dxp);
    %     ddx = 2.0 / (dn + dp) * (dxp / dp - dxn / dn);
    %     dy = 1.0 / (dn + dp) * (dp / dn * dyn + dn / dp * dyp);
    %     ddy = 2.0 / (dn + dp) * (dyp / dp - dyn / dn);
    %     curvature = (ddy * dx - ddx * dy) / ((dx ^ 2 + dy ^ 2) ^ 1.5);
    %     c = [c, curvature];
    % end

    dists = hypot(diff(x), diff(y));
    c = [0.0, 0.0];
    
    for i = 3:(length(x)-1)
        dx = (x(i+1) - x(i))/dists(i-1);
        dy = (y(i+1) - y(i))/dists(i-1);
        ddx = (x(i-2) - x(i-1) - x(i) + x(i+1))/(2*dists(i-1)^2);
        ddy = (y(i-2) - y(i-1) - y(i) + y(i+1))/(2*dists(i-1)^2);
        curvature = (ddy * dx - ddx * dy) / ((dx ^ 2 + dy ^ 2) ^ 1.5);
        c = [c, curvature];
    end

    c = [c, 0];
end