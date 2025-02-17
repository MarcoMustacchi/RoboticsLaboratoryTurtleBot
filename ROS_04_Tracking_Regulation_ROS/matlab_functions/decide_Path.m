%% Decide path
n = input(['Choose trajectory type \n 1: Eight \n 2: Square Non Smooth \n ' ...
    '3: Square Smooth \n 4: Line Follower \n'] );

switch n
    case 1
        Eight_Path
        trajectory_name = 'Eight_';
    case 2
        Square_Path_Non_Smooth
        trajectory_name = 'Square_Non_Smooth_';
    case 3
        Square_Path_Smooth
        trajectory_name = 'Square_Smooth_';
    case 4
        Line_Follower_Path
        trajectory_name = 'Line_Follower_';
end

% Decide initial pose
disp(['Reference trajectory has initial x of: ', num2str(x_sim(1,2))])
disp(['Reference trajectory has initial y of: ', num2str(y_sim(1,2))])
disp(['Reference trajectory has initial theta of: ', num2str(rad2deg(theta(1)))])