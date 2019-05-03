function [NearNodes, idx] = EvalNearNodes (Node, res, NodeSet)

d = 1000; % initialize distance to goal as "inf"

% find distances to nodes (excluding goal)
for i = 2:size(NodeSet.Nodes, 3)
    % euclidian distance
    d(i) = sqrt((Node(1) - NodeSet.Nodes(:,1,i))^2 + ...
        (Node(2) - NodeSet.Nodes(:,2,i))^2);
end

% get index of nearby nodes in record
idx = find(d <= res);

% select the close enough nodes from record
NearNodes = NodeSet.Nodes(:,:,idx);

end

