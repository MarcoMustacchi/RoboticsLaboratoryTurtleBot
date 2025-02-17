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


%% Plot XY
figure
hold all
title('Square Path Smooth','Interpreter','latex','FontSize', 14);
plot(x,y,'LineWidth',1.5)
plot(x(1), y(1), 'go');
plot(x(end), y(end), 'rx');
legend('Desired Path','Initial Tracking Position','Final Tracking Position','interpreter','latex','location','southwest');
xlabel('$x$ [m]','interpreter','latex')
ylabel('$y$ [m]','interpreter','latex')
hold off
grid on
axis equal
set(gca,'TickLabelInterpreter','latex')
removeToolbarExplorationButtons(gcf)
exportgraphics(gcf,'./figure/Square_Path_Smooth.pdf','ContentType','vector')


%% Plot Positions, Velocities, Accelerations
figure
sgtitle('Reference: Positions, Velocities, Accelerations','Interpreter','Latex','FontSize', 14);
subplot(2,3,1)
plot(t,x,'LineWidth', 1)
xlabel('$t$ [s]','interpreter','latex')
ylabel('$x_d$ [m]','interpreter','latex')
grid on

subplot(2,3,2)
plot(t,x_dot,'LineWidth', 1)
xlabel('$t$ [s]','interpreter','latex')
ylabel('$\dot{x}_d$ [m/s]','interpreter','latex')
grid on

subplot(2,3,3)
plot(t,x_dot_dot,'LineWidth', 1)
xlabel('$t$ [s]','interpreter','latex')
ylabel('$\ddot{x}_d$ [m/$s^2$]','interpreter','latex')
grid on

subplot(2,3,4)
plot(t,y,'LineWidth', 1)
xlabel('$t$ [s]','interpreter','latex')
ylabel('${y}_d$ [m]','interpreter','latex')
grid on

subplot(2,3,5)
plot(t,y_dot,'LineWidth', 1)
xlabel('$t$ [s]','interpreter','latex')
ylabel('$\dot{y}_d$ [m/s]','interpreter','latex')
grid on

subplot(2,3,6)
plot(t,y_dot_dot,'LineWidth', 1)
xlabel('$t$ [s]','interpreter','latex')
ylabel('$\ddot{y}_d$ [m/$s^2$]','interpreter','latex')
grid on

set(findobj(gcf,'type','axes'),'Xlim',[0 t(end)],'TickLabelInterpreter','latex');
picturewidth = 20; % set this parameter and keep it forever
hw_ratio = 0.25; % feel free to play with this ratio (1 is a square)
set(gcf,'Units','centimeters','Position',[3 3 picturewidth hw_ratio*picturewidth]) % for setting inMATLAB size 
exportgraphics(gcf,'./figure/Pos_Vel_Acc.pdf','ContentType','vector')

%% Orientation
figure
plot(t, rad2deg(theta),'LineWidth', 1)
xlabel('$t$ [s]','interpreter','latex')
ylabel('$\theta$ [rad]','interpreter','latex')
grid on
title('Reference: Orientation','Interpreter','Latex','FontSize', 14);
set(gca,'TickLabelInterpreter','latex')
set(findobj(gcf,'type','axes'),'Xlim',[0 t(end)],'TickLabelInterpreter','latex');
removeToolbarExplorationButtons(gcf)
picturewidth = 20; % set this parameter and keep it forever
hw_ratio = 0.35; % feel free to play with this ratio (1 is a square)
set(gcf,'Units','centimeters','Position',[3 3 picturewidth hw_ratio*picturewidth]) % for setting inMATLAB size 
exportgraphics(gcf,'./figure/Orientation.pdf','ContentType','vector')

%%
% Data for Simulink
[x_sim,y_sim,x_dot_sim,y_dot_sim,x_dot_dot_sim,y_dot_dot_sim,theta_sim] = data_simulink(t,x,y,x_dot,y_dot,x_dot_dot,y_dot_dot,theta);