function [z1_i,z2_i,z3_i,z1_f,z2_f,z3_f] = cartesian2Chained(x_i,y_i,theta_i,x_f,y_f,theta_f)

    z1_i = theta_i;
    z2_i = cos(theta_i)*x_i + sin(theta_i)*y_i;
    z3_i = sin(theta_i)*x_i - cos(theta_i)*y_i;
    
    z1_f = theta_f;
    z2_f = cos(theta_f)*x_f + sin(theta_f)*y_f;
    z3_f = sin(theta_f)*x_f - cos(theta_f)*y_f;

end

