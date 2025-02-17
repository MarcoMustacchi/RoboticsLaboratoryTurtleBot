close all
clear
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

%% LaserScan
% save('LaserScan', 'out','polar','cartesian')
load('./data/LaserScan.mat')
polar = out.scan.signals.values(:,:,1);
cartesian = pol2cart(polar);

figure
plot(cartesian(:,1), cartesian(:,2))

%% Compute focal length of the camera
% rotate the robot instead of using the rotate the camera using pan
% length Z = 126cm

% save('images', 'out')
load('./data/images.mat')
image = out.image.signals.values(:,:,:,end); % last frame from the stack
figure
imshow(image) % width*height*RGB*number of images

[l, x, y] = compute_image_square_pixel_parallel(image);
Z = 126;
X = 10;
Y = 10;

% compute focal length
f_l = (l*Z)/X;
f_x = (x*Z)/X;
f_y = (y*Z)/Y;

pause(1)

%% Once we know f, we can compute distances Z with the camera
%% distance = 63cm
load('./data/distances_sim.mat')

% Pre process
polar = out.scan.signals.values(:,:,end);

image = out.image.signals.values(:,:,:,end); % last frame from the stack
figure
imshow(image) % width*height*RGB*number of images
[l, x, y] = compute_image_square_pixel_parallel(image);
X = 10;
Z = f_l*X/l;

distance.ultrasonic_distance = out.ultrasonicDistance.signals.values(end,end);
distance.laserScan_distance = polar(length(polar)/2);
distance.camera_distance = Z/100; % should be 63cm

distance.offset_lc = distance.laserScan_distance - distance.camera_distance;
distance.offset_lu = distance.laserScan_distance - distance.ultrasonic_distance;
distance.offset_cu = distance.camera_distance - distance.ultrasonic_distance;

%% distance = 126cm parallel
% Z_parallel = 126;
load('./data/distances_sim_126_parallel.mat')
images_parallel = out.image.signals.values(:,:,:,end); % last frame from the stack
load('./data/distances_sim_126_rotated.mat')
images_rotated = out.image.signals.values(:,:,:,end); % last frame from the stack

figure
imshowpair(images_parallel,images_rotated,'montage')

% compute parallel distance
[l, x, y] = compute_image_square_pixel_parallel(images_parallel);
X = 10;
distance2.parallel = f_l*X/l; % should be 126cm

% compute the two rotated distances
[y_left, y_right] = compute_image_square_pixel_rotated(images_rotated);
Y = 10;
distance2.rotated_left = f_l*Y/y_left; % should be 150cm NO
distance2.rotated_right = f_l*Y/y_right; % should be 156cm NO

%% 
load('./data/distances_sim_126_parallel.mat')
polar = out.scan.signals.values(:,:,1);
figure
plot(polar(:,2), polar(:,1))

cartesian = pol2cart(polar);

figure
plot(cartesian(:,2), cartesian(:,1))

load('./data/distances_sim_126_rotated')

ultrasonic_distance = out.ultrasonicDistance.signals.values(end,end);
polar = out.scan.signals.values(:,:,end);
laserScan_distance = polar(length(polar)/2);

polar = out.scan.signals.values(:,:,1);

% figure
% plot(polar(:,2), polar(:,1))
% 
% cartesian = pol2cart(polar);
% figure
% plot(cartesian(:,2), cartesian(:,1))

%% Considerations
% we need to consider also that the sensors are not exactly aligned, so ..
% this means that the closer to the wall, the less is the error offset due
% the non-alignment









