function plot_XY_Tracking(x_des, y_des, x, y, theta, filenameXY)

    figure
    title('XY Path','Interpreter','Latex');
    hold all
    plot(x_des, y_des, 'LineWidth', 1);
    plot(x, y, '--', 'LineWidth', 1);
    plot(x_des(1), y_des(1), 'go');
    plot(x_des(end), y_des(end), 'rx');

    triangle_i = nsidedpoly(3, 'Center', [x(1), y(1)], 'SideLength', 0.5);
    theta_i = theta(1) - 90;
    rotation_center_i = [x(1), y(1)];
    triangle_rot_i = rotate(triangle_i,theta_i,rotation_center_i);
    m = plot(triangle_rot_i);
    m.FaceColor = [0 0.4470 0.7410];
    plot(triangle_rot_i.Vertices(2,1), triangle_rot_i.Vertices(2,2), 'r.','MarkerSize', 10);
    [b_xi, b_yi] = centroid(triangle_rot_i);
    plot(b_xi, b_yi, 'b.','MarkerSize', 10);

    triangle_f = nsidedpoly(3, 'Center', [x(end), y(end)], 'SideLength', 0.5);
    theta_f = theta(end) - 90;
    rotation_center_f = [x(end), y(end)];
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
    legend('Desired Trajectory','Actual Trajectory','Initial Desired Position','Final Desired Position','interpreter','latex','location','southeast');
    set(gca,'TickLabelInterpreter','latex')
    removeToolbarExplorationButtons(gcf)
    exportgraphics(gcf,filenameXY,'ContentType','vector')

end

