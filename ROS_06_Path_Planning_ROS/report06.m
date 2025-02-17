clear
clc

%% First Path - Cartesian Polynomials
% Same IC
load('./data/Feedforward_First.mat')
x_des = out.output.signals.values(:,1); y_des = out.output.signals.values(:,2); theta_des = out.output.signals.values(:,3);

plot_XY_Comparison(x_des, y_des, x_sim, y_sim, x_real, y_real, filenameXY)


% Different IC
load('./data/Cartesian_Desired.mat')
x_des = trajectory.x; y_des = trajectory.y; theta_des = trajectory.theta;
load('./data/StateFeedback_First_differentIC.mat')
x_state = out.output.signals.values(:,1); y_state = out.output.signals.values(:,2); theta_state = out.output.signals.values(:,3);
load('./data/Output_First_differentIC.mat')
% load('./data/sim_Output_Cartesian.mat')
x_output = out.output.signals.values(:,1); y_output = out.output.signals.values(:,2); theta_output = out.output.signals.values(:,3);
filenameXY = './figure/Cartesian_Comparison.pdf';
plot_XY_Comparison(x_des, y_des, x_state, y_state, x_output, y_output, theta_state, 0.2, filenameXY)


%% Test comparing K
load('./data/StateFeedback_First_differentIC.mat');
t = out.output.time;
x_des = out.reference.signals.values(:,1); y_des = out.reference.signals.values(:,2); theta_des = out.reference.signals.values(:,3);
x_real = out.output.signals.values(:,1); y_real = out.output.signals.values(:,2); theta_real = out.output.signals.values(:,3);
plot_XY_different_k(x_des, y_des, x_real, y_real, theta_real, 0.2, './figure/ki_10_kf_5.pdf')
plot_Orientation_different_k(t, theta_des, theta_real, './figure/ki_10_kf_5_Orientation.pdf')

load('./data/State_Feedback_First_ki_5_kf_10.mat');
t = ans.output.time;
x_des = ans.reference.signals.values(:,1); y_des = ans.reference.signals.values(:,2); theta_des = ans.reference.signals.values(:,3);
x_real = ans.output.signals.values(:,1); y_real = ans.output.signals.values(:,2); theta_real = ans.output.signals.values(:,3);
plot_XY_different_k(x_des, y_des, x_real, y_real, theta_real, 0.2, './figure/ki_5_kf_10.pdf')
plot_Orientation_different_k(t, theta_des, theta_real, './figure/ki_5_kf_10_Orientation.pdf')

load('./data/State_Feedback_First_ki_20_kf_20.mat');
t = ans.output.time;
x_des = ans.reference.signals.values(:,1); y_des = ans.reference.signals.values(:,2); theta_des = ans.reference.signals.values(:,3);
x_real = ans.output.signals.values(:,1); y_real = ans.output.signals.values(:,2); theta_real = ans.output.signals.values(:,3);
plot_XY_different_k(x_des, y_des, x_real, y_real, theta_real, 0.2, './figure/ki_20_kf_20.pdf')
plot_Orientation_different_k(t, theta_des, theta_real, './figure/ki_20_kf_20_Orientation.pdf')


%% limit case
load('./data/limit_case.mat');
t = out.output.time;
x_des = out.reference.signals.values(:,1); y_des = out.reference.signals.values(:,2); theta_des = out.reference.signals.values(:,3);
x_real = out.output.signals.values(:,1); y_real = out.output.signals.values(:,2); theta_real = out.output.signals.values(:,3);
plot_XY_different_k(x_des, y_des, x_real, y_real, theta_real, 0.2, './figure/limit_case_XY.pdf')
plot_Orientation_different_k(t, theta_des, theta_real, './figure/limit_case_orientation.pdf')


%% Second Path - Chained Form
% Different IC
load('./data/Chained_Desired.mat')
x_des = trajectory.xz; y_des = trajectory.yz; theta_des = trajectory.thetaz;
load('./data/StateLinear_Second_differentIC_Final.mat')
x_state = out.output.signals.values(:,1); y_state = out.output.signals.values(:,2); theta_state = out.output.signals.values(:,3);
load('./data/Output_Second_differentIC_Final.mat')
x_output = out.output.signals.values(:,1); y_output = out.output.signals.values(:,2); theta_output = out.output.signals.values(:,3);
filenameXY = './figure/Chained_Comparison.pdf';
plot_XY_Comparison(x_des, y_des, x_state, y_state, x_output, y_output, theta_state, 0.4, filenameXY)
