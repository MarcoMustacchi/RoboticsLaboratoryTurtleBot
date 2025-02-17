%% 8 shaped trajectory
% Specify waypoints, times of arrival, and sampling rate. 
step_size = 0.01; % to modify
s = 0:0.01:94; % to modify
s = transpose(s);
xc = 0;
yc = 0;
R = 2;
wd = 1/15;
x = xc + R*sin(wd.*s);
y = yc + R*sin(2*wd.*s);
figure
hold all
plot(x,y,'LineWidth',1)
plot(x(1), y(1), 'go');
plot(x(end), y(end), 'rx');
hold off
grid on
axis equal

% Trajectory generation
filenamePlot = '../figure/Eight_Before_After_Timing_Law.pdf';
[t,x_dot,y_dot,x_dot_dot,y_dot_dot,theta,v_d,w_d] = trajectory_generation(unicycle,s,x,y,filenamePlot);

figure
title(theta)
plot(rad2deg(theta))
    
% Data for Simulink
[x_sim,y_sim,x_dot_sim,y_dot_sim,x_dot_dot_sim,y_dot_dot_sim,theta_sim] = data_simulink(t,x,y,x_dot,y_dot,x_dot_dot,y_dot_dot,theta);

Ts = t(2);