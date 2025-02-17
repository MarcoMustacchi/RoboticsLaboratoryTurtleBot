close all
clear
clc

%% Tracking
T = 50;
step_size = 0.01; % to modify
s = 0:step_size:T; % to modify
s = transpose(s);
xc = 0; yc = 0;
R1 = 1; R2 = 1; wd = 1/10;
x = xc + R1*sin(2*wd.*s); y = yc + R2*sin(wd.*s);
plot(x,y,'LineWidth',1)

%% LaserScan animation
load('./data/odom.mat')
load('./data/LaserScan.mat')
polar = out.scan.signals.values(:,:,1);
cartesian = pol2cart(polar);

% in body frame
figure
plot(cartesian(:,1), cartesian(:,2))

% in Vicon frame


% Create map
M = zeros(10); % 10x10 environment
bin = boolean(M);
map = binaryOccupancyMap(bin,'GridOriginInLocal',[-5,-5]);

show(map)
hold on 
plot(scan) % mi mette gia' scan nel corrispondente xy nella mappa
grid on

filename = 'test.gif';
plot_animation_vehicle(map, s, trajectory, trajectory, filename);


%% Apply Cartesian regulation
x0 = [0.7, 0.0, -0.7, -1.0, -0.7, 0.0, 0.7, 1.0];
y0 = [0.7, 1.0, 0.7, 0.0, -0.7, -1.0, -0.7, 0.0];

% insert in Simulink scheme the variable x_i and y_i
for i = 1:length(x0)
    x_i = x0(i);
    y_i = y0(i);
    theta_i = 0;
    x_f = 0;
    y_f = 0;
    theta_f = 0;
    sim('./simulink_models/Cartesian_Regulation.slx','StopTime','20');
    % save();
end

%% Apply Posture regulation
x0 = [0.0, -0.7, 0.0, 0.0, 0.0, 0.7, 1.0, -0.7];
y0 = [1.0, -0.7, 1.0, 1.0, -1.0, -0.7, 0.0, -0.7];
theta0 = [-pi/2, 0, -pi, 3/4*pi, -pi/2, -pi/2, -pi/2, pi/2];

% insert in Simulink scheme the variable x_i and y_i and theta_i
for i = 1:length(x0)
    x_i = x0(i);
    y_i = y0(i);
    theta_i = theta0(i);
    x_f = 0;
    y_f = 0;
    theta_f = 0;
    sim('./simulink_models/State_Feedback_NON_Linear.slx','StopTime',num2str(t(end)));
    save();
end