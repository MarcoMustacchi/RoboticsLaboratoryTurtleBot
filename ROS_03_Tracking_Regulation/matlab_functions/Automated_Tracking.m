%% Automated Simulation - Tracking
filename_slx = {'Feedforward.slx','State_Feedback_Linear.slx','State_Feedback_NON_Linear.slx', ...
    'Output_Feedback.slx','Z_Feedback.slx'};
filename_plot = {'Feedforward.pdf','State_Feedback_Linear.pdf','State_Feedback_NON_Linear.pdf', ... 
    'Output_Feedback.pdf','Z_Feedback.pdf'};

for i = 1:length(filename_slx)

    sim(strcat('../simulink_models/',string(filename_slx(i))),'StopTime',num2str(t(end)),'FixedStep',num2str(Ts))
    x_des = ans.reference.signals.values(:,1); y_des = ans.reference.signals.values(:,2);
    x = ans.output.signals.values(:,1); y = ans.output.signals.values(:,2); theta = ans.output.signals.values(:,3);
    filenameXY = strcat('../figure/XY/XY_',string(trajectory_name),string(filename_plot(i)));
    filenameCommands = strcat('../figure/Commands/Commands_',string(trajectory_name),string(filename_plot(i)));
    filenameErrors = strcat('../figure/Errors/Errors_',string(trajectory_name),string(filename_plot(i)));
    plot_XY_Tracking(x_des, y_des, x, y, theta, filenameXY)
    plot_Commands(ans, unicycle, filenameCommands)
    if i > 1 && i < 3
        plot_Errors(ans, filenameErrors, 1)
    elseif i > 3
        plot_Errors(ans, filenameErrors, 0)
    end
    pause(3)
    close all

end