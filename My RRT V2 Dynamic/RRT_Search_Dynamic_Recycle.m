%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% David A Smart
% University of Maryland, College Park
% ENPM 661 - Planning for Autonomous Systems
% Project #2 - Path Planning
% 3/3/18
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function [StartPath, GoalPath, Cost, Time] = RRT_Search_Dynamic_Recycle (StartNode, limStart, GoalNode, limGoal, res, limit, nsmooth, params, dispRRT)
% params: 
% [(0)Rand/(1)Halton Psudo-Random Sequence, ...
% ... (0)Full-Area/(1)Expanding, ...
% ... (0)Full-Length/(1)Limited, ...
% ... (0)Just-Sampling/(1)Straight-Line-Attempts, ...
% ... (0)Original-Connections/(1)Rewiring-Optimal, ...
% ... (0) No-Smoothing/(1) Short-Connect/(2) Randomized-Pointwise-Smoothing]
    %% Initialize Display and NodeSet Record
    
    % start timer
    tic
    
    % init
    Cost = 0;
    StartPath = StartNode;
    GoalPath = GoalNode;
    h = []; H = [];
    NodeSet = [];
    
    dSGx = GoalNode(1) - StartNode(1);
    dSGy = GoalNode(2) - StartNode(2);
    dSG = sqrt(dSGx^2 + dSGy^2);
    
    figure(1);
    global map
    imshow(map);
    set(gcf, 'Position', [1536*0.2 864*0.2 1536*0.6 864*0.6]);
    grid on;
    grid minor;
    hold on;
    
    % until the Goal is actualy reached
    while dSG > res
        
        % delete old path to goal
        if ~isempty(H)
            for i = 1:size(H,2)
                delete(H(i));
            end
            H = [];
        end
        
        % set up display
        InitDisplay2(StartNode, GoalNode, res)
        
        % calculate path from current Start to Current Goal
        [Path, ~, ~, NodeSet, h, H] = RRT_Search_Static_Recycle (StartNode, GoalNode, res, limit, nsmooth, params, dispRRT, NodeSet, h, H);

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
        NewStart = [StartNode(1)+dxS, StartNode(2)+dyS];
        % cost of actual path traveled
        Cost = Cost + sqrt(dxS^2+dyS^2);

        % update NodeSet with new Start
        if params(end-1) == 1
            [NodeSet, h] = ReWire_StartNode(NodeSet, NewStart, h, res);
        end

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
