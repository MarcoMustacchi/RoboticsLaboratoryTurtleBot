%% Trajectory generation
step_size = 0.01; % to modify
s = 0:step_size:15; % to modify
s = transpose(s);
xc = -3;
yc = 0;
R = 3;
wd = 1/3;
x = xc + R*cos(wd.*s);
y = yc + R*sin(wd.*s);

%% first method
x_dot = -R*sin(wd.*s)*wd;
y_dot = R*cos(wd.*s)*wd;
x_dot_dot = -R*cos(wd.*s)*wd^2;
y_dot_dot = -R*sin(wd.*s)*wd^2;

scale = 1;
t = s*scale; 

%% offline differential flatness
differential_flatness

%% chained form
z1 = thetad;
z2 = x.*cos(thetad) + y.*sin(thetad);
z3 = x.*sin(thetad) - y.*cos(thetad);

%% plot comparison
% plot_trajectory_comparison(x, y, thetad, z1, z2, z3, t);

%% second method
% probably better to use diff(x)./diff(t);
%{
% Velocities
x_dot = gradient(x)./gradient(t); % derivative of x w.r.t. t
y_dot = gradient(y)./gradient(t); % derivative of y w.r.t. t

% Accelerations
x_dot_dot = gradient(x_dot)./gradient(t); % derivative of x w.r.t. t
y_dot_dot = gradient(y_dot)./gradient(t); % derivative of y w.r.t. t

plot(x_dot_dot)
%}

%% Create data for simulink
x_sim = [t, x];
y_sim = [t, y];
x_dot_sim = [t, x_dot];
y_dot_sim = [t, y_dot];
x_dot_dot_sim = [t, x_dot_dot];
y_dot_dot_sim = [t, y_dot_dot];
