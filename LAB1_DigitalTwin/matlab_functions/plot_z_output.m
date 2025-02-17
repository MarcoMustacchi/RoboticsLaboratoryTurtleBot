function plot_z_output(ans)
    
    %% Hold on plot
    figure
    title('$z$ coordinates through kinematic block','Interpreter','Latex')
    hold all
    plot(ans.output.time, ans.z_output.signals.values(:,1), 'LineWidth', 1);
    plot(ans.output.time, ans.z_output.signals.values(:,2), 'LineWidth', 1);
    plot(ans.output.time, ans.z_output.signals.values(:,3), 'LineWidth', 1);
    hold off
    grid on; 
    xlabel('$t$ [s]','interpreter','latex')
    % ylabel('$x$ [m]','interpreter','latex')
    legend('$z_1$ [m]','$z_2$ [m]','$z_3$ [rad]','interpreter','latex','location','northwest');
    set(gca,'TickLabelInterpreter','latex')

end