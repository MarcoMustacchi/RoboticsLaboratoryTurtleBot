function plot_XY_different_k(x_des, y_des, x_state, y_state, theta_state, triangle_SideLength, filenameXY)

    figure
    title('XY Path','Interpreter','Latex');
    hold all
    plot(x_des, y_des, 'LineWidth', 1.5);
    plot(x_state, y_state, '--', 'LineWidth', 1.5);
    plot(x_des(1), y_des(1), 'go');
    plot(x_des(end), y_des(end), 'rx');

    triangle_i = nsidedpoly(3, 'Center', [x_state(1), y_state(1)], 'SideLength', triangle_SideLength);
    theta_i = theta_state(1) - 90;
    rotation_center_i = [x_state(1), y_state(1)];
    triangle_rot_i = rotate(triangle_i,theta_i,rotation_center_i);
    m = plot(triangle_rot_i);
    m.FaceColor = [0 0.4470 0.7410];
    plot(triangle_rot_i.Vertices(2,1), triangle_rot_i.Vertices(2,2), 'r.','MarkerSize', 10);
    [xi, yi] = centroid(triangle_rot_i);
    plot(xi, yi, 'b.','MarkerSize', 10);

    triangle_f = nsidedpoly(3, 'Center', [x_state(end), y_state(end)], 'SideLength', triangle_SideLength);
    theta_f = theta_state(end) - 90;
    rotation_center_f = [x_state(end), y_state(end)];
    triangle_rot_f = rotate(triangle_f,theta_f,rotation_center_f);
    i = plot(triangle_rot_f);
    i.FaceColor = [0 0.4470 0.7410];
    plot(triangle_rot_f.Vertices(2,1), triangle_rot_f.Vertices(2,2), 'r.','MarkerSize', 10);
    [xf, yf] = centroid(triangle_rot_f);
    plot(xf, yf, 'b.','MarkerSize', 10);

    hold off
    grid on; 
    axis equal
    xlabel('$x$ [m]','interpreter','latex')
    ylabel('$y$ [m]','interpreter','latex')
    legend('Desired Path','State Feedback','Initial Desired Position','Final Desired Position','interpreter','latex','location','best');
    set(gca,'TickLabelInterpreter','latex')
    removeToolbarExplorationButtons(gcf)
    exportgraphics(gcf,filenameXY,'ContentType','vector')

end