function [x, y, theta, v, w] = create_piecewise_path(step, k_i, k_f)

    s = [0:step:1];
    
    x_i = [0, 4, 6, 4, 2, 0, 0, -2, -4, -2];
    x_f = [4, 6, 4, 2, 0, 0, -2, -4, -2, 0];
    y_i = [0, 0, 2, 4, 4, 2, -2, -4, -2, 0];
    y_f = [0, 2, 4, 4, 2, -2, -4, -2, 0, 0];
    theta_i = [0, 0, pi/2, pi, pi, -pi/2, -pi/2, pi, pi/2, 0];
    theta_f = [0, pi/2, pi, pi, -pi/2, -pi/2, pi, pi/2, 0, 0];
    
    for i = 1:length(x_i)
        [x_cell{i},y_cell{i},theta_cell{i},v_cell{i},w_cell{i}] = compute_path(s,x_i(i),y_i(i),theta_i(i),x_f(i),y_f(i),theta_f(i),k_i,k_f,step);
    end
    
    x = cell2mat(x_cell);
    y = cell2mat(y_cell);
    theta = cell2mat(theta_cell);
    v = cell2mat(v_cell);
    w = cell2mat(w_cell);
    
    figure
    title('Path','Interpreter','latex')
    plot(x,y)
    axis equal
    
    figure
    title('Velocities $v$ and $w$','Interpreter','latex')
    plot(s,v)
    hold on
    plot(s,w)

end

