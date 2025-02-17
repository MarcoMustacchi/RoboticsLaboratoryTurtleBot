function [s,x,y,x_dot,y_dot,x_dot_dot,y_dot_dot,theta,t,v,w] = create_path_8(wp,toa,Fs,unicycle)

    wp = wp/4; % make path smaller

    % Create trajectory. 
    traj = waypointTrajectory(wp, toa, SampleRate=Fs);
    % Get position.
    s = 0:1/Fs:toa(end);
    pos = lookupPose(traj, s);
    x = pos(:,1);
    y = pos(:,2);
    % Plot.
    figure
    plot(x, y,'LineWidth',1)
    grid on
    axis equal
    title('XY Path desired','interpreter','latex')
    xlabel('$x$ [m]','interpreter','latex')
    ylabel('$y$ [m]','interpreter','latex')
    set(gca,'TickLabelInterpreter','latex')
    removeToolbarExplorationButtons(gcf)
    exportgraphics(gcf,'./figure/XY_Path_desired.pdf','ContentType','vector')
    
    s = transpose(s);
    x_dot = gradient(x)./gradient(s); % derivative of x w.r.t. t
    y_dot = gradient(y)./gradient(s); % derivative of y w.r.t. t
    x_dot_dot = gradient(x_dot)./gradient(s); % derivative of x w.r.t. t
    y_dot_dot = gradient(y_dot)./gradient(s); % derivative of y w.r.t. t
    theta = mod(atan2(y_dot,x_dot), 2*pi);

    v = sqrt(x_dot.^2 + y_dot.^2);
    w = (x_dot.*y_dot_dot - x_dot_dot.*y_dot) ./ (x_dot.^2 + y_dot.^2);

    w_r_before = ((2 * v) + (w * unicycle.d)) / (2 * unicycle.r);
    w_l_before = ((2 * v) - (w * unicycle.d)) / (2 * unicycle.r);

    figure
    plot(s,w_r_before,'LineWidth',1)
    hold on
    plot(s,w_l_before,'LineWidth',1)
    grid on
    axis tight
    legend('$\dot x$','$\dot y$','interpreter','latex')

    wheel_r_max_before = max(w_r_before);
    wheel_l_max_before = max(w_l_before);

    if wheel_r_max_before >= wheel_l_max_before
        wheel_max_before = wheel_r_max_before;
    else
        wheel_max_before = wheel_l_max_before;
    end

    % Specify time
    wheel_max_after = input('Choose wheel speed max:'); % (if trajectory duration double, vd and wd will be half) 
                                                                % 8 for cubic trajectory
    t = s* (wheel_max_before / wheel_max_after);

    close
    
    x_dot = gradient(x)./gradient(t); % derivative of x w.r.t. t
    y_dot = gradient(y)./gradient(t); % derivative of y w.r.t. t
    x_dot_dot = gradient(x_dot)./gradient(t); % derivative of x w.r.t. t
    y_dot_dot = gradient(y_dot)./gradient(t); % derivative of y w.r.t. t

    v = sqrt(x_dot.^2 + y_dot.^2);
    w = (x_dot.*y_dot_dot - x_dot_dot.*y_dot) ./ (x_dot.^2 + y_dot.^2);

    w_r_after = ((2 * v) + (w * unicycle.d)) / (2 * unicycle.r);
    w_l_after = ((2 * v) - (w * unicycle.d)) / (2 * unicycle.r);


    figure
    plot(t,v,'LineWidth',1)
    hold on
    plot(t,w,'LineWidth',1)
    grid on
    axis tight
    legend('$v$','$w$','interpreter','latex')
    
    figure
    subplot(1,2,1)
    plot(s,w_r_before,'LineWidth',1)
    hold on
    plot(s,w_l_before,'LineWidth',1)
    grid on
    axis tight
    title('Before scaling Timing Law','Interpreter','latex')
    legend('$w_r$','$w_r$','interpreter','latex')
    xlabel('$t$ [s]','interpreter','latex')
    ylabel('[rad/s]','interpreter','latex')
    set(gca,'TickLabelInterpreter','latex')
    
    subplot(1,2,2)
    plot(t,w_r_after,'LineWidth',1)
    hold on
    plot(t,w_l_after,'LineWidth',1)
    grid on
    axis tight
    title('After scaling Timing Law','Interpreter','latex')
    legend('$w_r$','$w_r$','interpreter','latex')
    xlabel('$t$ [s]','interpreter','latex')
    ylabel('[rad/s]','interpreter','latex')
    set(gca,'TickLabelInterpreter','latex')
    removeToolbarExplorationButtons(gcf)
    exportgraphics(gcf,'./figure/Before_After_Timing_Law.pdf','ContentType','vector')

end

