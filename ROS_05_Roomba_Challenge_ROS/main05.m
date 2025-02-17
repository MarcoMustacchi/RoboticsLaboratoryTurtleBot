close all
clear
clc

%% Recall
% if simulation through Simulink, variable to workspace is called out.
% if simulation through MATLAB, variable to workspace is called out.

%% Include subfolders for Simulink subsystems (otherwise for simulation trough MATLAB same folder..)
% when you you close MATLAB, path is restored
cd simulink_models\
addpath(genpath(pwd))
cd ..

%% Include subfolders for MATLAB functions
% when you you close MATLAB, path is restored
cd matlab_functions\
addpath(genpath(pwd))
cd ..

%% Load data
load_params_unicycle

r = 0.0328;
d = 0.1446;
Ts = 0.02;

%% Tracking - State Feedback Linear
Square_Path_Smooth_Inverted
% Square_Path_Smooth

trajectory_name = 'Square_Smooth_Inverted';

disp(['Reference trajectory has initial x of: ', num2str(x_sim(1,2))])
disp(['Reference trajectory has initial y of: ', num2str(y_sim(1,2))])
disp(['Reference trajectory has initial theta of: ', num2str(rad2deg(theta(1)))])

figure
plot(rad2deg(theta))

% Controller Gains for "Square Path - smooth"
a = 2; zeta = 0.7; 

% IC definition for "Square Path - smooth"  
unicycle.ic.x = x_sim(1,2); unicycle.ic.y = y_sim(1,2); unicycle.ic.theta = theta(1);

% Desired pose tracking
x_des = x_sim(end,2); y_des = y_sim(end,2); theta_des = rad2deg(theta(end)); % these are just for plot

% Output Feedback - Controller definition
b = 0.25; k1 = 1; k2 = 1;

%% Regulation
% FC definition
x_f = x_sim(1,2); y_f = y_sim(1,2); theta_f = theta(1); % already in radians, these are inserted in Simulink

% Posture Regulation - Singularity
k1 = 3; k2 = 3; k3 = 1;
% Cartesian Regulation
K_v = 1; K_w = 1;

%% Run simulation in Simulink
offset_x = out.output.signals.values(end,1);
offset_y = out.output.signals.values(end,2);
offset_theta = deg2rad(out.output.signals.values(end,3));

offset_x = 0
offset_y = 0
offset_theta = 0

%% Run again simulation in Simulink

%% Plots
filenamePlot = {'Simulation_Roomba_Challenge.pdf'};

figure
plot(out.tracking.time, out.tracking.signals.values)

x_des_plot = out.reference.signals.values(:,1); y_des_plot = out.reference.signals.values(:,2);
x_plot = out.output.signals.values(:,1); y_plot = out.output.signals.values(:,2); theta_plot = out.output.signals.values(:,3);
filenameXY = strcat('./figure/XY/XY_',string(trajectory_name),string(filenamePlot));
filenameCommands = strcat('./figure/Commands/Commands_',string(trajectory_name),string(filenamePlot));
filenameErrors = strcat('./figure/Errors/Errors_',string(trajectory_name),string(filenamePlot));
plot_XY_Tracking(x_des_plot, y_des_plot, x_plot, y_plot, theta_plot, filenameXY)
plot_Commands(out, unicycle, filenameCommands)
plot_Errors(out, filenameErrors, 1)

%% Animation
% Create map and Animation final 
M = zeros(10); % 10x10 environment
% M(2:end-1,2:end-1) = 0; % matrix that has 1 in ther borders
bin = boolean(M);
map = binaryOccupancyMap(bin,'GridOriginInLocal',[-5,-5]);

time = out.output.time;
trajectory.x = out.output.signals.values(:,1); 
trajectory.y = out.output.signals.values(:,2); 
trajectory.theta =  deg2rad(out.output.signals.values(:,3));

filename = 'trajectory.gif';
plot_animation_vehicle(map, time, trajectory, filename);

%% Print Simulink schemes
print('-sSimulation_Roomba_Challenge_Unwrap', '-dpdf','model.pdf')
print('-sRoomba_Challenge', '-dpdf','ROS_model.pdf')
print('-sboh', '-dpdf','switch.pdf')
print('-sFeedforward_ROS', '-dpdf','Feedforward.pdf')

print('-sPosture_Regulation_NO_Singularity_ROS', '-dpdf','ROS_scheme_Encoder.pdf')



%%
x_plot = out.output.signals.values(:,1); y_plot = out.output.signals.values(:,2); theta_plot = out.output.signals.values(:,3);
wr = out.reference.signals.values(:,1); wl = out.command.signals.values(:,2);

figure
plot(x_plot(4:end), y_plot(4:end),'LineWidth',1.5)

% boh -> 2:end
% boh2 -> 4:end
% boh3 -> 3:end

figure
plot(theta_plot)

figure
plot(wr)
figure
plot(wl)

