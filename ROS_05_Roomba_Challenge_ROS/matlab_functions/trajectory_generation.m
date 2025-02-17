function [t,x_dot,y_dot,x_dot_dot,y_dot_dot,theta,v,w,w_r_after,w_l_after] = trajectory_generation(unicycle,s,x,y,filenamePlot)
    
    % Before uniform Scaling Timing Law
    x_dot=gradient(x)./gradient(s);
    y_dot=gradient(y)./gradient(s);
    x_dot_dot=gradient(x_dot)./gradient(s);
    y_dot_dot=gradient(y_dot)./gradient(s);

    theta_adj = mod(atan2(y_dot,x_dot),2*pi);
    theta = unwrap(theta_adj);

    v = sqrt(x_dot.^2 + y_dot.^2);
    w = (x_dot.*y_dot_dot - x_dot_dot.*y_dot) ./ (x_dot.^2 + y_dot.^2);

    w_r_before = ((2 * v) + (w * unicycle.d)) / (2 * unicycle.r);
    w_l_before = ((2 * v) - (w * unicycle.d)) / (2 * unicycle.r);

    wheel_r_max_before = max(w_r_before);
    wheel_l_max_before = max(w_l_before);

    if wheel_r_max_before >= wheel_l_max_before
        wheel_max_before = wheel_r_max_before;
    else
        wheel_max_before = wheel_l_max_before;
    end

    % After uniform Scaling Timing Law
    wheel_max_after = input('Choose wheel speed max:'); % (if trajectory duration double, vd and wd will be half) 
                                                                % 8 for cubic trajectory
    t = s* (wheel_max_before / wheel_max_after);
    
    x_dot = gradient(x)./gradient(t); % derivative of x w.r.t. t
    y_dot = gradient(y)./gradient(t); % derivative of y w.r.t. t
    x_dot_dot = gradient(x_dot)./gradient(t); % derivative of x w.r.t. t
    y_dot_dot = gradient(y_dot)./gradient(t); % derivative of y w.r.t. t

    v = sqrt(x_dot.^2 + y_dot.^2);
    w = (x_dot.*y_dot_dot - x_dot_dot.*y_dot) ./ (x_dot.^2 + y_dot.^2);

    w_r_after = ((2 * v) + (w * unicycle.d)) / (2 * unicycle.r);
    w_l_after = ((2 * v) - (w * unicycle.d)) / (2 * unicycle.r);
    
    % Plot wheelSpeeds before and after uniform scaling
    figure;
    subplot(1,2,1)
    plot(s,w_r_before,'LineWidth',1)
    hold on
    plot(s,w_l_before,'LineWidth',1)
    grid on
    axis tight
    title('Before scaling Timing Law','Interpreter','latex')
    legend('$w_r$','$w_l$','interpreter','latex')
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
    legend('$w_r$','$w_l$','interpreter','latex')
    xlabel('$t$ [s]','interpreter','latex')
    ylabel('[rad/s]','interpreter','latex')
    set(gca,'TickLabelInterpreter','latex')

    picturewidth = 20; % set this parameter and keep it forever
    hw_ratio = 0.35; % feel free to play with this ratio (1 is a square)
    set(gcf,'Units','centimeters','Position',[3 3 picturewidth hw_ratio*picturewidth]) % for setting inMATLAB size 

    removeToolbarExplorationButtons(gcf)
    exportgraphics(gcf,filenamePlot,'ContentType','vector')
    
end