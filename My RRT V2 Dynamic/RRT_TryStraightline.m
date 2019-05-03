function [GoalReached, h, NodeSet] = RRT_TryStraightline(GoalNode, res, i, limit, h, params, dispRRT, NodeSet)

    % try goal node
    NewNode = GoalNode;

    % Status (& "update")
    [Crash, Goal, ClosestNode, idx, d, NewNode] = getStatus2(NewNode, res, i, limit, params, NodeSet);

if ~Crash % if feasible
    
    % get NewNode Info
    [NewNodeInfo] = getNewNodeInfo(idx, d, NodeSet);

    % add to record
    [NodeSet] = AddNode(NewNode,NewNodeInfo,NodeSet);
    
    if dispRRT
        % plot edge
        xl = [ClosestNode(1), NewNode(1)];
        yl = [ClosestNode(2), NewNode(2)];
        h(NewNodeInfo(1)) = plot(xl, yl, 'b');

        % plot node
        r = round(res/2);
        bX = [-r,-r,r,r,-r];
        bY = [-r,r,r,-r,-r];
        patch(NewNode(1)+bX, NewNode(2)+bY, 'y');

        pause(0.0001); % for display purposes
    end
end

    GoalReached = Goal;


end

