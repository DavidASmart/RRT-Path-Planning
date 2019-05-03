%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% David A Smart
% University of Maryland, College Park
% ENPM 661 - Planning for Autonomous Systems
% Project #2 - Path Planning
% 3/3/18
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function [Path, Cost, Time, NodeSet] = RRT_Search_Static (StartNode, GoalNode, res, limit, nsmooth, params, dispRRT)
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
    StartNodeInfo = [2, 0, 0, 0];

    % set up the record of nodes first with the GoalNode
    NodeSet.Nodes = GoalNode;
    NodeSet.NodesInfo = GoalNodeInfo;
    h = [];

    % add the starting node to the record of nodes
    [NodeSet] = AddNode(StartNode,StartNodeInfo,NodeSet);
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %% Expand Nodes
    [GoalReached, NodeSet] = TryStraightline(GoalNode, res, NodeSet); % initial straightline attempt
    k = 1; i = 3; % init variables ialize
    while ~GoalReached % until the goal is reached

        % try a random point
        [GoalReached, h, NodeSet] = RRT_Move(StartNode, GoalNode, res, i, limit, h, k, params, dispRRT, NodeSet); 
        k = k + 1; % count of samples, required for Halton Sequence
        i = i + 0.1; % expanding percentage
        
        if params(4) == 1
            % then try a straight line to the goal
            [GoalReached, h, NodeSet] = RRT_TryStraightline(GoalNode, res, i, limit, h, params, dispRRT, NodeSet);
        end
        
        if params(end-1) == 1
            % Local Rewiring (Optimal)
            [NodeSet, h] = ReWire(NodeSet, res, limit, h, dispRRT);
        end
        
    end
    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %% Generate Solution Path
    [Path] = getPath(NodeSet, dispRRT);
    
    
    if size(Path,1) > 4 % if more than 4 nodes in path
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        %% Generate Smoothed Path
        if params(end) == 1 || params(end) == 2
            [Path] = ShortConnect(Path, res, params);
        end

        if params(end) == 2
            [Path] = smoothPath(Path, nsmooth, res);
        end
    end
    
    % cost may change due to smoothing
    Cost = getCost(Path);
    
    Time = toc; % seconds
end
