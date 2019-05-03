%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% David A Smart
% University of Maryland, College Park
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function [TargetReached, h1, h2] = RRT_Move(SN, GN, res, i, limit, h1, h2, k, params, dispRRT, j)
% params:
% [(0)Rand/(1)Halton Psudo-Random Sequence, ...
% ... (0)Full-Area/(1)Expanding, ...
% ... (0)Full-Length/(1)Limited, ...
% ... (0)Just-Sampling/(1)Straight-Line-Attempts, ...
% ... (0)Original-Connections/(1)Rewiring-Optimal, ...
% ... (0)No-Smoothing/(1)Short-Connect/(2)Randomized-Pointwise-Smoothing]

global map
global NodeSet1
global NodeSet2

% for the prupose of expanding we need to select where to expand from
if j == 2
    StartNode = GN;
    GoalNode = SN;
elseif j == 1
    StartNode = SN;
    GoalNode = GN;
end

dif = round(sqrt((StartNode(1) - GoalNode(1))^2 + (StartNode(2) - GoalNode(2))^2));

if params(2) == 1
    % expand outwards
    pp = min(i/dif, 1);
else
    % use full area
    pp = 1;
end

ex = dif*pp;

% square centered on start node with side length = 2*dif
xL = max(round(StartNode(1)-ex), 1);
xU = min(round(StartNode(1)+ex), size(map,2));
yL = max(round(StartNode(2)-ex), 1);
yU = min(round(StartNode(2)+ex), size(map,1));

if params(1) == 1
    % Halton Pseudo-Random Sequence
    p = haltonset(2);
    NewNode = p(k,:);
    sx = xU - xL;
    sy = yU - yL;
    NewNode = round([NewNode(1)*sx + xL, NewNode(2)*sy + yL]);
else
    % generate random node
    NewNode = [randi([xL,xU]), randi([yL,yU])];
end

% Status (& "update")
[Crash, Target, ClosestNode, idx, d, NewNode] = getStatus(NewNode, res, limit, params, j);

% if feasible
if ~Crash % Visited is equated to a crash, we assume the first has lower cost

    % get NewNode Info
    [NewNodeInfo] = getNewNodeInfo(idx, d, j);
    
    if j == 1
        % add to record
        [NodeSet1] = AddNode(NodeSet1, NewNode, NewNodeInfo);
    elseif j == 2
        % add to record
        [NodeSet2] = AddNode(NodeSet2, NewNode, NewNodeInfo);
    end
        
    if dispRRT
        % plot edge
        xl = [ClosestNode(1), NewNode(1)];
        yl = [ClosestNode(2), NewNode(2)];
        if j == 1
            h1(NewNodeInfo(1)) = plot(xl, yl, 'b');
        elseif j == 2
            h2(NewNodeInfo(1)) = plot(xl, yl, 'm');
        end

        % plot node
        r = round(res/2);
        bX = [-r,-r,r,r,-r];
        bY = [-r,r,r,-r,-r];
        patch(NewNode(1)+bX, NewNode(2)+bY, 'y');

        pause(0.0001); % for display purposes
    end
end

TargetReached = Target;

end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
