

%%
load('./data/Feedforward_8.mat')

time = out.output.time;

x = out.output.signals.values(:,1); % x odom
y = out.output.signals.values(:,2); % y odom
theta = out.output.signals.values(:,3); % theta odom

theta = ans.output.signals.values(:,3); % theta odom
figure
plot(theta)

theta_des = out.reference.signals.values(:,3);


figure
plot(time, theta)
hold on
plot(time, theta_des)
legend('odom', 'reference')

figure
plot(rad2deg(theta))


%%
x = out.output.signals.values(:,1); % x odom
y = out.output.signals.values(:,2); % y odom
theta = out.reference.signals.values(:,3); % theta odom

figure
plot(x,y)

figure
plot(theta)

%% Animation
% Create map and Animation final 
M = zeros(10); % 10x10 environment
% M(2:end-1,2:end-1) = 0; % matrix that has 1 in ther borders
bin = boolean(M);
map = binaryOccupancyMap(bin,'GridOriginInLocal',[-5,-5]);

time = out.output.time;
trajectory.x = out.output.signals.values(:,1); 
trajectory.y = out.output.signals.values(:,2); 
trajectory.theta =  deg2rad(out.output.signals.values(:,3));

filename = 'trajectory.gif';
plot_animation_vehicle(map, time, trajectory, filename);
