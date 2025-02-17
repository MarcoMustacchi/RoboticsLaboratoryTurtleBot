function [x, y, theta, v, w] = odomReconstruction(unicycle, wl, wr, x0, y0, theta0, Ts)

    v = unicycle.r * (wl + wr) / 2;
    w = unicycle.r * (wl - wr) / unicycle.d;
   
    x = zeros(size(v));
    y = zeros(size(v));
    theta = zeros(size(v));

    x(1) = x0;
    y(1) = y0;
    theta(1) = theta0;

    for i = 1:length(v)-1
        % Second order integration - Runge-Kutta method
        x(i+1) = x(i) + v(i)*Ts*cos(theta(i) + (w(i)*Ts)/2);
        y(i+1) = y(i) + v(i)*Ts*sin(theta(i) + (w(i)*Ts)/2);
        theta(i+1) = theta(i) + w(i)*Ts;
    end

%     for i = 1:length(v)-1
%         if abs(w(i)) < 0.001 
%             % Second order integration - Runge-Kutta method
%             x(i+1) = x(i) + v(i)*Ts*cos(theta(i) + (w(i)*Ts)/2);
%             y(i+1) = y(i) + v(i)*Ts*sin(theta(i) + (w(i)*Ts)/2);
%             theta(i+1) = theta(i) + w(i)*Ts;
%         else
%             % Exact method
%             x(i+1) = x(i) + (v(i)/w(i)) * (sin(theta(i+1)) - sin(theta(i)));
%             y(i+1) = y(i) - (v(i)/w(i)) * (cos(theta(i+1)) - cos(theta(i)));
%             theta(i+1) = theta(i) + w(i)*Ts;
%         end
%     end

end
