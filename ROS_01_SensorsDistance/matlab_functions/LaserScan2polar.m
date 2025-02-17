function polar = LaserScan2polar(scan)

    polar = zeros(length(scan.Ranges), 2);
    for i = 1:length(scan.Ranges)
        polar(i,1) = scan.Ranges(i);
        polar(i,2) = scan.AngleMin + ((i-1) * scan.AngleIncrement);
    end

    % should I use i-1 or i
    % i-1 get anglemin as first and anglemax-1 as last
    % i get anglemin+1 as first and anglemax as last
    % but with the function angles = scan.readScanAngles it uses (i-1)..

    % useful command: plot(scan)

end