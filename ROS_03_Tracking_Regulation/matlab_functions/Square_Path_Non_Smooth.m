%% Square trajectory - Non Smooth
step_size = 0.01; 
s = 0:step_size:3-step_size; % to modify
s = transpose(s);
x1 = s;
y1 = zeros(length(s),1);
x2 = zeros(length(s),1) + x1(end);
y2 = s;
x3 = x2(end) - s;
y3 = ones(length(y2),1) .* y2(end);
x4 = ones(length(x3),1) .* x3(end);
y4 = y3(end) - s;
x = [x1; x2; x3; x4];
y = [y1; y2; y3; y4];

figure
hold all
plot(x,y,'LineWidth',1)
plot(x(1), y(1), 'go');
plot(x(end), y(end), 'rx');
hold off
grid on
axis equal

s = 0:step_size:12-step_size; % to modify
s = transpose(s);

% Trajectory generation
filenamePlot = '../figure/Square_Non_Smooth_Before_After_Timing_Law.pdf';
[t,x_dot,y_dot,x_dot_dot,y_dot_dot,theta,v_d,w_d] = trajectory_generation(unicycle,s,x,y,filenamePlot);

figure
title(theta)
plot(rad2deg(theta))

% Data for Simulink
[x_sim,y_sim,x_dot_sim,y_dot_sim,x_dot_dot_sim,y_dot_dot_sim,theta_sim] = data_simulink(t,x,y,x_dot,y_dot,x_dot_dot,y_dot_dot,theta);

Ts = t(2);