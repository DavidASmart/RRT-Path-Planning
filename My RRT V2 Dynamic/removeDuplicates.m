function [Path] = removeDuplicates(Path,res)

if size(Path,1)-2 > 1
    for i = size(Path,1)-2:-1:1 % for all but the last segment
        % check the distance to the next node
        dx = Path(i+1,1) - Path(i,1);
        dy = Path(i+1,2) - Path(i,2);
        d = sqrt(dx^2+dy^2);

        if d < res % if it is basicaly the same point
            Path(i+1,:) = []; % remove it from the path
        end
    end
end

end

