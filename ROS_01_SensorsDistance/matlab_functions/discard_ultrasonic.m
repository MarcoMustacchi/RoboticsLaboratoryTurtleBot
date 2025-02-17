function distance = discard_ultrasonic(distance)

    % if out of ranges -> discard
    x = randn(10,1);
    indices = find(abs(x)>2);
    x(indices) = [];

    % if invalid measure -> assign a flag measure not to be trusted
    x = randn(10,1);
    indices = find(abs(x)>2);
    x(indices) = NaN;

end