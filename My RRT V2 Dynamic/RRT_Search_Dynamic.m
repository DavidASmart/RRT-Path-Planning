%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% David A Smart
% University of Maryland, College Park
% ENPM 661 - Planning for Autonomous Systems
% Project #2 - Path Planning
% 3/3/18
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function [StartPath, GoalPath, Cost, Time] = RRT_Search_Dynamic (StartNode, limStart, GoalNode, limGoal, res, limit, nsmooth, params, dispRRT)
% Recalculate RRT nodes every time...

    % start timer
    tic
    
    % init
    Cost = 0;
    StartPath = StartNode;
    GoalPath = GoalNode;
    
    dSGx = GoalNode(1) - StartNode(1);
    dSGy = GoalNode(2) - StartNode(2);
    dSG = sqrt(dSGx^2 + dSGy^2);
    
    % until the Goal is actualy reached
    while dSG > res
        
        % set up display
        InitDisplay(StartNode, GoalNode, res)
        
        % calculate path from current Start to Current Goal
        [Path, ~, ~, ~] = RRT_Search_Static (StartNode, GoalNode, res, limit, nsmooth, params, dispRRT);

        pause(0.1);
        
        % for some reason the 2nd smoothing method causes nearly duplicate nodes
        [Path] = removeDuplicates(Path,res);
        
        % move along path toward goal
        dxS = Path(2,1) - StartNode(1);
        dyS = Path(2,2) - StartNode(2);
        if sqrt(dxS^2+dyS^2) > sqrt(limStart^2/2)
            dSd = atan2(dyS,dxS); % direction
            dxS = cos(dSd)*sqrt(limStart^2/2);
            dyS = sin(dSd)*sqrt(limStart^2/2);
        end
        NewStart = round([StartNode(1)+dxS, StartNode(2)+dyS]);
        % cost of actual path traveled
        Cost = Cost + sqrt(dxS^2+dyS^2);

        % randomly move goal...but not into an obsticle
        inObs = 1;
        while inObs
            dxG = rand*sqrt((limGoal^2)/2)*(-1)^randi(2);
            dyG = rand*sqrt((limGoal^2)/2)*(-1)^randi(2);
            NewGoal = round([GoalNode(1)+dxG,GoalNode(2)+dyG]);
            inObs = EvalCrashBlock(NewGoal, res);
        end

        % update actual paths traveled
        StartPath = [StartPath; NewStart];
        GoalPath = [GoalPath; NewGoal];

        % iterate
        StartNode = NewStart;
        GoalNode = NewGoal;

        dSGx = GoalNode(1) - StartNode(1);
        dSGy = GoalNode(2) - StartNode(2);
        dSG = sqrt(dSGx^2 + dSGy^2);
    end
    
    Time = toc; % seconds
end
