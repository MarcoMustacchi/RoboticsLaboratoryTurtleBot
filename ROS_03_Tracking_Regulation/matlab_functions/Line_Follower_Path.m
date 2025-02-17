%% Line Follower Trajectory
step_size = 0.01;
s = 0:step_size:1-step_size;

x_1 = linspace(0,0.78,length(s));
y_1 = transpose(zeros(length(s),1));

th = 0:pi/100:2*pi;
x_2 = 0.46 * cos(th) + 0.78;
y_2 = 0.46 * sin(th) + -0.46;
x_2_1 = flip(x_2(1:end/4));
y_2_1 = flip(y_2(1:end/4));
x_2_2 = flip(x_2(round(3*end/4):end));
y_2_2 = flip(y_2(round(3*end/4):end));
x_2_2 = x_2_2(2:end);
y_2_2 = y_2_2(2:end);

x_3 = flip(linspace(0,0.78,length(s)+1));
x_3 = x_3(2:end);
y_3 = transpose(ones(length(s)+1,1) * (-0.92));
y_3 = y_3(2:end);

th = 0:pi/100:2*pi;
x_4 = 0.12 * cos(th) + 0;
y_4 = 0.12 * sin(th) - 0.80;
x_4_1 = flip(x_4(round(2*end/4):round(3*end/4)-1));
y_4_1 = flip(y_4(round(2*end/4):round(3*end/4)-1)); 

x_5 = transpose(ones(length(s),1) * (-0.12));
x_5 = x_5(2:end);
y_5 = linspace(-0.8,-0.12,length(s));
y_5 = y_5(2:end);

th = 0:pi/100:2*pi;
x_6 = 0.12 * cos(th) + 0;
y_6 = 0.12 * sin(th) - 0.12;
x_6_1 = flip(x_6(round(end/4):round(2*end/4)));
y_6_1 = flip(y_6(round(end/4):round(2*end/4))); 

x = [x_1, x_2_1, x_2_2, x_3, x_4_1, x_5, x_6_1];
y = [y_1, y_2_1, y_2_2, y_3, y_4_1, y_5, y_6_1];

figure
hold all
plot(x,y,'LineWidth',1)
plot(x(1), y(1), 'go');
plot(x(end), y(end), 'rx');
hold off
grid on
axis equal

s = 0:step_size:5; % to modify
s = transpose(s); x = transpose(x); y = transpose(y);

% Trajectory generation
filenamePlot = '../figure/Line_Follower_Before_After_Timing_Law.pdf';
[t,x_dot,y_dot,x_dot_dot,y_dot_dot,theta,v_d,w_d] = trajectory_generation(unicycle,s,x,y,filenamePlot);
    
figure
title(theta)
plot(rad2deg(theta))

% Data for Simulink
[x_sim,y_sim,x_dot_sim,y_dot_sim,x_dot_dot_sim,y_dot_dot_sim,theta_sim] = data_simulink(t,x,y,x_dot,y_dot,x_dot_dot,y_dot_dot,theta);

Ts = t(2);