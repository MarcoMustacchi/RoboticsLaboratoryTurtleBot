function plot_Pos_Orient_Comparison(t, idx_switch, x_sim, y_sim, theta_sim, x_real, y_real, theta_real, x_des, y_des, theta_des, type)

    t_x = t(1:3642);
    t_y = t(1:3597);
    t_theta = t(1:3597);
    x_real = x_real(1:3642);
    y_real = y_real(1:3597);
    theta_real = theta_real(1:3597);

    % X
	figure
    hold all
    plot(t_x, x_des(1:length(x_real)), 'LineWidth', 1,'Color',[0.4660 0.6740 0.1880]);
    plot(t_x, x_sim(1:length(x_real)), 'LineWidth', 1,'Color',[0 0.4470 0.7410]);
    plot(t_x, x_real, 'LineWidth', 1,'Color',[0.8500 0.3250 0.0980]);
    hold off
    grid on; 
	title('X','Interpreter','latex')
    xlabel('$t$ [s]','interpreter','latex')
    ylabel('$x$ [m]','interpreter','latex')
    legend('Desired','Simulation','SPARCS','interpreter','latex','location','best');
    set(gca,'TickLabelInterpreter','latex')
    picturewidth = 20; % set this parameter and keep it forever
    hw_ratio = 0.35; % feel free to play with this ratio (1 is a square)
    set(gcf,'Units','centimeters','Position',[3 3 picturewidth hw_ratio*picturewidth]) % for setting inMATLAB size 
    removeToolbarExplorationButtons(gcf)
    if all(type == 'Cartesian')
        exportgraphics(gcf,'../figure/Pos_Orien_Errors_wrt_Time/plot_X_Comparison_Cartesian.pdf','ContentType','vector')
    else
        exportgraphics(gcf,'../figure/Pos_Orien_Errors_wrt_Time/plot_X_Comparison_Posture.pdf','ContentType','vector')
    end

    % Y
    figure
    hold all
    plot(t_y, y_des(1:length(y_real)), 'LineWidth', 1,'Color',[0.4660 0.6740 0.1880]);
    plot(t_y, y_sim(1:length(y_real)), 'LineWidth', 1,'Color',[0 0.4470 0.7410]);
    plot(t_y, y_real, 'LineWidth', 1,'Color',[0.8500 0.3250 0.0980]);
    hold off
    grid on; 
	title('Y','Interpreter','latex')
    xlabel('$t$ [s]','interpreter','latex')
    ylabel('$y$ [m]','interpreter','latex')
    legend('Desired','Simulation','SPARCS','interpreter','latex','location','best');
    set(gca,'TickLabelInterpreter','latex')
    picturewidth = 20; % set this parameter and keep it forever
    hw_ratio = 0.35; % feel free to play with this ratio (1 is a square)
    set(gcf,'Units','centimeters','Position',[3 3 picturewidth hw_ratio*picturewidth]) % for setting inMATLAB size 
    removeToolbarExplorationButtons(gcf)
    if all(type == 'Cartesian')
        exportgraphics(gcf,'../figure/Pos_Orien_Errors_wrt_Time/plot_Y_Comparison_Cartesian.pdf','ContentType','vector')
    else
        exportgraphics(gcf,'../figure/Pos_Orien_Errors_wrt_Time/plot_Y_Comparison_Posture.pdf','ContentType','vector')
    end

    % Theta
    figure
    hold all
    if all(type == 'Cartesian')
        plot(t_theta(1:idx_switch), theta_des(1:idx_switch), 'LineWidth', 1,'Color',[0.4660 0.6740 0.1880]);
    else
        plot(t_theta, theta_des(1:length(theta_real)), 'LineWidth', 1,'Color',[0.4660 0.6740 0.1880]);
    end
    plot(t_theta, theta_sim(1:length(theta_real)), 'LineWidth', 1,'Color',[0 0.4470 0.7410]);
    plot(t_theta, theta_real, 'LineWidth', 1,'Color',[0.8500 0.3250 0.0980]);
    hold off
    grid on; 
	title('$\theta$','Interpreter','latex')
    xlabel('$t$ [s]','interpreter','latex')
    ylabel('$\theta$ [deg]','interpreter','latex')
    legend('Desired','Simulation','SPARCS','interpreter','latex','location','best');
    set(gca,'TickLabelInterpreter','latex')
    picturewidth = 20; % set this parameter and keep it forever
    hw_ratio = 0.35; % feel free to play with this ratio (1 is a square)
    set(gcf,'Units','centimeters','Position',[3 3 picturewidth hw_ratio*picturewidth]) % for setting inMATLAB size 
    removeToolbarExplorationButtons(gcf)
    if all(type == 'Cartesian')
        exportgraphics(gcf,'../figure/Pos_Orien_Errors_wrt_Time/plot_Theta_Comparison_Cartesian.pdf','ContentType','vector')
    else
        exportgraphics(gcf,'../figure/Pos_Orien_Errors_wrt_Time/plot_Theta_Comparison_Posture.pdf','ContentType','vector')
    end
	
	pause(5)
	close all

    %% Errors
    ex_sim = x_des(1:3642) - x_sim(1:length(x_real));
    ey_sim = y_des(1:3597) - y_sim(1:length(y_real));
    etheta_sim = theta_des(1:3597) - theta_sim(1:length(theta_real));

    ex_real = x_des(1:3642) - x_real;
    ey_real = y_des(1:3597) - y_real;
    etheta_real = theta_des(1:3597) - theta_real;

    % X
	figure
    hold all
    plot(t_x, ex_sim, 'LineWidth', 1);
    plot(t_x, ex_real, 'LineWidth', 1);
    hold off
    grid on; 
	title('Error X','Interpreter','latex')
    xlabel('$t$ [s]','interpreter','latex')
    ylabel('$e_x$ [m]','interpreter','latex')
    legend('Simulation','SPARCS','interpreter','latex','location','best');
    set(gca,'TickLabelInterpreter','latex')
    picturewidth = 20; % set this parameter and keep it forever
    hw_ratio = 0.35; % feel free to play with this ratio (1 is a square)
    set(gcf,'Units','centimeters','Position',[3 3 picturewidth hw_ratio*picturewidth]) % for setting inMATLAB size 
    removeToolbarExplorationButtons(gcf)
    if all(type == 'Cartesian')
        exportgraphics(gcf,'../figure/Pos_Orien_Errors_wrt_Time/plot_Error_X_Comparison_Cartesian.pdf','ContentType','vector')
    else
        exportgraphics(gcf,'../figure/Pos_Orien_Errors_wrt_Time/plot_Error_X_Comparison_Posture.pdf','ContentType','vector')
    end

    % Y
    figure
    hold all
    plot(t_y, ey_sim, 'LineWidth', 1);
    plot(t_y, ey_real, 'LineWidth', 1);
    hold off
    grid on; 
	title('Error Y','Interpreter','latex')
    xlabel('$t$ [s]','interpreter','latex')
    ylabel('$e_y$ [m]','interpreter','latex')
    legend('Simulation','SPARCS','interpreter','latex','location','best');
    set(gca,'TickLabelInterpreter','latex')
    picturewidth = 20; % set this parameter and keep it forever
    hw_ratio = 0.35; % feel free to play with this ratio (1 is a square)
    set(gcf,'Units','centimeters','Position',[3 3 picturewidth hw_ratio*picturewidth]) % for setting inMATLAB size 
    removeToolbarExplorationButtons(gcf)
    if all(type == 'Cartesian')
        exportgraphics(gcf,'../figure/Pos_Orien_Errors_wrt_Time/plot_Error_Y_Comparison_Cartesian.pdf','ContentType','vector')
    else
        exportgraphics(gcf,'../figure/Pos_Orien_Errors_wrt_Time/plot_Error_Y_Comparison_Posture.pdf','ContentType','vector')
    end

    % Theta
    figure
    hold all
    if all(type == 'Cartesian')
        plot(t_theta(1:idx_switch-5), etheta_sim(1:idx_switch-5), 'LineWidth', 1);
        plot(t_theta(1:idx_switch-5), etheta_real(1:idx_switch-5), 'LineWidth', 1);
    else
        plot(t_theta, etheta_sim, 'LineWidth', 1);
        plot(t_theta, etheta_real, 'LineWidth', 1);
    end
    
    hold off
    grid on; 
	title('Error $\theta$','Interpreter','latex')
    xlabel('$t$ [s]','interpreter','latex')
    ylabel('$e_{\theta}$ [deg]','interpreter','latex')
    legend('Simulation','SPARCS','interpreter','latex','location','best');
    set(gca,'TickLabelInterpreter','latex')
    picturewidth = 20; % set this parameter and keep it forever
    hw_ratio = 0.35; % feel free to play with this ratio (1 is a square)
    set(gcf,'Units','centimeters','Position',[3 3 picturewidth hw_ratio*picturewidth]) % for setting inMATLAB size 
    removeToolbarExplorationButtons(gcf)
    if all(type == 'Cartesian')
        exportgraphics(gcf,'../figure/Pos_Orien_Errors_wrt_Time/plot_Error_Theta_Comparison_Cartesian.pdf','ContentType','vector')
    else
        exportgraphics(gcf,'../figure/Pos_Orien_Errors_wrt_Time/plot_Error_Theta_Comparison_Posture.pdf','ContentType','vector')
    end

    pause(5)
	close all

end