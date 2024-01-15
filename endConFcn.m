function y = endConFcn(x, u, wb, Ts, inCurve, inStopping)

    load("zhouXYPath.mat");
    
    pred_px_1s = x(1,6) + 3 * (cos(x(1,5)) * x(1,1) - sin(x(1,5)) * x(1,1) * x(1,3));
    pred_py_1s = x(1,7) + 3 * (sin(x(1,5)) * x(1,1) + cos(x(1,5)) * x(1,1) * x(1,3));
    pred_px_2s = x(1,6) + 3 * (cos(x(1,5)) * x(1,1) - sin(x(1,5)) * x(1,1) * x(1,3));
    pred_py_2s = x(1,7) + 3 * (sin(x(1,5)) * x(1,1) + cos(x(1,5)) * x(1,1) * x(1,3));
    pred_px_3s = x(1,6) + 3 * (cos(x(1,5)) * x(1,1) - sin(x(1,5)) * x(1,1) * x(1,3));
    pred_py_3s = x(1,7) + 3 * (sin(x(1,5)) * x(1,1) + cos(x(1,5)) * x(1,1) * x(1,3));

    pred_1s = dsearchn(pathRef(1:2,:)', [pred_px_1s pred_py_1s]);
    pred_2s = dsearchn(pathRef(1:2,:)', [pred_px_2s pred_py_2s]);
    pred_3s = dsearchn(pathRef(1:2,:)', [pred_px_3s pred_py_3s]);

    c = pathRef(3, pred_1s);
    if (any(isnan(c), 'all'))
        refV_1s = 30/3.6;
    elseif(c > 0.0166)
        refV_1s = 30/3.6;
    elseif(c > 0.01)
        refV_1s = 40/3.6;
    elseif (c > 0.006)
        refV_1s = 50/3.6;
    else
        refV_1s = 60/3.6;
    end

    c = pathRef(3, pred_2s);
    if (any(isnan(c), 'all'))
        refV_2s = 30/3.6;
    elseif(c > 0.0166)
        refV_2s = 30/3.6;
    elseif(c > 0.01)
        refV_2s = 40/3.6;
    elseif (c > 0.006)
        refV_2s = 50/3.6;
    else
        refV_2s = 60/3.6;
    end

    c = pathRef(3, pred_3s);
    if (any(isnan(c), 'all'))
        refV_3s = 30/3.6;
    elseif(c > 0.0166)
        refV_3s = 30/3.6;
    elseif(c > 0.01)
        refV_3s = 40/3.6;
    elseif (c > 0.006)
        refV_3s = 50/3.6;
    else
        refV_3s = 60/3.6;
    end

    y = [x(10,1)-refV_1s; x(20,1)-refV_2s; x(30,1)-refV_3s];
end