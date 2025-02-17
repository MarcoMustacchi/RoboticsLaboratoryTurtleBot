function [v,w] = odom2vel(odomBus, Ts)

    % Get (x,y,t)
    t = odomBus.Pose.Pose.Position.X.Time-odomBus.Pose.Pose.Position.X.Time(1);
    x = odomBus.Pose.Pose.Position.X.Data;
    y = odomBus.Pose.Pose.Position.Y.Data;

    % Calculate theta from the real part of the quaternion 
    theta = 2*acos(odomBus.Pose.Pose.Orientation.W.Data);
    % Note that this is only true of unit quaternions. Non-unit quaternions do not represent rotations.
    
    % low-pass filter
    wc = 2*pi*1;
    d = 1/sqrt(2);
    sysHi = tf(wc^2,[1,2*d*wc,wc^2]);
    sysHi = c2d(sysHi,Ts,'tustin');
    [numHi,denHi] = tfdata(sysHi,'v');
    
    % Apply filter to x , y , theta
    x = filter(numHi,denHi,x);
    y = filter(numHi,denHi,y);
    theta = filter(numHi,denHi,theta);

    % Another method to calculate theta using conversion from quat -> euler 
    % q_x = odom.Pose.Pose.Orientation.X.Data;
    % q_y = odom.Pose.Pose.Orientation.Y.Data;
    % q_z = odom.Pose.Pose.Orientation.Z.Data;
    % q_w = odom.Pose.Pose.Orientation.W.Data;
    % 
    % q = cat(2,q_x,q_y,q_z,q_w); 
    % eulZYX = quat2eul(q,'ZYX');
    % theta = eulZYX(:,3);
    
    v = zeros(size(x));
    w = zeros(size(x));

%     for i = 1:length(x)-1
%         Ts = t(i+1) - t(i);
%  
%         % Calculate angular velocity (w)
%         w(i) = (theta(i+1) - theta(i)) / Ts;
%     
%         % Calculate linear velocity (v)
%         % check if (w) close to zero (moving forward)
%         if abs(w(i)) <= .001
%             % Rung-Kutta method
%             v(i) = (y(i+1) - y(i)) ./ (sin(theta(i)+w(i)*Ts/2)*Ts); 
%         else
%             % Exact Reconstruction
%             v(i) = -(y(i+1) - y(i))*w(i) ./ (cos(theta(i+1))-cos(theta(i)));
%         end
%     end

    for i = 1:length(x)-1
        Ts = t(i+1) - t(i);
 
        % Calculate angular velocity (w)
        w(i) = (theta(i+1) - theta(i)) / Ts;
    
        % Calculate linear velocity (v)
        % check if (w) close to zero (moving forward)
        if w(i) <= .001
            % Rung-Kutta method
            v(i) = (x(i+1) - x(i)) ./ (cos(theta(i)+w(i)*Ts/2)*Ts); 
        else
            % Exact Reconstruction
            v(i) = (x(i+1) - x(i))*w(i) ./ (sin(theta(i+1))-sin(theta(i)));
        end
    end

end

