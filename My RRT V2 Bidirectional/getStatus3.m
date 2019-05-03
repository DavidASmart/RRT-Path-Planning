%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% David A Smart
% University of Maryland, College Park
% ENPM 661 - Planning for Autonomous Systems
% Project #2 - Path Planning
% 3/3/18
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function [Crash, Goal, ClosestNode, idx, d, Node] = getStatus3(Node, res)

    global NodeSet1
    
    % take the last node in the record
    idx = size(NodeSet1.Nodes,3);
    ClosestNode = NodeSet1.Nodes(:,:,idx);
    
    % evaluate if new node is in an obstacle, 
    % or if the connecting "edge" passes through the obstacle
    % try moving the node toward the closest node along the edge to 
    [Crash, d] = EvalCrashEdge2(Node, ClosestNode, res);

    % initialize status
    Goal = 0;
    if Crash == 0 && sqrt((Node(1) - NodeSet.Nodes(:,1,1))^2 + ...
            (Node(2) - NodeSet.Nodes(:,2,1))^2) < res % close enough
        Goal = 1; % same as Goal node
    end

end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%