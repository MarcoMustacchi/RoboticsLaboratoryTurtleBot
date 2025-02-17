function plot_Commands_Comparison(t, wr_sim, wl_sim, wr_real, wl_real, unicycle, filenameCommands)

	figure
	sgtitle('DDR Wheels Speed Commands','Interpreter','latex')
	
    subplot(1,2,1)
    hold all
    plot(t, wl_sim(1:length(wl_real)), 'LineWidth', 1);
    plot(t, wl_real, 'LineWidth', 1);
    hold off
    grid on; 
	yline(unicycle.omegaWheelMax,'r--')
	yline(unicycle.omegaWheelMin,'r--')
    ylim([-10 10])
    xlabel('$t$ [s]','interpreter','latex')
    ylabel('$w_l$ [rad/s]','interpreter','latex')
    legend('Simulation','SPARCS','Saturation','interpreter','latex','location','southeast');
    set(gca,'TickLabelInterpreter','latex')

    subplot(1,2,2)
    hold all
    plot(t, wr_sim(1:length(wr_real)), 'LineWidth', 1);
    plot(t, wr_real, 'LineWidth', 1);
    hold off
    grid on; 
    yline(unicycle.omegaWheelMax,'r--')
    yline(unicycle.omegaWheelMin,'r--')
    ylim([-10 10])
    xlabel('$t$ [s]','interpreter','latex')
    ylabel('$w_r$ [rad/s]','interpreter','latex')
    legend('Simulation','SPARCS','Saturation','interpreter','latex','location','southeast');
    set(gca,'TickLabelInterpreter','latex')

    picturewidth = 20; % set this parameter and keep it forever
    hw_ratio = 0.35; % feel free to play with this ratio (1 is a square)
    set(gcf,'Units','centimeters','Position',[3 3 picturewidth hw_ratio*picturewidth]) % for setting inMATLAB size 
	
    removeToolbarExplorationButtons(gcf)
    exportgraphics(gcf,filenameCommands,'ContentType','vector')

end