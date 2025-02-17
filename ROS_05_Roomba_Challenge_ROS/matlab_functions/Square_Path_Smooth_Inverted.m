%% Square trajectory - Smooth Inverted
k_i = 1; k_f = 1;
step_size = 0.01;
s = 0:step_size:1-step_size;

y_i = [0, 1, 1.5, 1.5, 1, 0];
y_f = [1, 1.5, 1.5, 1, 0, -0.5];
x_i = [0, 0, 0.5, 1.5, 2, 2];
x_f = [0, 0.5, 1.5, 2, 2, 1.5];
theta_i = [pi/2, pi/2, 0, 0, -pi/2, -pi/2];
theta_f = [pi/2, 0, 0, -pi/2, -pi/2, -pi];

for i = 1:length(x_i)
    [x_cell{i},y_cell{i}] = compute_path(s,x_i(i),y_i(i),theta_i(i),x_f(i),y_f(i),theta_f(i),k_i,k_f);
end

x = cell2mat(x_cell);
y = cell2mat(y_cell);

%%
s = 0:step_size:length(x_i)-step_size; % to modify
s = transpose(s); x = transpose(x); y = transpose(y);

% Trajectory generation
filenamePlot = './figure/Square_Smooth_Inverted_Timing_Law.pdf';
[t,x_dot,y_dot,x_dot_dot,y_dot_dot,theta,v_d,w_d,wr,wl] = trajectory_generation(unicycle,s,x,y,filenamePlot);


%% Plot environment
map = binaryOccupancyMap(7,5,'GridOriginInLocal',[-3.5,-2.5]);

figure
show(map)
hold all
title('SPARCS Lab','Interpreter','latex')
plot(x,y,'LineWidth',1.5)
plot(x(1), y(1), 'go');
plot(x(end), y(end), 'rx');

triangle_i = nsidedpoly(3, 'Center', [x(1), y(1)], 'SideLength', 0.3);
theta_i = rad2deg(theta(1)) - 90;
rotation_center_i = [x(1), y(1)];
triangle_rot_i = rotate(triangle_i,theta_i,rotation_center_i);
m = plot(triangle_rot_i);
m.FaceColor = [0 0.4470 0.7410];
plot(triangle_rot_i.Vertices(2,1), triangle_rot_i.Vertices(2,2), 'r.','MarkerSize', 10);
[b_xi, b_yi] = centroid(triangle_rot_i);
plot(b_xi, b_yi, 'b.','MarkerSize', 10);

legend('Desired Path','Initial Tracking Position','Final Tracking Position','interpreter','latex','location','southeast');
xlabel('$x$ [m]','interpreter','latex')
ylabel('$y$ [m]','interpreter','latex')
hold off
grid on
axis equal
set(gca,'TickLabelInterpreter','latex')
removeToolbarExplorationButtons(gcf)
exportgraphics(gcf,'./figure/SPARCS_Environment.pdf','ContentType','vector')

%%
figure
title(theta)
plot(rad2deg(theta))

%%
% Data for Simulink
[x_sim,y_sim,x_dot_sim,y_dot_sim,x_dot_dot_sim,y_dot_dot_sim,theta_sim] = data_simulink(t,x,y,x_dot,y_dot,x_dot_dot,y_dot_dot,theta);
