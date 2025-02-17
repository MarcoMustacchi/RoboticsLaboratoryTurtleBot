function plot_Orientation_different_k(t, tht_des, tht_state, filenameXY)

    figure
    title('$\theta$','Interpreter','Latex');
    hold all
    plot(t, tht_des, 'LineWidth', 1.5);
    plot(t, tht_state, '--', 'LineWidth', 1.5);
    hold off
    grid on; 
    axis equal
    xlabel('$t$ [s]','interpreter','latex')
    ylabel('$\theta$ [deg]','interpreter','latex')
    legend('Desired orientation','Real orientation','interpreter','latex','location','northeast');
    set(gca,'TickLabelInterpreter','latex')
    axis tight
    removeToolbarExplorationButtons(gcf)
    exportgraphics(gcf,filenameXY,'ContentType','vector')

end