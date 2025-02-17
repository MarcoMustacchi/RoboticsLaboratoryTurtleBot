function plot_XY_Des_Sim_Real(x_des, y_des, x_sim, y_sim, x_real, y_real, filenameXY)

    figure
    title('XY Path','Interpreter','Latex');

    hold all
    plot(x_des, y_des, 'LineWidth', 1.5);
    plot(x_sim, y_sim, '--', 'LineWidth', 1.5);
    plot(x_real, y_real, ':', 'LineWidth', 1.5);
    plot(x_des(1), y_des(1), 'go');
    plot(x_des(end), y_des(end), 'rx');
    hold off

    grid on; 
    axis equal
    xlabel('$x$ [m]','interpreter','latex')
    ylabel('$y$ [m]','interpreter','latex')
    legend('Desired Trajectory','Simulation Trajectory','SPARCS Trajectory','Initial Tracking Position','Final Tracking Position','interpreter','latex','location','northeast');
    
    set(gca,'TickLabelInterpreter','latex')
    removeToolbarExplorationButtons(gcf)
    exportgraphics(gcf,filenameXY,'ContentType','vector')

end