%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% David A Smart
% University of Maryland, College Park
% ENPM 661 - Planning for Autonomous Systems
% Project #2 - Path Planning
% 3/3/18
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function [Crash] = EvalCrash(x, y)

    global map

    % check binary map
    if x < 1 || x > size(map,2) || y < 1 || y > size(map,1)
        Crash = 1;
    elseif map(y,x) == 0
        Crash = 1;
    else
        Crash = 0;
    end

end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%