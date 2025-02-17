function plot_Errors(ans, filenameErrors, state)

    time = ans.output.time;
    e_x = ans.reference.signals.values(:,1) - ans.output.signals.values(:,1);
    e_y = ans.reference.signals.values(:,2) - ans.output.signals.values(:,2);
    if state==1
        e_theta = ans.reference.signals.values(:,3) - ans.output.signals.values(:,3);
    end

    figure
    hold all
    plot(time,e_x,'LineWidth', 1)
    plot(time,e_y,'LineWidth', 1)
    if state==1
        plot(time,e_theta,'LineWidth', 1)
    end
    hold off
    grid on
    title("Error's Dynamics",'Interpreter','latex')
    xlabel('$t$ [s]','interpreter','latex')
    xlim([0 ans.reference.time(end)])
    if state==1
        legend('$e_x$ [m]','$e_y$ [m]','$e_{\theta}$ [deg]','interpreter','latex','location','northeast');
    else
        legend('$e_x$ [m]','$e_y$ [m]','interpreter','latex','location','northeast');
    end
    set(gca,'TickLabelInterpreter','latex')
    removeToolbarExplorationButtons(gcf)
    exportgraphics(gcf,filenameErrors,'ContentType','vector')

end