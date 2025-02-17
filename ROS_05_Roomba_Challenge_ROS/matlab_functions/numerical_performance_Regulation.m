function custom_SettlingTime_XY = numerical_performance_Regulation(out, boundary_threshold_XY)
    
    %% Find first instant of Regulation
    idx = find(out.tracking.signals.values, 1, 'first');

    %% XY
    x_out = out.output.signals.values(idx:end,1);
    y_out = out.output.signals.values(idx:end,2);
    x_des = zeros(length(x_out),1);
    y_des = zeros(length(y_out),1);
    distance = sqrt((x_des-x_out).^2+(y_des-y_out).^2);

    %%
    upper_bound_XY = +boundary_threshold_XY;
    lower_bound_XY = -boundary_threshold_XY;
    array_logical_XY = distance > lower_bound_XY & distance < upper_bound_XY;
    % Idea: find last element in a vector which all consecutive values are
    % different, then add 1 index to find index s.t. all successive are equal to 1 
    % (satisfy condition trajectory inside boundary)
    array_successive_XY = diff(array_logical_XY); % array with 1 when successive value is different, 0 otherwise
    idx_XY = find(array_successive_XY==1)+1;
    
    if ~any(idx_XY) % all zeros values
        fprintf(2,'No values satisfying the boundary condition. \n') % 2 for standard error
        custom_SettlingTime_XY = NaN;
    else
        last_idx_XY = idx_XY(end); % vogliamo che sia Settling Time, ovvero che dopo rimanga all'interno del Threshold
        custom_SettlingTime_XY = out.output.time(idx+last_idx_XY);
    end

end