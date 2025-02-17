function plot_animation_vehicle(map, time_trajectory, final_output_trajectory, final_des_trajectory, filename)

    FigH = figure('Position', get(0, 'Screensize'));
    show(map)
    % view(45,45)
    grid on
    xlabel('$x$ [m]','Interpreter','Latex')
    ylabel('$y$ [m]','Interpreter','Latex')
    title('Environment Map','Interpreter','Latex','FontSize', 16)
    set(gca,'TickLabelInterpreter','Latex','DefaultTextInterpreter','Latex','DefaultLegendInterpreter','Latex')
    hold all

    title(sprintf('Trajectory\nTime: %0.2f sec', time_trajectory(1)),'Interpreter','Latex','FontSize', 14);

    % Plotting trajectory in the map
    plot(final_des_trajectory.x, final_des_trajectory.y,'LineWidth', 1, 'Color', [0.8500 0.3250 0.0980]);
        
    % Plotting the first iteration
    p = plot(final_output_trajectory.x(1),final_output_trajectory.y(1),'b','LineWidth', 1);
    % m = scatter(final_output_trajectory(1,1),final_output_trajectory(1,2),'>','filled','b','LineWidth', 1);    
    m = plot_vehicle(final_output_trajectory.x(1), final_output_trajectory.y(1), final_output_trajectory.theta(1), 0.5);

    % Iterating through the length of the time array
    for k = 1:100:length(time_trajectory)-1
        % Updating the line
        p.XData = final_output_trajectory.x(1:k);
        p.YData = final_output_trajectory.y(1:k);
        % Updating the point
        % theta = final_output_trajectory(k,3);
        % m.XData = final_output_trajectory(k,1); 
        % m.YData = final_output_trajectory(k,2);
        delete(m); % the plot function returns an argument that is a handle to the plotted object
        m = plot_vehicle(final_output_trajectory.x(k), final_output_trajectory.y(k), final_output_trajectory.theta(k), 0.5);
        % Updating the title
        title(sprintf('Trajectory\nTime: %0.2f sec', time_trajectory(k)),...
        'Interpreter','Latex');
        % Delay
        pause(0.2)
        % Saving the figure
        frame = getframe(FigH);
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

