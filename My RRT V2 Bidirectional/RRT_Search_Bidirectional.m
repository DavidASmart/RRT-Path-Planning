%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% David A Smart
% University of Maryland, College Park
% ENPM 661 - Planning for Autonomous Systems
% Project #2 - Path Planning
% 3/3/18
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function [Path, Cost, Time] = RRT_Search_Bidirectional (StartNode, GoalNode, res, limit, nsmooth, params, dispRRT)
% params: 
% [(0)Rand/(1)Halton Psudo-Random Sequence, ...
% ... (0)Full-Area/(1)Expanding, ...
% ... (0)Full-Length/(1)Limited, ...
% ... (0)Just-Sampling/(1)Straight-Line-Attempts, ...
% ... (0)Original-Connections/(1)Rewiring-Optimal, ...
% ... (0) No-Smoothing/(1) Short-Connect/(2) Randomized-Pointwise-Smoothing]
    %% Initialize Display and NodeSet Record
    
%     % set up display
%     InitDisplay(StartNode, GoalNode, res)

    % start timer
    tic
    
    % NodeInfo = [Node #, Parent node #, Steps2Come, Cost2Come]
    GoalNodeInfo = [1, 0, 0, 0];
    StartNodeInfo = [1, 0, 0, 0];

    % set up the record of nodes first with the GoalNode
    global NodeSet1 NodeSet2
    NodeSet1.Nodes = StartNode;
    NodeSet1.NodesInfo = StartNodeInfo;
    NodeSet2.Nodes = GoalNode;
    NodeSet2.NodesInfo = GoalNodeInfo;
    h1 = []; h2 = [];

    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %% Expand Nodes
    [TargetReached] = TryStraightline(GoalNode, res); % initial straightline attempt
    k = 1; i = 3; j = 1;% init variables ialize
    while TargetReached == 0 % until the goal is reached

        % try a random point
        [TargetReached, h1, h2] = RRT_Move(StartNode, GoalNode, res, i, limit, h1, h2, k, params, dispRRT, j); 
        k = k + 1; % count of samples, required for Halton Sequence
        i = i + 0.1; % expanding percentage
        
        if params(4) == 1
            % then try a straight line to the goal
            [TargetReached, h1, h2] = RRT_TryStraightline(res, i, limit, h1, h2, params, dispRRT, j);
        end
        
        if params(end-1) == 1
            % Local Rewiring (Optimal)
            if j == 1
                [NodeSet1, h1] = ReWire(NodeSet1, res, limit, h1, dispRRT, j);
            elseif j == 2
                [NodeSet2, h2] = ReWire(NodeSet2, res, limit, h2, dispRRT, j);
            end
            
        end
        
        if TargetReached ~= 0
            break;
        end
        
        % switch between NodeSets / directions
        if j == 1
            j = 2;
        elseif j == 2
            j = 1;
        end
        
    end
    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %% Generate Solution Path
    [Path] = getPath(dispRRT, TargetReached, j);
    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %% Generate Smoothed Path
    if params(end) == 1 || params(end) == 2
        [Path] = ShortConnect(Path, res, params);
    end
    
    if params(end) == 2
        [Path] = smoothPath(Path, nsmooth, res);
    end
    
    % cost may change due to smoothing
    Cost = getCost(Path);
    
    Time = toc; % seconds
end
