function plot_v_and_w(s, v, w)

    figure
    plot(s, v, 'LineWidth', 1);
    grid on; 
    title('Driving velocity','Interpreter','Latex');
    xlabel('$s$','interpreter','latex')
    ylabel('$v$ [m/s]','interpreter','latex')
    set(gca,'TickLabelInterpreter','latex')
    removeToolbarExplorationButtons(gcf)
    exportgraphics(gcf,'./figure/driving_velocity_des.pdf','ContentType','vector')
       
    figure
    plot(s, w, 'LineWidth', 1);
    grid on; 
    title('Steering velocity','Interpreter','Latex');
    xlabel('$s$','interpreter','latex')
    ylabel('$w$ [rad/s]','interpreter','latex')
    set(gca,'TickLabelInterpreter','latex')
    removeToolbarExplorationButtons(gcf)
    exportgraphics(gcf,'./figure/steering_velocity_des.pdf','ContentType','vector')

end