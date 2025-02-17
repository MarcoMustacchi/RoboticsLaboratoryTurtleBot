function plot_output_Chained(ans)
    
    figure
    title('$z$ coordinates through state transformation','Interpreter','Latex')
    hold all
    plot(ans.chain_out.time, ans.chain_out.signals.values(:,1), 'LineWidth', 1);
    plot(ans.chain_out.time, ans.chain_out.signals.values(:,2), 'LineWidth', 1);
    plot(ans.chain_out.time, ans.chain_out.signals.values(:,3), 'LineWidth', 1);
    hold off
    grid on; 
    xlabel('$t$ [s]','interpreter','latex')
    legend('$x$ [m]','$y$ [m]','$\theta$ [rad]','interpreter','latex','location','northwest');
    set(gca,'TickLabelInterpreter','latex')

end    