function [Crash, d] = EvalCrashEdge2(Node, ClosestNode, res)

% initialize
Crash  = 0;
d = round(sqrt((Node(1) - ClosestNode(1))^2 + ...
        (Node(2) - ClosestNode(2))^2));

% for entire line between nodes
for i = 1:d+1 % index
    p = (i-1)/d; % perentage
    edgepoint = round(ClosestNode + (Node-ClosestNode)*p); % interpolate along line between nodes

    [Crash] = EvalCrashBlock(edgepoint, max(res,1)); % check if in obstacle crash
    
    if Crash
        break;
    end
    
    
end

end

