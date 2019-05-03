function [Cost] = getCost(Path)

Cost = 0; % intitialize to 0

for i = 1:size(Path,1)-1 % for full length of path
    
    % distance between waypoints
    d = sqrt((Path(i+1,1) - Path(i,1))^2 + (Path(i+1,2) - Path(i,2))^2);
    
    % total distance
    Cost = Cost + d;
    
end

end

