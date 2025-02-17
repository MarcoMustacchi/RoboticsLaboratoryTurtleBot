function plot_results(s,x,y,theta,v,w)

    figure;
    %
    subplot(2,2,1); hold on; grid on;
    plot(x,y, 'linewidth',2)
    plot(x(1),y(1),'g.','MarkerSize',40)
    plot(x(end),y(end),'r.','MarkerSize',20)
    title('Trajectory'); xlabel('x');ylabel('y');
    set(gca,'Fontsize',14)
    %
    subplot(2,2,2); hold on; grid on;
    plot(s(1:end-1),theta, 'linewidth',2)
    title('Orientation'); xlabel('s');ylabel('\theta');
    set(gca,'Fontsize',14)
    yticks([-pi -3*pi/4 -pi/2 -pi/4 0 pi/4 pi/2 3*pi/4 pi])
    yticklabels({'-\pi', '-3\pi/4', '-\pi/2', '-\pi/4', '0', '\pi/4', '\pi/2', '3\pi/4', '\pi'})
    %
    subplot(2,2,3); hold on; grid on;
    plot(s(1:end-1),v, 'linewidth',2)
    title('Linear Velocity'); xlabel('s');ylabel('v');
    set(gca,'Fontsize',14)
    %
    subplot(2,2,4); hold on; grid on;
    plot(s(1:end-2),w, 'linewidth',2)
    title('Rotational Velocity'); xlabel('s');ylabel('\omega');
    set(gca,'Fontsize',14)

end