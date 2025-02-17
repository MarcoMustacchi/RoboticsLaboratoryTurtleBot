function plot_report(s, x, y, theta, filenameXY, filenameOrientation, Intermediate)

    figure
    title('XY Path','Interpreter','Latex');
    hold all
    plot(x, y, 'LineWidth', 1);
    plot(x(1), y(1), 'go');
    if Intermediate==1
        plot(x(end/2), y(end/2), 'b*');
    end
    plot(x(end), y(end), 'rx');
    hold off
    grid on; 
    axis equal
    xlabel('$x$ [m]','interpreter','latex')
    ylabel('$y$ [m]','interpreter','latex')
    if Intermediate==0
        legend('Trajectory','Initial Position','Final Position','interpreter','latex','location','southeast');
    else
        legend('Trajectory','Initial Position','Intermediate Position','Final Position','interpreter','latex','location','southeast');
    end
    set(gca,'TickLabelInterpreter','latex')
    removeToolbarExplorationButtons(gcf)
    exportgraphics(gcf,filenameXY,'ContentType','vector')
       
    figure
    plot(s, theta, 'LineWidth', 1);
    grid on; 
    axis equal
    title('Orientation Path','Interpreter','Latex');
    xlabel('$s$','interpreter','latex')
    ylabel('$\theta$ [rad]','interpreter','latex')
    set(gca,'TickLabelInterpreter','latex')
    removeToolbarExplorationButtons(gcf)
    exportgraphics(gcf,filenameOrientation,'ContentType','vector')

end

