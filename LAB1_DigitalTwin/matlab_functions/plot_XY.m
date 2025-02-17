function plot_XY(ans)

    figure
    title('XY Trajectory','Interpreter','Latex');
    hold all
    plot(ans.output.signals.values(:,1), ans.output.signals.values(:,2), 'LineWidth', 1);
    plot(ans.output.signals.values(1,1), ans.output.signals.values(1,2), 'go');
    plot(ans.output.signals.values(end,1), ans.output.signals.values(end,2), 'rx');
    hold off
    grid on; 
    axis equal
    xlabel('$x$ [m]','interpreter','latex')
    ylabel('$y$ [m]','interpreter','latex')
    legend('Trajectory','Initial Position','Final Position','interpreter','latex','location','southeast');
    set(gca,'TickLabelInterpreter','latex')

end