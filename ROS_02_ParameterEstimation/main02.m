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

unicycle.d = 0.165;
unicycle.r = 0.034;

unicycle.d = 0.158;
unicycle.r = 0.032;

%% r and d Estimation using Line Follower
% load('real.mat');
% 
% % Plot real Data
% x = out.simout.signals.values(1:end/2+50,1);
% y = out.simout.signals.values(1:end/2+50,2);
% figure
% plot(x,y);
% 
% t = out.wheelSpeeds.time(1:end/2+50);
% wl = out.wheelSpeeds.signals.values(1:end/2+50,1);
% wr = out.wheelSpeeds.signals.values(1:end/2+50,2);
% figure
% plot(t,wr)
% hold on
% plot(t,wl)
% legend('wl','wr','interpreter','latex')
% 
% % Generate sim data
% wr_sim = [t, wr];
% wl_sim = [t, wl];

% sim('./simulink_models/Lab2.slx','StopTime',num2str(t(end)))
% figure
% plot(ans.simout.signals.values(:,1),ans.simout.signals.values(:,2))
% axis equal

%% Path Planning
% normalized arc-length coordinate
% step=0.01;
% % design parameters
% k_i=5; k_f=5; % k determines the boundary on the velocities
% 
% [x,y,theta,v,w] = create_piecewise_path(step, k_i, k_f);

%% New Path Planning 8 shape
% Specify waypoints, times of arrival, and sampling rate. 
wp = [0 0 0; 2 -2 0; 4 0 0; 6 2 0; 8 0 0; 6 -2 0; 4 0 0; 2 2 0; 0 0 0];
toa = 4*(0:size(wp,1)-1).';
Fs = 100;

[s,x,y,x_dot,y_dot,x_dot_dot,y_dot_dot,theta,t,v_d,w_d] = create_path_8(wp,toa,Fs,unicycle);

%% Create Data for simulation
x_sim = [t, x]; x_dot_sim = [t, x_dot]; x_dot_dot_sim = [t, x_dot_dot];
y_sim = [t, y]; y_dot_sim = [t, y_dot]; y_dot_dot_sim = [t, y_dot_dot];

% Ts = s(2);
% 
% sim('./simulink_models/Lab2.slx','StopTime',num2str(t(end)),'FixedStep',num2str(Ts))
% figure
% plot(ans.simout2.signals.values(:,1),ans.simout2.signals.values(:,2))
% axis equal

%% Find the wheel saturation limit
% to find the max speed of the wheel, we can just publish a constant value
% in wl and wr and read the corresponding measured value of wl and wr in
% simulink subscriber 

%% odom data from network
% ricorda che per collegarsi all'altro master, dobbiamo collegarci con l'altro source 
% (oltre che cambiare indirizzo ip in Simulink) invece che .156 e' .76
% save('odom_from_network','out');
% load('odom_from_network.mat')

%% Load odom data from SPARC Lab
out_Vicon = load('./data/sparcs_data_third_test.mat');
Ts = 0.02;

[v_est,w_est] = odom2vel(out_Vicon.out.odomBus, Ts);

figure
plot(v_est)
hold on
plot(v_d,'LineWidth',2)
ylim([-0.3 0.3])

figure
plot(w_est)
hold on
plot(w_d,'LineWidth',2)
ylim([-0.3 0.3])

%% Filtering
t_w = out_Vicon.out.wheelSpeeds_desired.time(4:end-2);
t_w = t_w - t_w(1);

wl = out_Vicon.out.wheelSpeeds_true.signals.values(4:end-2,1);
wr = out_Vicon.out.wheelSpeeds_true.signals.values(4:end-2,2);

wl_d = out_Vicon.out.wheelSpeeds_desired.signals.values(4:end-2,1);
wr_d = out_Vicon.out.wheelSpeeds_desired.signals.values(4:end-2,2);

wheel_speed_measured_desired(t_w, wl, wl_d, wr, wr_d);

wl_timetable = array2timetable(wl,'SampleRate',1/Ts);
wr_timetable = array2timetable(wr,'SampleRate',1/Ts);

% Fiter using LPF
figure
lowpass(wl_timetable,0.5*10^-3)
removeToolbarExplorationButtons(gcf)
exportgraphics(gcf,'./figure/wl_filtered.pdf','ContentType','vector')

figure
lowpass(wr_timetable,0.5*10^-3)
removeToolbarExplorationButtons(gcf)
exportgraphics(gcf,'./figure/wr_filtered.pdf','ContentType','vector')

wl_filtered = lowpass(wl,0.5*10^-3,Ts);
wr_filtered = lowpass(wr,0.5*10^-3,Ts);

%% Estimate wheel radius and wheels distance - First method
theta_vicon = 2*acos(out_Vicon.out.odomBus.Pose.Pose.Orientation.W.Data);
temp_theta = diff(theta_vicon);

% Consider straight path for computing r
idx_straight=find(abs(temp_theta)<0.001);

r = 2*v_est(idx_straight) ./ (wr_filtered(idx_straight) + wl_filtered(idx_straight));
r = rmmissing(r); % remove NaN values
r = rmoutliers(r); % remove outliers
r_final = mean(r);

% Consider both and right curves to compute d
boh =  abs(abs(w_d(1:2958)) - abs(w_est));
figure
plot(w_d(1:2958))
hold on
plot(w_est)

figure
plot(boh)
ylim([-0.3 0.3])

idx_curves = find(abs(temp_theta)>0.001);
idx_final = find(abs( abs(w_d(idx_curves)) - abs(w_est(idx_curves)) ) < 0.051);

d = (r_final.*(wr_filtered(idx_final) + wl_filtered(idx_final))) ./ w_est(idx_final);
d = rmmissing(d); % remove NaN values
d = rmoutliers(d); % remove outliers
d = d(d > 0);
d_final = mean(d);

%% EXTRA - Estimate wheel radius and wheels distance - Second method
v_odom_x = out_Vicon.out.odomBus.Twist.Twist.Linear.X.Data;
v_odom_y = out_Vicon.out.odomBus.Twist.Twist.Linear.Y.Data;
v_odom_z = out_Vicon.out.odomBus.Twist.Twist.Linear.Z.Data;

w_odom_x = out_Vicon.out.odomBus.Twist.Twist.Angular.X.Data;
w_odom_y = out_Vicon.out.odomBus.Twist.Twist.Angular.Y.Data;
w_odom_z = out_Vicon.out.odomBus.Twist.Twist.Angular.Z.Data;

theta_ic = 2*acos(out_Vicon.out.odomBus.Pose.Pose.Orientation.W.Data);
theta_ic = 2*(theta_ic)

R = [cos(theta_ic) sin(theta_ic) 0; 
    -sin(theta_ic) cos(theta_ic) 0;
    0              0             1];

xy_true = [w_odom_x, w_odom_y, w_odom_z];
so = transpose(R)*transpose(xy_true);  % transpose(R) because from inertia to body?
vx_rotated = transpose(so(1,:));
vy_rotated = transpose(so(2,:));
vz_rotated = transpose(so(3,:));

% r = 2*v_odom / (wr + wl);
% d = r*(wr + wl) / w_odom;

%% Integration from measured Wheels
wl = out_Vicon.out.wheelSpeeds_true.signals.values(4:end-2,1); 
wr = out_Vicon.out.wheelSpeeds_true.signals.values(4:end-2,2);

% Plot
figure
lowpass(wl,0.5*10^-3,Ts)
figure
lowpass(wr,0.5*10^-3,Ts)

wl_filtered = lowpass(wl,0.5*10^-3,Ts);
wr_filtered = lowpass(wr,0.5*10^-3,Ts);

x0 = x(1); y0 = y(1); theta0 = theta(1); % assuming to know ic
Ts = 0.02;	

[x_rec, y_rec, theta_rec, v_rec, w_rec] = odomReconstruction(unicycle, wl_filtered, wr_filtered, x0, y0, theta0, Ts);

figure
plot(x_rec, y_rec)

%% Compare path
path.desired.x = x; path.desired.y = y;
path.true.x = out_Vicon.out.odomBus.Pose.Pose.Position.X.Data; path.true.y = out_Vicon.out.odomBus.Pose.Pose.Position.Y.Data;
path.true.theta_ic = 2*acos(out_Vicon.out.odomBus.Pose.Pose.Orientation.W.Data(1));
path.true.theta_ic = 2*(path.true.theta_ic); % it's like inverted (from inf path to 8 path)
path.reconstructed.x = x_rec;  path.reconstructed.y = y_rec;

filenamePathComparison = './figure/pathComparison.pdf';
path_comparison(path, filenamePathComparison);

%% EXTRA - System Identification
out_free_load = load('./data/CLAB_with_load');
out_with_load = load('./data/CLAB_with_load');

figure
subplot(1,2,1)
plot(out_free_load.out.wheelSpeeds_true.time, out_free_load.out.wheelSpeeds_true.signals.values(:,1))
hold on
plot(out_free_load.out.wheelSpeeds_desired.time, out_free_load.out.wheelSpeeds_desired.signals.values(:,1),'LineWidth',2)
grid on; 
title('Wheel Speed Free Load','Interpreter','latex')
xlabel('$t$ [s]','interpreter','latex')
ylabel('[rad/s]','interpreter','latex')
legend('Wheel speed True','Wheel speed Desired','interpreter','latex','location','southeast');
set(gca,'TickLabelInterpreter','latex')
subplot(1,2,2)
plot(out_with_load.out.wheelSpeeds_true.time, out_with_load.out.wheelSpeeds_true.signals.values(:,1))
hold on
plot(out_with_load.out.wheelSpeeds_desired.time, out_with_load.out.wheelSpeeds_desired.signals.values(:,1),'LineWidth',2)
grid on; 
title('Wheel Speed With Load','Interpreter','latex')
xlabel('$t$ [s]','interpreter','latex')
ylabel('[rad/s]','interpreter','latex')
legend('Wheel speed True','Wheel speed Desired','interpreter','latex','location','southeast');
set(gca,'TickLabelInterpreter','latex')
removeToolbarExplorationButtons(gcf)
exportgraphics(gcf,'./figure/IOcomparison.pdf','ContentType','vector')

% Free load and with load are exactly the same ..
figure
plot(out_free_load.out.wheelSpeeds_true.time, out_free_load.out.wheelSpeeds_true.signals.values(:,1))
hold on
plot(out_with_load.out.wheelSpeeds_true.time, out_with_load.out.wheelSpeeds_true.signals.values(:,1))
grid on; 
title('Wheel Speed Free Load','Interpreter','latex')
xlabel('$t$ [s]','interpreter','latex')
ylabel('[rad/s]','interpreter','latex')
legend('Wheel speed True','Wheel speed Desired','interpreter','latex','location','southeast');
set(gca,'TickLabelInterpreter','latex')

% Data Preparation
Ts = 0.02;
input = out_with_load.out.wheelSpeeds_desired.signals.values(:,1);
output = out_with_load.out.wheelSpeeds_true.signals.values(:,1);
data = iddata(output,input,Ts);

figure
idplot(data)
grid on
removeToolbarExplorationButtons(gcf)
exportgraphics(gcf,'./figure/idplot.pdf','ContentType','vector')

% 1 poles and 0 zero -> First order LPF
sysTF_1_LPF = tfest(data,1,0,nan,'Ts',Ts) %data,np,nz,iodelay
% 1 poles and 1 zero -> First order HPF
sysTF_1_HPF = tfest(data,1,1,nan,'Ts',Ts) %data,np,nz,iodelay

% From bode we can see that it is a Low Pass Filter?
figure
bode(sysTF_1_LPF)
removeToolbarExplorationButtons(gcf)
exportgraphics(gcf,'./figure/bodePlot.pdf','ContentType','vector')

% Find delay
idx_input = find(abs(diff(input))>0.1, 1, 'first')
idx_output = find(abs(diff(output))>0.1, 1, 'first')

samples_delay = idx_output - idx_input + 1

time_input = out_with_load.out.wheelSpeeds_desired.time(idx_input)
time_output = out_with_load.out.wheelSpeeds_true.time(idx_output)

delay = time_output - time_input

% First order Transfer Function - no delay, computed delay
sysTF_1 = tfest(data,1,0,0,'Ts',Ts) %data,np,nz,iodelay
sysTF_1_delay = tfest(data,1,0,samples_delay,'Ts',Ts) %data,np,nz,iodelay

% wc = getGainCrossover(sysTF_1_delay,1) % crossover frequency

figure
compare(data,sysTF_1,sysTF_1_delay)
grid on
removeToolbarExplorationButtons(gcf)
exportgraphics(gcf,'./figure/compareLPFdelay.pdf','ContentType','vector')

% Second order Transfer Function - no delay, unknown delay, computed delay
sysTF_2_delay = tfest(data,2,1,nan,'Ts',Ts) %data,np,nz,iodelay

% Model Validation - Residual Analysis
figure
resid(sysTF_1_delay, data)
removeToolbarExplorationButtons(gcf)
exportgraphics(gcf,'./figure/residuals.pdf','ContentType','vector')

%% Ping
pinging /turtlebot_03/rosserial with a timeout of 3.0s                                                                                                                                                                                       
xmlrpc reply from http://147.162.118.156:39031/ time=8.457422ms 

%% Publishing rate of odom topic
rostopic hz /turtlebot_03/odom                                                                                                                                                                                      subscribed to [/turtlebot_05/odom]                                                                                                                                                                                                           average rate: 100.054                                                                                                                                                                                                                                
min: 0.001s max: 0.022s std dev: 0.00627s window: 98 
