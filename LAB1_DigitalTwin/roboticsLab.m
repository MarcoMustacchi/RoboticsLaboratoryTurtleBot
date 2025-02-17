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

%% run Simulink simulations
T = 20;
sim('./simulink_models/Lab1', 'StopTime', num2str(T))
pause(1)

%% plot XY
plot_XY(ans)
% hold on
% plot(ans.odom.signals.values(:,1), ans.odom.signals.values(:,2), '*-','LineWidth', 1);
filename = append('./figure/XY_plot','.pdf');
exportgraphics(gcf,filename,'ContentType','vector')

%% plot output Kinematic
plot_output_Kinematic(ans)
filename = append('./figure/output_Kinematic','.pdf');
exportgraphics(gcf,filename,'ContentType','vector')

%% plot z_output
plot_z_output(ans)
filename = append('./figure/z_output','.pdf');
exportgraphics(gcf,filename,'ContentType','vector')

%% plot output Chained form
plot_output_Chained(ans)
filename = append('./figure/output_Chained','.pdf');
exportgraphics(gcf,filename,'ContentType','vector')

%% plot commands DDR
plot_commands(ans)
filename = append('./figure/DDR_commands','.pdf');
exportgraphics(gcf,filename,'ContentType','vector')

%% final animation
% Creating Data to Animate
% Time array
t = linspace(0, 6, 100);
% Particle coordinates
x = 4*sin(t);
y = 0.5*x.^2;
z = x.*cos(t);
plot_trajectory_animation(x,y,z,t)

%% another test
% 3d coordinates of a curve
x = 0:.05:2*pi;
t = 0:1:length(x)-1;
y = sin(x);
z = cos(x);
col = rand(1,numel(x)); % color vector: a set of values that are mapped in the colorbar
plot4D(x,y,z,col);

%% Multirotor animation
plot_multirotor_animation(x,y,z,t)




