function plot_Commands(ans, unicycle, filenameCommands)

	figure
	sgtitle('DDR Wheels Speed Commands','Interpreter','latex')
	
    subplot(1,2,1)
    plot(ans.command.time, ans.command.signals.values(:,1), 'LineWidth', 1);
    grid on; 
    yline(unicycle.omegaWheelMax,'r--')
    xlim([0 ans.command.time(end)])
    ylim([-inf unicycle.omegaWheelMax+2])
    xlabel('$t$ [s]','interpreter','latex')
    ylabel('$w_l$ [rad/s]','interpreter','latex')
    set(gca,'TickLabelInterpreter','latex')
    
    subplot(1,2,2)
    plot(ans.command.time, ans.command.signals.values(:,2), 'LineWidth', 1);
    grid on; 
	yline(unicycle.omegaWheelMax,'r--')
    xlim([0 ans.command.time(end)])
    ylim([-inf unicycle.omegaWheelMax+2])
    xlabel('$t$ [s]','interpreter','latex')
    ylabel('$w_r$ [rad/s]','interpreter','latex')
    set(gca,'TickLabelInterpreter','latex')
	
    removeToolbarExplorationButtons(gcf)
    exportgraphics(gcf,filenameCommands,'ContentType','vector')

end