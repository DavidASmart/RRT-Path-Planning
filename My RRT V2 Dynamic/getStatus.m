function [Crash, Goal, ClosestNode, idx, d, Node] = getStatus(Node, res, limit, params, NodeSet)

% find the closest node, to which the new node shall be connected
[ClosestNode, idx] = EvalClosestNode (Node, NodeSet);
pp = 1;

[Node, Crash, d] = EvalCrashEdge(Node, ClosestNode, res, pp, limit, params);

% because the node could be updated
Visited = evalVisited(Node, ClosestNode, res);

if Visited
    Crash = 1;
end

% evaluate if goal found
Goal = 0; % initialize goal status
if Crash == 0 && sqrt((Node(1) - NodeSet.Nodes(:,1,1))^2 + ...
        (Node(2) - NodeSet.Nodes(:,2,1))^2) < res % close enough
    Goal = 1; % same as Goal node
end

end

