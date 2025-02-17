function plot_trajectory_animation(x, y, z, t)

    % Setting up the Plot
    figure; hold on
    title(sprintf('Trajectory\nTime: %0.2f sec', t(1)), 'Interpreter', 'Latex');
    xlabel('x', 'Interpreter', 'Latex')
    ylabel('y', 'Interpreter', 'Latex')
    zlabel('z', 'Interpreter', 'Latex')
    title('Environment Map','Interpreter','Latex','FontSize', 16)
    set(gca,'TickLabelInterpreter','Latex','DefaultTextInterpreter','Latex','DefaultLegendInterpreter','Latex')
    grid minor  % Adding grid lines
    axis equal  % Equal axis aspect ratio
    % view(45,45);  % Setting viewing angle
    
    % Create file name variable
    filename = 'animation.gif';
    % Plotting with no color to set axis limits
    plot3(x,y,z,'Color','none');
    % Plotting the first iteration
    p = plot3(x(1),y(1),z(1),'b');
    m = scatter3(x(1),y(1),z(1),'filled','b');
    % Iterating through the length of the time array
    for k = 1:length(t)
        % Updating the line
        p.XData = x(1:k);
        p.YData = y(1:k);
        p.ZData = z(1:k);
        % Updating the point
        m.XData = x(k); 
        m.YData = y(k);
        m.ZData = z(k);
        % Updating the title
        title(sprintf('Trajectory\nTime: %0.2f sec', t(k)),...
            'Interpreter','Latex');
        % Delay
        pause(0.01)
        % Saving the figure
        frame = getframe(gcf);
        im = frame2im(frame);
        [imind,cm] = rgb2ind(im,256);
        if k == 1
            imwrite(imind,cm,filename,'gif', 'Loopcount',inf,...
            'DelayTime',0.1);
        else
            imwrite(imind,cm,filename,'gif','WriteMode','append',...
            'DelayTime',0.1);
        end
    end

end