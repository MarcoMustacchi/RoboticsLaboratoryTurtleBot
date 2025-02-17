

load('./data/Feedforward_Square.mat')


figure
plot(out.output.signals.values(:,1),out.output.signals.values(:,2))

figure
plot(out.output.signals.values(:,3))


figure
plot(out.command.signals.values(:,1))
hold on
plot(out.command.signals.values(:,2))


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