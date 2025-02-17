function plot_wr_and_wl(t, wr, wl)

    figure
    plot(t, wr, 'LineWidth', 1);
    grid on; 
    title('Right Wheel Speed','Interpreter','Latex');
    xlabel('$t$','interpreter','latex')
    ylabel('$w_r$ [rad/s]','interpreter','latex')
    set(gca,'TickLabelInterpreter','latex')
    axis tight
    removeToolbarExplorationButtons(gcf)
    exportgraphics(gcf,'./figure/Right_Wheel_Speed_des.pdf','ContentType','vector')
       
    figure
    plot(t, wl, 'LineWidth', 1);
    grid on; 
    title('Left Wheel Speed','Interpreter','Latex');
    xlabel('$t$','interpreter','latex')
    ylabel('$w_l$ [rad/s]','interpreter','latex')
    set(gca,'TickLabelInterpreter','latex')
    axis tight
    removeToolbarExplorationButtons(gcf)
    exportgraphics(gcf,'./figure/Left_Wheel_Speed_des.pdf','ContentType','vector')

end