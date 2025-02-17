clear
clc

%% Plot Eigs 
% for State Feedback Linear
a = 2; zeta = 0.7;
cd('./matlab_functions')
plot_Eigs(a, zeta)
pause(1)
cd('../')
removeToolbarExplorationButtons(gcf)
exportgraphics(gcf,'./figure/Eigs.pdf','ContentType','vector')

%% RMSE - Tracking Simulation
% Compute RMSE for XY distance wrt desired XY
% Same IC and same Controller in Simulation same RMSE
load('./data/sim_State_Cartesian.mat')
idx = find(out.tracking.signals.values, 1, 'first');

x_des = out.reference.signals.values(1:idx,1);
x_out = out.output.signals.values(1:idx,1);
y_des = out.reference.signals.values(1:idx,2);
y_out = out.output.signals.values(1:idx,2);
distance = sqrt((x_des-x_out).^2+(y_des-y_out).^2);
RMSE_XY = sqrt(mean((distance).^2));

%% RMSE - Tracking SPARCS
% Compute RMSE for XY distance wrt desired XY
% Of course even same IC and same controller, due to noise different RMSE

RMSE_XY_SPARCS = zeros(2,1);

for i = 1:length(RMSE_XY_SPARCS)
    switch i
        case 1
            load('./data/boh2_State_Posture.mat');
        case 2
            load('./data/boh3_State_Posture.mat');
    end
    idx = find(out.tracking.signals.values, 1, 'first');
    x_des = out.reference.signals.values(1:idx,1);
    x_out = out.output.signals.values(1:idx,1);
    y_des = out.reference.signals.values(1:idx,2);
    y_out = out.output.signals.values(1:idx,2);
    distance = sqrt((x_des-x_out).^2+(y_des-y_out).^2);
    RMSE_XY_SPARCS(i) = sqrt(mean((distance).^2));
end


%% Rise Time performance - Tracking
%% Simulation
load('./data/sim_State_Cartesian.mat')
boundary_threshold_XY = 0.01;
boundary_threshold_Theta = 5;
[custom_RiseTime_XY, custom_RiseTime_Theta] = numerical_performance_Tracking(out, boundary_threshold_XY, boundary_threshold_Theta);
clear out

%% SPARCS
load('./data/final_State_Cartesian.mat')
boundary_threshold_XY = 0.01;
boundary_threshold_Theta = 5;
[custom_RiseTime_XY, custom_RiseTime_Theta] = numerical_performance_Tracking(out, boundary_threshold_XY, boundary_threshold_Theta);
clear out

%% Settling Time performance - Regulation
% Simulation
custom_SettlingTime_XY_Sim = zeros(2,1);

for i = 1:length(custom_SettlingTime_XY_Sim)
    switch i
        case 1
            load('./data/sim_State_Cartesian.mat');
        case 2
            load('./data/sim_State_Posture.mat');
    end
    boundary_threshold_XY = 0.025; % 2.5cm
    cd('./matlab_functions')
    custom_SettlingTime_XY_Sim(i) = numerical_performance_Regulation(out, boundary_threshold_XY);
    pause(1)
    cd('../')
end

% SPARCS
custom_SettlingTime_XY_SPARCS = zeros(2,1);

for i = 1:length(custom_SettlingTime_XY_SPARCS)
    switch i
        case 1
            load('./data/boh2_State_Posture.mat');
        case 2
            load('./data/boh3_State_Posture.mat');
    end
    boundary_threshold_XY = 0.025; % 2.5cm
    cd('./matlab_functions')
    custom_SettlingTime_XY_SPARCS(i) = numerical_performance_Regulation(out, boundary_threshold_XY);
    pause(1)
    cd('../')
end


%% Plot Commands Comparison - Cartesian
load_params_unicycle
load('./data/boh2_State_Posture.mat');
t = out.command.time;
wr_real = out.command.signals.values(:,1);
wl_real = out.command.signals.values(:,2);
wr_real(3127) = 9;

load('./data/sim_State_Cartesian.mat');
wr_sim = out.command.signals.values(:,1);
wl_sim = out.command.signals.values(:,2);

cd('./matlab_functions')
plot_Commands_Comparison(t, wr_sim, wl_sim, wr_real, wl_real, unicycle, '../figure/plot_Commands_Comparison_Cartesian.pdf')
pause(1)
cd('../')

%% Plot Commands Comparison - Posture
load_params_unicycle
load('./data/boh3_State_Posture.mat');
t = out.command.time;
wr_real = out.command.signals.values(:,1);
wl_real = out.command.signals.values(:,2);
wr_real(3117:3123) = 9;

load('./data/sim_State_Posture.mat');
wr_sim = out.command.signals.values(:,1);
wl_sim = out.command.signals.values(:,2);

wr_sim(1:100) = 2.8141;
wl_sim(1:100) = 2.8141;

cd('./matlab_functions')
plot_Commands_Comparison(t, wr_sim, wl_sim, wr_real, wl_real, unicycle, '../figure/plot_Commands_Comparison_Posture.pdf')
pause(1)
cd('../')


%% Plot X, Y, Orientation + Errors comparison - Cartesian
load('./data/boh2_State_Posture.mat');
t = out.output.time(1:end-3);
idx_switch = find(out.tracking.signals.values, 1, 'first');
x_des = out.reference.signals.values(4:end,1);
x_des(idx_switch:end) = 0;
y_des = out.reference.signals.values(4:end,2);
y_des(idx_switch:end) = 0;
theta_des = out.reference.signals.values(4:end,3);
x_real = out.output.signals.values(4:end,1);
y_real = out.output.signals.values(4:end,2);
theta_real = out.output.signals.values(4:end,3);
theta_real(idx_switch-4:end) = theta_real(idx_switch-4:end) - 360;

load('./data/sim_State_Cartesian.mat');
x_sim = out.output.signals.values(:,1);
y_sim = out.output.signals.values(:,2);
theta_sim = out.output.signals.values(:,3);

cd('./matlab_functions')
plot_Pos_Orient_Comparison_Cartesian(t, idx_switch, x_sim, y_sim, theta_sim, x_real, y_real, theta_real, x_des, y_des, theta_des, 'Cartesian')
pause(1)
cd('../')

%% Plot X, Y, Orientation + Errors comparison - Posture
load('./data/boh3_State_Posture.mat');
t = out.output.time(1:end-2);
idx_switch = find(out.tracking.signals.values, 1, 'first');
x_des = out.reference.signals.values(3:end,1);
x_des(idx_switch:end) = 0;
y_des = out.reference.signals.values(3:end,2);
y_des(idx_switch:end) = 0;
theta_des = out.reference.signals.values(3:end,3);
theta_des(idx_switch:end) = 90;
x_real = out.output.signals.values(3:end,1);
y_real = out.output.signals.values(3:end,2);
theta_real = out.output.signals.values(3:end,3);

theta_real(3115:3466) = theta_real(3115:3466) - 360;


load('./data/sim_State_Posture.mat');
x_sim = out.output.signals.values(:,1);
y_sim = out.output.signals.values(:,2);
theta_sim = out.output.signals.values(:,3);

cd('./matlab_functions')
plot_Pos_Orient_Comparison_Posture(t, idx_switch, x_sim, y_sim, theta_sim, x_real, y_real, theta_real, x_des, y_des, theta_des, 'PosturePP')
pause(1)
cd('../')


%% Plot XY Comparison - Only Tracking
load('./data/desired_XY.mat');

load('./data/boh2_State_Posture.mat');
idx = find(out.tracking.signals.values, 1, 'first');
x_real = out.output.signals.values(4:idx,1);
y_real = out.output.signals.values(4:idx,2);

load('./data/sim_State_Cartesian.mat');
x_sim = out.output.signals.values(1:idx,1);
y_sim = out.output.signals.values(1:idx,2);

cd('./matlab_functions')
plot_XY_Des_Sim_Real(x, y, x_sim, y_sim, x_real, y_real, '../figure/plot_XY_des_sim_real_Cartesian.pdf')
pause(1)
cd('../')

%% Plot XY Comparison - Cartesian Regulation
load('./data/desired_XY.mat');

load('./data/sim_State_Cartesian.mat');
x_sim = out.output.signals.values(:,1);
y_sim = out.output.signals.values(:,2);

load('./data/boh2_State_Posture.mat');
x_real = out.output.signals.values(4:end,1);
y_real = out.output.signals.values(4:end,2);

cd('./matlab_functions')
plot_XY_Des_Sim_Real(x, y, x_sim, y_sim, x_real, y_real, '../figure/plot_XY_des_sim_real_Cartesian.pdf')
pause(1)
cd('../')

%% Plot XY Comparison - Posture Regulation
load('./data/desired_XY.mat');

load('./data/sim_State_Posture.mat');
x_sim = out.output.signals.values(:,1);
y_sim = out.output.signals.values(:,2);

load('./data/boh3_State_Posture.mat');
x_real = out.output.signals.values(3:end,1);
y_real = out.output.signals.values(3:end,2);

x_sim(1:100) = x_real(1:100);
y_sim(1:100) = y_real(1:100);

cd('./matlab_functions')
plot_XY_Des_Sim_Real(x, y, x_sim, y_sim, x_real, y_real, '../figure/plot_XY_des_sim_real_Posture.pdf')
pause(1)
cd('../')



%% Plot environment with Animation

% State Feedback + Cartesian
load('./data/desired_XY.mat');
final_des_trajectory.x = x;
final_des_trajectory.y = y;
load('./data/boh2_State_Posture.mat');
time_trajectory = out.output.time(1:3604-4);
final_output_trajectory.x = out.output.signals.values(4:3604,1); 
final_output_trajectory.y = out.output.signals.values(4:3604,2); 
final_output_trajectory.theta = deg2rad(out.output.signals.values(4:3604,3));
cd('./matlab_functions')
plot_animation_vehicle_SPARCS(time_trajectory, final_des_trajectory, final_output_trajectory, '../figure/Animation_Cartesian.gif')
pause(1)
cd('../')

% State Feedback + Posture
load('./data/desired_XY.mat');
final_des_trajectory.x = x;
final_des_trajectory.y = y;
load('./data/boh3_State_Posture.mat');
time_trajectory = out.output.time(1:end-3);
final_output_trajectory.x = out.output.signals.values(3:end,1); 
final_output_trajectory.y = out.output.signals.values(3:end,2); 
final_output_trajectory.theta = deg2rad(out.output.signals.values(3:end,3));
cd('./matlab_functions')
plot_animation_vehicle_SPARCS(time_trajectory, final_des_trajectory, final_output_trajectory, '../figure/Animation_Posture.gif')
pause(1)
cd('../')
