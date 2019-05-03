function [TargetReached, h1, h2] = RRT_TryStraightline(res, i, limit, h1, h2, params, dispRRT, j)
        
        global NodeSet1
        global NodeSet2

    % target node = last node in other nodeset
    if j == 1
        NodeSet = NodeSet2;
    elseif j == 2
        NodeSet = NodeSet1;
    end
    NewNode = NodeSet.Nodes(:,:,end);

    % Status (& "update")
    [Crash, Target, ClosestNode, idx, d, NewNode] = getStatus2(NewNode, res, i, limit, params, j);

if ~Crash % if feasible
    
    % get NewNode Info
    [NewNodeInfo] = getNewNodeInfo(idx, d, j);

    % add to current record
    if j == 1
        [NodeSet1] = AddNode(NodeSet1, NewNode, NewNodeInfo);
    elseif j == 2
        [NodeSet2] = AddNode(NodeSet2, NewNode, NewNodeInfo);
    end
    
    
    if dispRRT
        % plot edge
        xl = [ClosestNode(1), NewNode(1)];
        yl = [ClosestNode(2), NewNode(2)];
        if j == 1
            h1(NewNodeInfo(1)) = plot(xl, yl, 'b');
        elseif j == 2
            h2(NewNodeInfo(1)) = plot(xl, yl, 'm');
        end

        % plot node
        r = round(res/2);
        bX = [-r,-r,r,r,-r];
        bY = [-r,r,r,-r,-r];
        patch(NewNode(1)+bX, NewNode(2)+bY, 'y');

        pause(0.0001); % for display purposes
    end
end

    TargetReached = Target;


end

