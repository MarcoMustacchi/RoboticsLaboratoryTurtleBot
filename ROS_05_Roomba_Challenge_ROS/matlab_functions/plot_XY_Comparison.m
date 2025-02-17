function plot_XY_Comparison(x_des, y_des, x_sim, y_sim, x_real, y_real, theta_real, filenameXY)

    figure
    title('XY Path','Interpreter','Latex');
    hold all
    plot(x_des, y_des, 'LineWidth', 1.5);
    plot(x_sim, y_sim, '--', 'LineWidth', 1.5);
    plot(x_real, y_real, ':', 'LineWidth', 1.5);
    plot(x_des(1), y_des(1), 'go');
    plot(x_des(end), y_des(end), 'rx');

    triangle_i = nsidedpoly(3, 'Center', [x_real(1), y_real(1)], 'SideLength', 0.1);
    theta_i = theta_real(1) - 90;
    rotation_center_i = [x_real(1), y_real(1)];
    triangle_rot_i = rotate(triangle_i,theta_i,rotation_center_i);
    m = plot(triangle_rot_i);
    m.FaceColor = [0 0.4470 0.7410];
    plot(triangle_rot_i.Vertices(2,1), triangle_rot_i.Vertices(2,2), 'r.','MarkerSize', 10);
    [b_xi, b_yi] = centroid(triangle_rot_i);
    plot(b_xi, b_yi, 'b.','MarkerSize', 10);

    triangle_f = nsidedpoly(3, 'Center', [x_real(end), y_real(end)], 'SideLength', 0.1);
    theta_f = theta_real(end) - 90;
    rotation_center_f = [x_real(end), y_real(end)];
    triangle_rot_f = rotate(triangle_f,theta_f,rotation_center_f);
    i = plot(triangle_rot_f);
    i.FaceColor = [0 0.4470 0.7410];
    plot(triangle_rot_f.Vertices(2,1), triangle_rot_f.Vertices(2,2), 'r.','MarkerSize', 10);
    [b_xf, b_yf] = centroid(triangle_rot_f);
    plot(b_xf, b_yf, 'b.','MarkerSize', 10);

    hold off
    grid on; 
    axis equal
    xlabel('$x$ [m]','interpreter','latex')
    ylabel('$y$ [m]','interpreter','latex')
    legend('Desired Trajectory','Simulation Trajectory','SPARCS Trajectory','Initial Tracking Position','Final Tracking Position','interpreter','latex','location','northeast');
    set(gca,'TickLabelInterpreter','latex')
    removeToolbarExplorationButtons(gcf)
    exportgraphics(gcf,filenameXY,'ContentType','vector')

end