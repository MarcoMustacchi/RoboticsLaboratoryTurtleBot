close all
clear
clc

%% Recall
% if simulation through Simulink, variable to workspace is called out.
% if simulation through MATLAB, variable to workspace is called ans.

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

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%                             Tracking                                %%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% Trajectory tracking control
% State Feedback - Controller definition
a = 3; zeta = 1.5;

% Output Feedback - Controller definition
b = 0.25; k1 = 1; k2 = 1;

% Z Feedback - Controller definition
k_p1 = 5; k_p2 = 5; k_d1 = 1; k_d2 = 1; 

% Simulation - Tracking
trajectory_type = {'Eight_','Square_Non_Smooth_','Square_Smooth_','Line_Follower_'};

%% Eight Shape
run('./matlab_functions/Eight_Path.m')
trajectory_name = trajectory_type(1);

% Decide initial pose
disp(['Reference trajectory has initial x of: ', num2str(x_sim(1,2))])
disp(['Reference trajectory has initial y of: ', num2str(y_sim(1,2))])
disp(['Reference trajectory has initial theta of: ', num2str(rad2deg(theta(1)))])

ic = input(['Initial pose robot [x,y,theta] specified as array [], with theta in degree: '])
unicycle.ic.x = ic(1); unicycle.ic.y = ic(2); unicycle.ic.theta = deg2rad(ic(3));

% wrong parameters
unicycle.r = 0.0340; unicycle.d = 0.1650;

unicycle.r = 0.340; unicycle.d = 0.1650;

run('./matlab_functions/Automated_Tracking.m')

%% Square Path - Non smooth
run('./matlab_functions/Square_Path_Non_Smooth.m')
trajectory_name = trajectory_type(2);

% Decide initial pose
disp(['Reference trajectory has initial x of: ', num2str(x_sim(1,2))])
disp(['Reference trajectory has initial y of: ', num2str(y_sim(1,2))])
disp(['Reference trajectory has initial theta of: ', num2str(rad2deg(theta(1)))])

ic = input(['Initial pose robot [x,y,theta] specified as array [], with theta in degree: '])
unicycle.ic.x = ic(1); unicycle.ic.y = ic(2); unicycle.ic.theta = deg2rad(ic(3));

run('./matlab_functions/Automated_Tracking.m')

%% Square Path - Smooth
run('./matlab_functions/Square_Path_Smooth.m')
trajectory_name = trajectory_type(3);

% Decide initial pose
disp(['Reference trajectory has initial x of: ', num2str(x_sim(1,2))])
disp(['Reference trajectory has initial y of: ', num2str(y_sim(1,2))])
disp(['Reference trajectory has initial theta of: ', num2str(rad2deg(theta(1)))])

ic = input(['Initial pose robot [x,y,theta] specified as array [], with theta in degree: '])
unicycle.ic.x = ic(1); unicycle.ic.y = ic(2); unicycle.ic.theta = deg2rad(ic(3));

run('./matlab_functions/Automated_Tracking.m')

%% Line Follower Path
run('./matlab_functions/Line_Follower_Path.m')
trajectory_name = trajectory_type(4);

% Decide initial pose
disp(['Reference trajectory has initial x of: ', num2str(x_sim(1,2))])
disp(['Reference trajectory has initial y of: ', num2str(y_sim(1,2))])
disp(['Reference trajectory has initial theta of: ', num2str(rad2deg(theta(1)))])

ic = input(['Initial pose robot [x,y,theta] specified as array [], with theta in degree: '])
unicycle.ic.x = ic(1); unicycle.ic.y = ic(2); unicycle.ic.theta = deg2rad(ic(3));

run('./matlab_functions/Automated_Tracking.m')


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%                            Regulation                               %%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% Cartesian Regulation 
% Controller definition
K_v = 1;
K_w = 1;

% IC and FC
ic = input(['Initial pose robot [x,y,theta] specified as array [], with theta in degree: '])
unicycle.ic.x = ic(1); unicycle.ic.y = ic(2); unicycle.ic.theta = deg2rad(ic(3));

fc = input(['Final position robot Cartesian Regulation [x,y] specified as array []: '])
x_f = fc(1); y_f = fc(2);

% Simulation
StopTime = 100;
Ts = unicycle.Ts;
% Ts = t(2);
run('./matlab_functions/Automated_Cartesian_Regulation.m')

figure
plot(ans.output.signals.values(:,3))
% comincia ad andare verso il basso, per cui inizia positivo e poi diminuisce

%% Posture Regulation - Singularity
% Controller definition
k1 = 2;
k2 = 2;
k3 = 1;

% IC and FC
ic = input(['Initial pose robot [x,y,theta] specified as array [], with theta in degree: '])
unicycle.ic.x = ic(1); unicycle.ic.y = ic(2); unicycle.ic.theta = deg2rad(ic(3));

fc = input(['Final pose robot Posture Regulation [x,y,theta] specified as array [], with theta in degree:'])
x_f = fc(1); y_f = fc(2); theta_f = deg2rad(fc(3));

% Simulation
StopTime = 100;
Ts = unicycle.Ts;
% Ts = t(2);
run('./matlab_functions/Automated_Posture_Singularity.m')

%% Posture Regulation - NO Singularity
% Controller definition
k1 = 3;
k2 = 3;
k3 = 1;

% IC and FC
ic = input(['Initial pose robot [x,y,theta] specified as array [], with theta in degree: '])
unicycle.ic.x = ic(1); unicycle.ic.y = ic(2); unicycle.ic.theta = deg2rad(ic(3));

fc = input(['Final pose robot Posture Regulation [x,y,theta] specified as array [], with theta in degree:'])
x_f = fc(1); y_f = fc(2); theta_f = deg2rad(fc(3));

% Simulation
StopTime = 100;
Ts = unicycle.Ts;
% Ts = t(2);
run('./matlab_functions/Automated_Posture_NO_Singularity.m')


%% Animation
% Create map and Animation final 
M = zeros(10); % 10x10 environment
% M(2:end-1,2:end-1) = 0; % matrix that has 1 in ther borders
bin = boolean(M);
map = binaryOccupancyMap(bin,'GridOriginInLocal',[-5,-5]);

time = ans.output.time;
trajectory.x = ans.output.signals.values(:,1); 
trajectory.y = ans.output.signals.values(:,2); 
trajectory.theta =  deg2rad(ans.output.signals.values(:,3));

filename = 'trajectory.gif';
plot_animation_vehicle(map, time, trajectory, filename);
