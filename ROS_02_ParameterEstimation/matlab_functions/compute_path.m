function [x,y,theta,v,w] = compute_path(s,x_i,y_i,theta_i,x_f,y_f,theta_f,k_i,k_f,step)
    
    % Compute [x,y]
    ax=k_f*cos(theta_f)-3*x_f;
    ay=k_f*sin(theta_f)-3*y_f;
    bx=k_i*cos(theta_i)+3*x_i;
    by=k_i*sin(theta_i)+3*y_i;
    x=x_f*s.^3 + ax*s.^2.*(s-1) + bx*s.*(s-1).^2 - (s-1).^3*x_i;
    y=y_f*s.^3 + ay*s.^2.*(s-1) + by*s.*(s-1).^2 - (s-1).^3*y_i;

    % Compute x_dot, y_dot, x_dot_dot, y_dot_dot
    x_dot=diff(x)/step;
    y_dot=diff(y)/step;
    x_dot_dot=diff(x_dot)/step;
    y_dot_dot=diff(y_dot)/step;

    %% dimensioni with diff si abbassa di 1 ..

    % Compute [theta]
    theta=atan2(y_dot,x_dot);

    % Compute [v]
    v=sqrt(x_dot.^2+y_dot.^2);

    % Compute [w]
    w=(x_dot(1:end-1).*y_dot_dot-x_dot_dot.*y_dot(1:end-1))./(x_dot(1:end-1).^2+y_dot(1:end-1).^2);
    
end