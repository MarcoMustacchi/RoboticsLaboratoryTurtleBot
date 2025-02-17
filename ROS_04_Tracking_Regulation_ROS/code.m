%% Apply Cartesian regulation
x0 = [0.7, 0.0, -0.7, -1.0, -0.7, 0.0, 0.7, 1.0];
y0 = [0.7, 1.0, 0.7, 0.0, -0.7, -1.0, -0.7, 0.0];

% insert in Simulink scheme the variable x_i and y_i
for i = 1:length(x0)
    x_i = x0(i);
    y_i = y0(i);
    x_f = 0;
    y_f = 0;
    sim('./simulink_models/State_Feedback_NON_Linear.slx','StopTime',num2str(t(end)));
    save();
end

% Cartesian Regulation - Controller definition
K_v = 1;
K_w = 1;

% Simulation
unicycle.ic.x = x_i;
unicycle.ic.y = y_i;
unicycle.ic.theta = theta_i;
Ts = unicycle.Ts;
Ts = t(2);
sim('./simulink_models/State_Feedback_Linear.slx','StopTime',num2str(t(end)),'FixedStep',num2str(Ts))

figure
plot(ans.reference.signals.values(:,1),ans.reference.signals.values(:,2),'LineWidth',1)
hold on
plot(ans.output.signals.values(:,1),ans.output.signals.values(:,2),'--','LineWidth',1)


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

% Posture Regulation - Controller definition
b = 2;
K1 = 1;
K2 = 1;

% Simulation
unicycle.ic.x = x_i;
unicycle.ic.y = y_i;
unicycle.ic.theta = theta_i;
Ts = unicycle.Ts;
Ts = t(2);
sim('./simulink_models/State_Feedback_Linear.slx','StopTime',num2str(t(end)),'FixedStep',num2str(Ts))

figure
plot(ans.reference.signals.values(:,1),ans.reference.signals.values(:,2),'LineWidth',1)
hold on
plot(ans.output.signals.values(:,1),ans.output.signals.values(:,2),'--','LineWidth',1)