function [xz,yz,thetaz] = compute_path_z(s,z1_i,z2_i,z3_i,z1_f,z2_f,z3_f)

    % Compute [xz,yz]
    alpha = z2_f*(z1_f-z1_i) - 3*z3_f;
    beta = z2_i*(z1_f-z1_i) + 3*z3_i;
    z1 = z1_f*s - (s-1)*z1_i;
    z3 = z3_f*s.^3 + alpha*s.^2.*(s-1) + beta*s.*(s-1).^2 - (s-1).^3*z3_i;

    %% come calcolare z2 ??
    % Compute x_dot, y_dot, x_dot_dot, y_dot_dot
    z1_dot=gradient(z1)./gradient(s);
    z3_dot=gradient(z3)./gradient(s);

    z2 = z3_dot./z1_dot;

    % Compute [thetaz]
    xz = z2.*cos(z1) + z3.*sin(z1);
    yz = z2.*sin(z1) - z3.*cos(z1);
    thetaz = z1;
    
end