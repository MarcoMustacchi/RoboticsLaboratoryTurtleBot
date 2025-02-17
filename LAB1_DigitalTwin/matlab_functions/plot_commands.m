function plot_commands(ans)

    figure
    plot(ans.command.time, ans.command.signals.values(:,1), 'LineWidth', 1);
    hold on
    plot(ans.command.time, ans.command.signals.values(:,2), 'LineWidth', 1);
    grid on; 
    title('Input signals for the DDR','Interpreter','Latex');
    xlabel('$t$ [s]','interpreter','latex')
    ylabel('[rad/s]','interpreter','latex')
    legend('$w_r$','$w_l$','interpreter','latex','location','northwest');
    set(gca,'TickLabelInterpreter','latex')
    
end