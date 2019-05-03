function [GoalReached] = TryStraightline(GoalNode, res)

    % try goal node
    NewNode = GoalNode;
    dif = res*50;

    % Status (& "update")
    [Crash, Goal, ClosestNode, idx, d, NewNode] = getStatus3(NewNode, res, dif);

    % if feasible
    if ~Crash  
        
        % get NewNode Info
        [NewNodeInfo] = getNewNodeInfo(idx, d);
        
        % add to record
        AddNode(NewNode, NewNodeInfo);      
        
        % plot edge
        xl = [ClosestNode(1), NewNode(1)];
        yl = [ClosestNode(2), NewNode(2)];
        plot(xl, yl, 'b')
        
        % plot node
        bX = [-0.5,-0.5,0.5,0.5,-0.5];
        bY = [-0.5,0.5,0.5,-0.5,-0.5];
        patch(NewNode(1)+bX, NewNode(2)+bY, 'y');
        
        pause(0.0001); % for display purposes
    end

    GoalReached = Goal;


end

