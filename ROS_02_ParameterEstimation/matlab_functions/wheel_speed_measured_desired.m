function wheel_speed_measured_desired(t,w_l_measured,w_l_desired,w_r_measured,w_r_desired)

    figure
    subplot(1,2,1)
    plot(t,w_l_measured)
    hold on
    plot(t,w_l_desired,'LineWidth',1)
    grid on
    axis tight
    title('Left Wheel Speed','Interpreter','latex')
    xlabel('$t$ [s]','interpreter','latex')
    ylabel('$w_l$ [rad/s]','interpreter','latex')
    legend('Wheel speed Measured','Wheel speed Desired','interpreter','latex','location','southeast');
    set(gca,'TickLabelInterpreter','latex')
    
    subplot(1,2,2)
    plot(t,w_r_measured)
    hold on
    plot(t,w_r_desired,'LineWidth',1)
    grid on
    axis tight
    title('Right Wheel Speed','Interpreter','latex')
    xlabel('$t$ [s]','interpreter','latex')
    ylabel('$w_r$ [rad/s]','interpreter','latex')
    legend('Wheel speed Measured','Wheel speed Desired','interpreter','latex','location','southeast');
    set(gca,'TickLabelInterpreter','latex')
    removeToolbarExplorationButtons(gcf)
    exportgraphics(gcf,'./figure/WheelSpeedMeasuredDesired.pdf','ContentType','vector')
   
end
