clear unicycle

%% Unicycle model
unicycle.r = 0.034;    % wheel radius [m]
unicycle.d = 0.165;     % wheel distance [m]
unicycle.Ts = 0.1;   % l.p.f. time constant [s]
% unicycle.Td = 0.01;   % l.p.f. time constant [s]
unicycle.omegaWheelMax = 9;   % max wheels speed [rad/s]
unicycle.omegaWheelMin = -9;  % min wheels speed [rad/s]

% initial condition
unicycle.ic.x = 0;       % initial x coordinate [m]
unicycle.ic.y = 0;       % initial y coordinate [m]
unicycle.ic.theta = deg2rad(0);   % initial heading angle [rad]