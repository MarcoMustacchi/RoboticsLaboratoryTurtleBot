%% offline differential flatness
vd = sqrt(x_dot.^2 + y_dot.^2);
wd = (x_dot.*y_dot_dot - x_dot_dot.*y_dot) ./ (x_dot.^2 + y_dot.^2); % warning, in Simulink no ./ but only / 
thetad = mod(atan2(y_dot,x_dot), 2*pi);