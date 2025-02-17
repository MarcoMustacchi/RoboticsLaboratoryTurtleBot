%% Automated Simulation - Tracking
filename_slx = {'Posture_Regulation_NO_Singularity.slx'};
filename_XY = {'Posture_Regulation_NO_Singularity.pdf'};

for i = 1:length(filename_slx)

    sim(strcat('../simulink_models/',string(filename_slx(i))),'StopTime',num2str(StopTime),'FixedStep',num2str(Ts))
    x = ans.output.signals.values(:,1); y = ans.output.signals.values(:,2); theta = ans.output.signals.values(:,3);
    filenameXY = strcat('../figure/XY/',string(filenamePlot(i)));
    filenameCommands = strcat('../figure/Commands/',string(filenamePlot(i)));
    plot_XY_Regulation(x, y, theta, x_f, y_f, filenameXY)
    plot_Commands(ans, unicycle, filenameCommands)
    pause(3)
    close all

end