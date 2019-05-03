%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% David A Smart
% University of Maryland, College Park
% ENPM 661 - Planning for Autonomous Systems
% Project #2 - Path Planning
% 3/3/18
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function [Visited, Crash, Goal, ClosestNode, idx, d, Node] = getStatusLimited(Node, res, dif, limit)

    global NodeSet

    % find the closest node, to which the new node shall be connected
    [ClosestNode, idx, Visited] = EvalClosestNode (Node, res);
    
    % evaluate if new node is in an obstacle, 
    % or if the connecting "edge" passes through the obstacle
    % try moving the node toward the closest node along the edge to 
    [Node, Crash, d] = EvalCrashEdgeLimited(Node, ClosestNode, res, limit);

    % initialize status
    Goal = 0;
    if Crash == 0 && sqrt((Node(1) - NodeSet.Nodes(:,1,1))^2 + ...
            (Node(2) - NodeSet.Nodes(:,2,1))^2) < max(dif/50,res) % close enough
        Goal = 1; % same as Goal node
    end

end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%