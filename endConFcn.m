function y = endConFcn(x, u, wb, Ts, inCurve, inStopping)

    % load("zhouXYPath.mat");

    % global pathRef
    
    % pred_px_1s = x(1,6) + 3 * (cos(x(1,5)) * x(1,1) - sin(x(1,5)) * x(1,1) * x(1,3));
    % pred_py_1s = x(1,7) + 3 * (sin(x(1,5)) * x(1,1) + cos(x(1,5)) * x(1,1) * x(1,3));
    % pred_px_2s = x(1,6) + 3 * (cos(x(1,5)) * x(1,1) - sin(x(1,5)) * x(1,1) * x(1,3));
    % pred_py_2s = x(1,7) + 3 * (sin(x(1,5)) * x(1,1) + cos(x(1,5)) * x(1,1) * x(1,3));
    % pred_px_3s = x(1,6) + 3 * (cos(x(1,5)) * x(1,1) - sin(x(1,5)) * x(1,1) * x(1,3));
    % pred_py_3s = x(1,7) + 3 * (sin(x(1,5)) * x(1,1) + cos(x(1,5)) * x(1,1) * x(1,3));
    % 
    % pred_1s = dsearchn(pathRef(1:2,:)', [pred_px_1s pred_py_1s]);
    % pred_2s = dsearchn(pathRef(1:2,:)', [pred_px_2s pred_py_2s]);
    % pred_3s = dsearchn(pathRef(1:2,:)', [pred_px_3s pred_py_3s]);
    % 
    % [c, i] = max([abs(pathRef(3, pred_1s)); abs(pathRef(3, pred_2s)); abs(pathRef(3, pred_3s))]);
    % 
    % if (any(isnan(c), 'all'))
    %     refV = 20/3.6;
    % elseif(c > 0.03)
    %     refV = 20/3.6;
    % elseif(c > 0.0154)
    %     refV = 30/3.6;
    % elseif(c > 0.01)
    %     refV = 40/3.6;
    % elseif (c > 0.006)
    %     refV = 50/3.6;
    % else
    %     refV = 60/3.6;
    % end
    % 
    % if (i == 1)
    %     V = x(10,1);
    % elseif (i == 2)
    %     V = x(20,1);
    % else
    %     V = x(30,1);
    % end
    % 
    % V
    % refV

    y = x(2,13);
end