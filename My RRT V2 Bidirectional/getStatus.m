function [Crash, Target, ClosestNode, idx, d, Node] = getStatus(Node, res, limit, params, j)
    
global NodeSet1
global NodeSet2

% find the closest node, to which the new node shall be connected
[ClosestNode, idx] = EvalClosestNode (Node, j);
pp = 1;

[Node, Crash, d] = EvalCrashEdge(Node, ClosestNode, res, pp, limit, params);

% because the node could be updated
Visited = evalVisited(Node, ClosestNode, res);

if Visited
    Crash = 1;
end

% try to connect to current nodeset
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

