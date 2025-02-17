close all
clear all
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
% run('..\Lab0\lab0_controllerPIDdesign.m')
% load('..\Lab0\data\LAB_inertiaParameterEstimated.mat')

%% Trajectory generation
% trajectory_generation

%% save mat-files
% filenameMAT = strcat('PID_antiWindup_','withStepAmplitude',string(stepAmplitude),'.mat');
% save(filenameMAT,'theta','ia');

%% Compute path
% normalized arc-length coordinate
step = 0.01;
s = 0:step:1;
s = transpose(s);
% initial and final conditions
x_i=0; y_i=0; theta_i=0;
x_f=2; y_f=4; theta_f=0;
% design parameters
k_i=10; k_f=5;

Intermediate = 0;

%% Request 1 - Path planning Cartesian
pause(1)
[trajectory.x,trajectory.y,trajectory.theta,trajectory.v,trajectory.w] = compute_path(s,x_i,y_i,theta_i,x_f,y_f,theta_f,k_i,k_f);
filenameXY = append('./figure/XY_plot_Cartesian','.pdf');
filenameOrientation = append('./figure/Orientation_plot_Cartesian','.pdf');
plot_report(s, trajectory.x, trajectory.y, trajectory.theta, filenameXY, filenameOrientation,Intermediate);

%% Request 2 - Path planning Chained Form CCW
x_f=2; y_f=4; theta_f=0+2*pi;
[z1_i,z2_i,z3_i,z1_f,z2_f,z3_f] = cartesian2Chained(x_i,y_i,theta_i,x_f,y_f,theta_f);
pause(1)
[trajectory.xz,trajectory.yz,trajectory.thetaz] = compute_path_z(s,z1_i,z2_i,z3_i,z1_f,z2_f,z3_f);
filenameXY = append('./figure/XY_plot_ChainedForm_CCW','.pdf');
filenameOrientation = append('./figure/Orientation_plot_ChainedForm_CCW','.pdf');
plot_report(s, trajectory.xz, trajectory.yz, trajectory.thetaz, filenameXY, filenameOrientation,Intermediate);

%% Request 3 - Path planning Chained Form CW
x_f=2; y_f=4; theta_f=0-2*pi;
[z1_i,z2_i,z3_i,z1_f,z2_f,z3_f] = cartesian2Chained(x_i,y_i,theta_i,x_f,y_f,theta_f);
pause(1)
[trajectory.xz,trajectory.yz,trajectory.thetaz] = compute_path_z(s,z1_i,z2_i,z3_i,z1_f,z2_f,z3_f);
filenameXY = append('./figure/XY_plot_ChainedForm_CW','.pdf');
filenameOrientation = append('./figure/Orientation_plot_ChainedForm_CW','.pdf');
plot_report(s, trajectory.xz, trajectory.yz, trajectory.thetaz, filenameXY, filenameOrientation,Intermediate);

%% Request 4 - Path planning Chained Form Intermediate Point
x_v=2; y_v=2; theta_v=pi/2;
[z1_i,z2_i,z3_i,z1_f,z2_f,z3_f] = cartesian2Chained(x_i,y_i,theta_i,x_v,y_v,theta_v);
[trajectory1.xz,trajectory1.yz,trajectory1.thetaz] = compute_path_z(s,z1_i,z2_i,z3_i,z1_f,z2_f,z3_f);

x_f=2; y_f=4; theta_f=0;
[z1_i,z2_i,z3_i,z1_f,z2_f,z3_f] = cartesian2Chained(x_v,y_v,theta_v,x_f,y_f,theta_f);
[trajectory2.xz,trajectory2.yz,trajectory2.thetaz] = compute_path_z(s,z1_i,z2_i,z3_i,z1_f,z2_f,z3_f);

trajectory.xz = cat(1, trajectory1.xz, trajectory2.xz);
trajectory.yz = cat(1, trajectory1.yz, trajectory2.yz);
trajectory.thetaz = cat(1, trajectory1.thetaz, trajectory2.thetaz);

pause(1)
filenameXY = append('./figure/XY_plot_ChainedForm_Vpoint','.pdf');
filenameOrientation = append('./figure/Orientation_plot_ChainedForm_Vpoint','.pdf');
step = 0.01;
s = 0:step:2+0.01;
s = transpose(s);
Intermediate = 1;
plot_report(s, trajectory.xz, trajectory.yz, trajectory.thetaz, filenameXY, filenameOrientation, Intermediate);

%% test animation
%% Create map and Animation final 
M = zeros(10); % 10x10 environment
% M(2:end-1,2:end-1) = 0; % matrix that has 1 in ther borders
bin = boolean(M);
map = binaryOccupancyMap(bin,'GridOriginInLocal',[-5,-5]);

filename = 'test.gif';
plot_animation_vehicle(map, s, trajectory, trajectory, filename);

filename = 'test2.gif';
test(map, s, trajectory, trajectory, filename);
