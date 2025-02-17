function plot4D(x, y, z, col)

    % plot the curve as a surface
    surface([x;x],[y;y],[z;z],[col;col],...
            'facecol','no',...
            'edgecol','interp',...
            'linew',2);
    grid on; view([90,45,45]);
    xlabel('x[m]',Interpreter='latex') 
    ylabel('y[m]',Interpreter='latex') 
    zlabel('z[m]',Interpreter='latex')
    set(gca,'TickLabelInterpreter','Latex','DefaultTextInterpreter','Latex','DefaultLegendInterpreter','Latex')
    % axis equal
    % axesLabelsAlign3D
    c = colorbar('southoutside');
    c.Label.String = 'velocity';
    c.Label.Interpreter = 'latex';
    set(c,'TickLabelInterpreter','latex')

end