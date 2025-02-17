function cartesian = pol2cart(polar)
   
    cartesian = zeros(length(polar), 2);
    cartesian(:,1) = polar(:,1).*cos(polar(:,2));
    cartesian(:,2) = polar(:,1).*sin(polar(:,2));

end