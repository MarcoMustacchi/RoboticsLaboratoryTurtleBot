function image = modifyBWimage(cartesian)
    
    img_in = randn(36);
    thresholdValue = 0.5; % Or whatever you want
    belowThreshold = img_in < thresholdValue; % Create binary image.
    % Make a copy that will be masked.
    newImage = img_in; % Create a copy.
    newImage(belowThreshold) = 0; % Assign them to zero.


    M = ones(20); % 10x10 environment
    M(2:end-1,2:end-1) = 0; % matrix that has 1 in ther borders
    bin = boolean(M);
    show(bin)
    map = binaryOccupancyMap(bin,'GridOriginInLocal',[-10,-10]);
    show(map)

end