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

%% Feedforward
filename_plot = {'Feedforward.pdf'};

% Decide path
run('./matlab_functions/decide_Path.m')

figure
title('X')
plot(out.output.time, out.output.signals.values(:,1)) % x
hold on
plot(out.reference.time, out.reference.signals.values(:,1))

figure
title('Y')
plot(out.output.time, out.output.signals.values(:,2)) % y
hold on
plot(out.reference.time, out.reference.signals.values(:,2))

figure
title('Theta')
plot(out.output.time, out.output.signals.values(:,3)) % theta
hold on
plot(out.reference.time, out.reference.signals.values(:,3))

x_des = out.reference.signals.values(:,1); y_des = out.reference.signals.values(:,2);
x = out.output.signals.values(:,1); y = out.output.signals.values(:,2); theta = out.output.signals.values(:,3);
filenameXY = strcat('../figure/XY/XY_',string(trajectory_name),string(filename_plot));
filenameCommands = strcat('../figure/Commands/Commands_',string(trajectory_name),string(filename_plot));
plot_XY_Tracking(x_des, y_des, x, y, theta, filenameXY)
plot_Commands(out, unicycle, filenameCommands)

%% Tracking - State Feedback Linear
filename_plot = {'State_Feedback_Linear.pdf'};

% Decide path
run('./matlab_functions/decide_Path.m')
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Controller Gains for "Eight Shape"
a = 2; zeta = 0.7;  
% IC definition for "Eight Shape" 
unicycle.ic.x = -0.5; unicycle.ic.y = -0.5; unicycle.ic.theta = 63;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Controller Gains for "Square Path - Non smooth"
a = 4; zeta = 0.5; 
% IC definition for "Square Path - Non smooth"   
unicycle.ic.x = .3; unicycle.ic.y = .3; unicycle.ic.theta = 5;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Controller Gains for "Square Path - smooth"
a = 5; zeta = 0.7; 
% IC definition for "Square Path - smooth"  
unicycle.ic.x = .3; unicycle.ic.y = .3; unicycle.ic.theta = 5;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

unicycle.ic.x = x_sim(1,2); unicycle.ic.y = y_sim(1,2); unicycle.ic.theta = theta(1);

% Run simulation in Simulink

figure
title('X')
plot(out.output.time, out.output.signals.values(:,1)) % x
hold on
plot(out.reference.time, out.reference.signals.values(:,1))

figure
title('Y')
plot(out.output.time, out.output.signals.values(:,2)) % y
hold on
plot(out.reference.time, out.reference.signals.values(:,2))

figure
title('Theta')
plot(out.output.time, out.output.signals.values(:,3)) % theta
hold on
plot(out.reference.time, out.reference.signals.values(:,3))

% Plots
x_des = out.reference.signals.values(:,1); y_des = out.reference.signals.values(:,2);
x = out.output.signals.values(:,1); y = out.output.signals.values(:,2); theta = out.output.signals.values(:,3);
filenameXY = strcat('./figure/XY/XY_',string(trajectory_name),string(filename_plot));
filenameCommands = strcat('./figure/Commands/Commands_',string(trajectory_name),string(filename_plot));
filenameErrors = strcat('./figure/Errors/Errors_',string(trajectory_name),string(filename_plot));
plot_XY_Tracking(x_des, y_des, x, y, theta, filenameXY)
plot_Commands(out, unicycle, filenameCommands)
plot_Errors(out, filenameErrors, 1)

%% Tracking - State Feedback NON Linear
filename_plot = {'State_Feedback_NON_Linear.pdf'};

% Decide path
run('./matlab_functions/decide_Path.m')

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Controller Gains for "Eight Shape"
a = 7; zeta = 0.4;  
% IC definition for "Eight Shape"  
unicycle.ic.x = -.5; unicycle.ic.y = -.5; unicycle.ic.theta = 65;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Controller Gains for "Square Path - Non smooth"
a = 4; zeta = 0.5; 
% IC definition for "Square Path - Non smooth"   
unicycle.ic.x = .3; unicycle.ic.y = .3; unicycle.ic.theta = 5;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Controller Gains for "Square Path - smooth"
a = 5; zeta = 0.7; 
% IC definition for "Square Path - smooth"  
unicycle.ic.x = .3; unicycle.ic.y = .3; unicycle.ic.theta = 5;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Controller Gains for "Line Follower Path"
a = 6; zeta = 0.3;
% IC definition for "Square Path - smooth"  
unicycle.ic.x = 0.1; unicycle.ic.y = 0.1; unicycle.ic.theta = 3;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

unicycle.ic.x = x_sim(1,2); unicycle.ic.y = y_sim(1,2); unicycle.ic.theta = theta(1);

% Run simulation in Simulink

% Plots
x_des = out.reference.signals.values(:,1); y_des = out.reference.signals.values(:,2);
x = out.output.signals.values(:,1); y = out.output.signals.values(:,2); theta = out.output.signals.values(:,3);
filenameXY = strcat('../figure/XY/XY_',string(trajectory_name),string(filename_plot));
filenameCommands = strcat('../figure/Commands/Commands_',string(trajectory_name),string(filename_plot));
filenameErrors = strcat('../figure/Errors/Errors_',string(trajectory_name),string(filename_plot));
plot_XY_Tracking(x_des, y_des, x, y, theta, filenameXY)
plot_Commands(out, unicycle, filenameCommands)
plot_Errors(out, filenameErrors, 1)

%% Tracking - Output Feedback
filename_plot = {'Output_Feedback.pdf'};

% Decide path
run('./matlab_functions/decide_Path.m')

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Controller Gains for "Eight Shape"
b = 0.75; k1 = 1.2; k2 = 1.2; 
% IC definition for "Eight Shape"  
unicycle.ic.x = -.5; unicycle.ic.y = -.5; unicycle.ic.theta = 65;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Controller Gains for "Square Path - Non smooth"
b = 1; k1 = 4; k2 = .8; 
% IC definition for "Square Path - Non smooth"   
unicycle.ic.x = .3; unicycle.ic.y = .3; unicycle.ic.theta = 5;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Controller Gains for "Square Path - smooth"
b = 1; k1 = 4; k2 = .8;
% IC definition for "Square Path - smooth"  
unicycle.ic.x = .3; unicycle.ic.y = .3; unicycle.ic.theta = 5;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Controller Gains for "Line Follower Path"
b = 0.2; k1 = .9; k2 = .9;
% IC definition for "Square Path - smooth"  
unicycle.ic.x = 0.1; unicycle.ic.y = 0.1; unicycle.ic.theta = 3;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

unicycle.ic.x = x_sim(1,2); unicycle.ic.y = y_sim(1,2); unicycle.ic.theta = theta(1);

% Run simulation in Simulink

% Plots
x_des = out.reference.signals.values(:,1); y_des = out.reference.signals.values(:,2);
x = out.output.signals.values(:,1); y = out.output.signals.values(:,2); theta = out.output.signals.values(:,3);
filenameXY = strcat('../figure/XY/XY_',string(trajectory_name),string(filename_plot));
filenameCommands = strcat('../figure/Commands/Commands_',string(trajectory_name),string(filename_plot));
filenameErrors = strcat('../figure/Errors/Errors_',string(trajectory_name),string(filename_plot));
plot_XY_Tracking(x_des, y_des, x, y, theta, filenameXY)
plot_Commands(out, unicycle, filenameCommands)
plot_Errors(out, filenameErrors, 0)

%% Tracking - Z Feedback
filename_plot = {'Z_Feedback.pdf'};

% Decide path
run('./matlab_functions/decide_Path.m')

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Controller Gains for "Eight Shape"
k_p1 = 8; k_p2 = 8; k_d1 = .9; k_d2 = .9; 
% IC definition for "Eight Shape"  
unicycle.ic.x = -.5; unicycle.ic.y = -.5; unicycle.ic.theta = 65;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Controller Gains for "Square Path - Non smooth"
k_p1 = 5; k_p2 = 5; k_d1 = 3; k_d2 = 3; 
% IC definition for "Square Path - Non smooth"   
unicycle.ic.x = .3; unicycle.ic.y = .3; unicycle.ic.theta = 5;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Controller Gains for "Square Path - smooth"
k_p1 = 10; k_p2 = 10; k_d1 = 3; k_d2 = 3; 
% IC definition for "Square Path - smooth"  
unicycle.ic.x = .3; unicycle.ic.y = .3; unicycle.ic.theta = 5;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Controller Gains for "Line Follower Path"
k_p1 = 12; k_p2 = 12; k_d1 = 2; k_d2 = 2; 
% IC definition for "Square Path - smooth"  
unicycle.ic.x = 0.1; unicycle.ic.y = 0.1; unicycle.ic.theta = 3;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

unicycle.ic.x = x_sim(1,2); unicycle.ic.y = y_sim(1,2); unicycle.ic.theta = theta(1);

% Run simulation in Simulink

% Plots
x_des = out.reference.signals.values(:,1); y_des = out.reference.signals.values(:,2);
x = out.output.signals.values(:,1); y = out.output.signals.values(:,2); theta = out.output.signals.values(:,3);
filenameXY = strcat('../figure/XY/XY_',string(trajectory_name),string(filename_plot));
filenameCommands = strcat('../figure/Commands/Commands_',string(trajectory_name),string(filename_plot));
filenameErrors = strcat('../figure/Errors/Errors_',string(trajectory_name),string(filename_plot));
plot_XY_Tracking(x_des, y_des, x, y, theta, filenameXY)
plot_Commands(out, unicycle, filenameCommands)
plot_Errors(out, filenameErrors, 0)


%% Cartesian Regulation
filenamePlot = {'Cartesian_Regulation.pdf'};

% Controller definition
K_v = 1;
K_w = 1;

% IC definition
unicycle.ic.x = 0; unicycle.ic.y = 0; unicycle.ic.theta = 0;

% FC definition
x_f = 1; y_f = 1;

% Run simulation in Simulink

load('./data/Cartesian.mat')

% Plots
x = out.output.signals.values(:,1); y = out.output.signals.values(:,2); theta = out.output.signals.values(:,3);
filenameXY = strcat('./figure/XY/',string(filenamePlot));
filenameCommands = strcat('./figure/Commands/',string(filenamePlot));
plot_XY_Regulation(x, y, theta, x_f, y_f, filenameXY)
plot_Commands(out, unicycle, filenameCommands)

%% Posture Regulation - Singularity
filenamePlot = {'Posture_Regulation_Singularity.pdf'};

% Parameter definition
k1 = 3;
k2 = 3;
k3 = 1;

% IC definition
unicycle.ic.x = 0; unicycle.ic.y = 0; unicycle.ic.theta = 0;

% FC definition
x_f = 1; y_f = 1; theta_f = 90;

% Run simulation in Simulink

% Plots
x = out.output.signals.values(:,1); y = out.output.signals.values(:,2); theta = out.output.signals.values(:,3);
filenameXY = strcat('../figure/XY/',string(filenamePlot));
filenameCommands = strcat('../figure/Commands/',string(filenamePlot));
plot_XY_Regulation(x, y, theta, x_f, y_f, filenameXY)
plot_Commands(out, unicycle, filenameCommands)

%% Posture Regulation - NO Singularity
filenamePlot = {'Posture_Regulation_NO_Singularity.pdf'};

% Parameter definition
k1 = .1;
k2 = .1;
k3 = 3;

% IC definition
unicycle.ic.x = 0; unicycle.ic.y = 0; unicycle.ic.theta = 0;

% FC definition
x_f = 2; y_f = 2; theta_f = 90;

% Run simulation in Simulink

% Plots
x = out.output.signals.values(:,1); y = out.output.signals.values(:,2); theta = out.output.signals.values(:,3);
filenameXY = strcat('./figure/XY/',string(filenamePlot));
filenameCommands = strcat('./figure/Commands/',string(filenamePlot));
plot_XY_Regulation(x, y, theta, x_f, y_f, filenameXY)
plot_Commands(out, unicycle, filenameCommands)


TURTLEBOT=turtlebot roslaunch sparcs_turtlebot turtlebot.launch number:=03 rosserial:=true camera:=false lidar:=false vicon:=false


filename = './data/Feedforward_Square';
save(filename, 'out')

filename = './data/FeedbackLinear_8';
save(filename, 'out')

filename = './data/Z_Feedback_8';
save(filename, 'out')

filename = './data/FeedbackLinear_SquareSmooth';
save(filename, 'out')

filename = './data/Z_Feedback_SquareSmooth';
save(filename, 'out')

filename = './data/Cartesian';
save(filename, 'out')


filename = './data/Posture';
save(filename, 'out')


filename = './data/DataFromOthers';
save(filename, 'out')


