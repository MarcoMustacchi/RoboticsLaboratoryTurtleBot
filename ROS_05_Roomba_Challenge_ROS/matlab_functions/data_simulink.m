function [x_sim,y_sim,x_dot_sim,y_dot_sim,x_dot_dot_sim,y_dot_dot_sim,theta_sim] = data_simulink(t,x,y,x_dot,y_dot,x_dot_dot,y_dot_dot,theta)

    x_sim = [t, x];
    y_sim = [t, y];
    x_dot_sim = [t, x_dot];
    y_dot_sim = [t, y_dot];
    x_dot_dot_sim = [t, x_dot_dot];
    y_dot_dot_sim = [t, y_dot_dot];

    theta_sim = [t, theta];

end

