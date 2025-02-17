function path_comparison(path, filenamePathComparison)
    
    path.true.theta_ic = path.true.theta_ic;

    % Rotate frame 
    R = [cos(path.true.theta_ic) sin(path.true.theta_ic); 
        -sin(path.true.theta_ic) cos(path.true.theta_ic)];
    xy_true = [path.true.x, path.true.y];
    so = R*transpose(xy_true);  
    x_rotated = so(1,:);
    y_rotated = so(2,:);

    % Offset in XY
    offset_x = x_rotated(1);
    offset_y = y_rotated(1);

    % Plot
    figure
    title('XY Path','Interpreter','Latex');
    hold all
    plot(path.desired.x, path.desired.y,'LineWidth',1)
    plot(x_rotated-offset_x, y_rotated-offset_y,'LineWidth',1)
    plot(path.reconstructed.x, path.reconstructed.y,'LineWidth',1)
    hold off
    grid on; 
    axis equal
    xlabel('$x$ [m]','interpreter','latex')
    ylabel('$y$ [m]','interpreter','latex')
    legend('Path desired','Path measured','Path reconstructed','interpreter','latex','location','southeast');
    set(gca,'TickLabelInterpreter','latex')
    removeToolbarExplorationButtons(gcf)
    exportgraphics(gcf,filenamePathComparison,'ContentType','vector')
   
end

