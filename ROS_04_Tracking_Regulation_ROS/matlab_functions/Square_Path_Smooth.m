%% Square trajectory - Smooth
k_i = 1; k_f = 1;
step_size = 0.01;
s = 0:step_size:1-step_size;

x_i = [0, 2, 2.5, 2.5, 2, 0, -0.5, -0.5];
x_f = [2, 2.5, 2.5, 2, 0, -0.5, -0.5, 0];
y_i = [0, 0, 0.5, 2.5, 3, 3, 2.5, 0.5];
y_f = [0, 0.5, 2.5, 3, 3, 2.5, 0.5, -0];
theta_i = [0, 0, pi/2, pi/2, pi, pi, -pi/2, -pi/2];
theta_f = [0, pi/2, pi/2, pi, pi, -pi/2,-pi/2, 0];

for i = 1:length(x_i)
    [x_cell{i},y_cell{i}] = compute_path(s,x_i(i),y_i(i),theta_i(i),x_f(i),y_f(i),theta_f(i),k_i,k_f);
end

x = cell2mat(x_cell);
y = cell2mat(y_cell);

figure
hold all
plot(x,y,'LineWidth',1)
plot(x(1), y(1), 'go');
plot(x(end), y(end), 'rx');
hold off
grid on
axis equal

s = 0:step_size:8-step_size; % to modify
s = transpose(s); x = transpose(x); y = transpose(y);

% Trajectory generation
filenamePlot = '../figure/Square_Smooth_Before_After_Timing_Law.pdf';
[t,x_dot,y_dot,x_dot_dot,y_dot_dot,theta,v_d,w_d] = trajectory_generation(unicycle,s,x,y,filenamePlot);

% Data for Simulink
[x_sim,y_sim,x_dot_sim,y_dot_sim,x_dot_dot_sim,y_dot_dot_sim,theta_sim] = data_simulink(t,x,y,x_dot,y_dot,x_dot_dot,y_dot_dot,theta);
