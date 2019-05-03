%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% David A Smart
% University of Maryland, College Park
% ENPM 661 - Planning for Autonomous Systems
% Project #2 - Path Planning
% 3/3/18
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function [Crash] = EvalCrashBlock(Node, r)

    % initialize status
    Crash = 0;

    x = Node(1);
    y = Node(2);

% ( conservative )
    % check the center of the "block"
    CC = EvalCrash(x, y);
    % check the corners of the "block"
    CLU = EvalCrash(x-r, y+r);
    CRU = EvalCrash(x+r, y+r);
    CLD = EvalCrash(x-r, y-r);
    CRD = EvalCrash(x+r, y-r);

    if CC || CLU || CRU || CRD || CLD
        Crash = 1;
    end

end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%