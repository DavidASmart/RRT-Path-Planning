function [ClosestNode, idx] = EvalClosestNode (Node)

global NodeSet

d = inf; % initialize distance to goal as "inf"
% find distances to nodes (excluding goal)
for i = 2:size(NodeSet.Nodes, 3)
    % euclidian distance
    d(i) = sqrt((Node(1) - NodeSet.Nodes(:,1,i))^2 + ...
        (Node(2) - NodeSet.Nodes(:,2,i))^2);
end

% get index of closest node in record
[mind, idx] = min(d);

% select the closest node from record
ClosestNode = NodeSet.Nodes(:,:,idx);

end

