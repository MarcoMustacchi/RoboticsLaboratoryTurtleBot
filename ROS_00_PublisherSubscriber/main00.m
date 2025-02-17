close all
clear all
clc

% Recall
% if simulation through Simulink, variable to workspace is called out.
% if simulation through MATLAB, variable to workspace is called ans.

% Include subfolders for Simulink subsystems (otherwise for simulation trough MATLAB same folder..)
% when you you close MATLAB, path is restored
cd simulink_models\
addpath(genpath(pwd))
cd ..

% Include subfolders for MATLAB functions
% when you you close MATLAB, path is restored
cd matlab_functions\
addpath(genpath(pwd))
cd ..

%% load and plot subscribers data
load("./data/subscribers_data.mat")
figure
plot(out.wheelSpeeds.time,out.wheelSpeeds.signals.values(:,1))
hold on
plot(out.wheelSpeeds.time,out.wheelSpeeds.signals.values(:,2))
title('wheelSpeeds','Interpreter','latex')
figure
plot(out.lineError.time,out.lineError.signals.values)
title('lineError','Interpreter','latex')
figure
plot(out.ultrasonicDistance.time,out.ultrasonicDistance.signals.values)
title('ultrasonicDistance','Interpreter','latex')

%% load and display image
load("./data/subscribers_data_image.mat")

% last element (end) in this case, is the image sequence ..
image = out.image.signals.values;
figure
imshow(uint8(image(:,:,:,end))) % width*height*RGB*number of images

thresholdValue = 255; % Or whatever you want
belowThreshold = image(:,:,3,end) < thresholdValue; % Create binary image
% Make a copy that will be masked.
newImage = image; % Create a copy