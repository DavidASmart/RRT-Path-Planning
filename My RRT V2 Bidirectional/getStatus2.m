function [Crash, Target, ClosestNode, idx, d, Node] = getStatus2(Node, res, i, limit, params, j)

% params:
% [(0)Rand/(1)Halton Psudo-Random Sequence, ...
% ... (0)Full-Area/(1)Expanding, ...
% ... (0)Full-Length/(1)Limited, ...
% ... (0)Just-Sampling/(1)Straight-Line-Attempts, ...
% ... (0)Original-Connections/(1)Rewiring-Optimal, ...
% ... (0)No-Smoothing/(1)Short-Connect/(2)Randomized-Pointwise-Smoothing]

global NodeSet1
global NodeSet2
    
% try to connect to current nodeset
if j == 1
    NodeSet = NodeSet1;
elseif j == 2
    NodeSet = NodeSet2;
end

% take the last node in the record
idx = size(NodeSet.Nodes,3);
ClosestNode = NodeSet.Nodes(:,:,idx);

dd = round(sqrt((Node(1) - ClosestNode(1))^2 + ...
    (Node(2) - ClosestNode(2))^2));

if params(2) == 1
    pp = min((i/dd)/10, 1);
else
    pp = 1;
end

[Node, Crash, d] = EvalCrashEdge(Node, ClosestNode, res, pp, limit, params);

% because the node could be updated
[ClosestNode2, ~] = EvalClosestNode (Node, j);
Visited = evalVisited(Node, ClosestNode2, res);

if Visited
    Crash = 1;
end

% try to connect to other nodeset
if j == 1
    NodeSet = NodeSet2;
elseif j == 2
    NodeSet = NodeSet1;
end

% evaluate if other nodeset tree found
Target = 0; % initialize goal status
for i = 1:size(NodeSet.Nodes, 3)
    if Crash == 0 && sqrt((Node(1) - NodeSet.Nodes(:,1,i))^2 + ...
            (Node(2) - NodeSet.Nodes(:,2,i))^2) < res % close enough
        Target = i; % same as Goal node
    end
end




end

