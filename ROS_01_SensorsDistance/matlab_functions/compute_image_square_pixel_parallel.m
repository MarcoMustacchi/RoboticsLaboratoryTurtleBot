function [l, x, y] = compute_image_square_pixel_parallel(image)
    
    % Convert RGB uint8 image to grayscale image
    image_gray = rgb2gray(image);
    % figure
    % imshow(image_gray)
    
    % Computes a global threshold T from grayscale image I, using Otsu's method
    level = graythresh(image_gray);
    image_bw = imbinarize(image_gray,level);
    image_bw = ~image_bw;
    % figure
    % imshow(image_bw) 
    
    % use histogram to find Threshold
    figure
    imhist(image_gray)
    threshold = 65; % custom threshold value
    image_bw = image_gray > threshold;
    % figure
    % imshow(image_bw) 
    
    image_bw_filtered = ~bwareaopen(~image_bw, 150); % wants object to be white
    figure
    imshow(image_bw_filtered) 
    % imshowpair(image_bw,image_bw_filtered,'montage')
    
    % dimension of the square in pixel
    % Method 1: assuming a square -> count # of pixels and square root
    zeros = sum(image_bw_filtered(:) == 0);
    l = round(sqrt(zeros));
    
    % Method 2: generalize
    % using diff first on row and then on column
    row_diff = diff(image_bw_filtered,1,1); % first order difference on rows
    col_diff = diff(image_bw_filtered,1,2); % first order difference on columns
    
    [row1,col1] = find(row_diff);
    [row2,col2] = find(col_diff);
    
    x = round(length(row1)/2); % row1 = col1
    y = round(length(row2)/2); % row2 = col2

end

