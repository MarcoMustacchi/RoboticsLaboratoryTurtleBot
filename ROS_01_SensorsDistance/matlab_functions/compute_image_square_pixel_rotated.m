function [y_left, y_right] = compute_image_square_pixel_rotated(image_rotated)

    image_gray = rgb2gray(image_rotated);
%     figure
%     imhist(image_gray)
    threshold = 69; % custom threshold value
    image_bw = image_gray > threshold;
    
    image_bw_filtered = ~bwareaopen(~image_bw, 150); % wants object to be white
    
%     figure
%     imshow(image_bw_filtered) 
    
    mid_column_idx = size(image_bw_filtered,2)/2; % from middle to right all to 1 (no square)
    image_bw_filtered(:, mid_column_idx:end) = 1;
    
%     figure
%     imshow(image_bw_filtered) 
    
    row_diff = diff(image_bw_filtered,1,1); % first order difference on rows
    col_diff = diff(image_bw_filtered,1,2); % first order difference on columns
    
    [row1,~] = find(row_diff); % find by default find all 1
    [~,col2] = find(col_diff);
    
    threshold = 2; % threshold for neighbor values
    
    most_present_1 = mode(col2)
    temp = col2;
    temp(temp == most_present_1) = [];
    most_present_2 = mode(temp)
    
    temp1 = col2(find(col2(:)<=most_present_1+threshold & col2(:)>=most_present_1-threshold),:)
    temp2 = col2(find(col2(:)<=most_present_2+threshold & col2(:)>=most_present_2-threshold),:)
    
    y_left = length(temp1); 
    y_right = length(temp2); 

end