function [ClosestNode, idx] = EvalClosestNode (Node, j)

global NodeSet1
global NodeSet2

% for random generation, try to connect to current nodeset
if j == 1
    NodeSet = NodeSet1;
elseif j == 2
    NodeSet = NodeSet2;
end

d = inf; % initialize distance to start as "inf"
% find distances to nodes (excluding goal)
for i = 1:size(NodeSet.Nodes, 3)
    % euclidian distance
    d(i) = sqrt((Node(1) - NodeSet.Nodes(:,1,i))^2 + ...
        (Node(2) - NodeSet.Nodes(:,2,i))^2);
end

% get index of closest node in record
[~, idx] = min(d);

% select the closest node from record
ClosestNode = NodeSet.Nodes(:,:,idx);

end

