function [SPath, H] = smoothPath(Path, nsmooth, res, H)
% recursively attempts to connect nodes in solution path


% initialize
SPath = Path;
            
for i = 1:nsmooth
    
    % Randomly select two path nodes
    steps = size(SPath,1);
    p1 = ceil((steps-1)*rand);
    p2 = ceil((steps-1)*rand);
    
    % make sure they are two distinct nodes
    while (p2 == p1)
        p2 = ceil((steps-1)*rand); 
    end

    % make sure p2 > p1
    if p1 > p2
        pt = p1;
        p1 = p2; 
        p2 = pt;
    end

    % Randomly select two points from the two path segments
    r1 = rand;
    if SPath(p1,1) > SPath(p1+1,1)
        pnt1(1) = round(SPath(p1,1)-abs(SPath(p1,1)-SPath(p1+1,1))*r1); 
    else
        pnt1(1) = round(SPath(p1,1)+abs(SPath(p1,1)-SPath(p1+1,1))*r1);
    end

    if SPath(p1,2) > SPath(p1+1,2)
        pnt1(2) = round(SPath(p1,2)-abs(SPath(p1,2)-SPath(p1+1,2))*r1); 
    else
        pnt1(2) = round(SPath(p1,2)+abs(SPath(p1,2)-SPath(p1+1,2))*r1); 
    end

    r2 = rand;
    if SPath(p2,1) > SPath(p2+1,1)
        pnt2(1) = round(SPath(p2,1)-abs(SPath(p2,1)-SPath(p2+1,1))*r2); 
    else
        pnt2(1) = round(SPath(p2,1)+abs(SPath(p2,1)-SPath(p2+1,1))*r2); 
    end
    if SPath(p2,2) > SPath(p2+1,2)
        pnt2(2) = round(SPath(p2,2)-abs(SPath(p2,2)-SPath(p2+1,2))*r2); 
    else
        pnt2(2) = round(SPath(p2,2)+abs(SPath(p2,2)-SPath(p2+1,2))*r2);
    end

    if pnt1 ~= pnt2
        % Connect the two points
        %fprintf('\n pnt1 = [%i, %i], pnt2 = [%i, %i] \n', pnt1(1), pnt1(2), pnt2(1), pnt1(2));
        [Crash] = EvalCrashEdge2(pnt1, pnt2, res);
        if ~Crash
            % Update Path
            path1 = SPath(1:p1,:);
            path2 = [pnt1; pnt2];
            path3 = SPath(p2+1:end,:);
            SPath = [path1; path2; path3];
        end
    end
end

H(end+1) = plot(SPath(:,1),SPath(:,2),'g', 'LineWidth',2);

end

