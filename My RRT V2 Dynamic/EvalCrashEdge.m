function [Node, Crash, d] = EvalCrashEdge(Node, ClosestNode, res, pp, limit, params)

% initialize
Crash  = 0;
edgepoint = zeros(100,2);
d = round(sqrt((Node(1) - ClosestNode(1))^2 + ...
        (Node(2) - ClosestNode(2))^2));

% for entire line between nodes
for i = 1:d+1 % index
    
    p = min((i-1)/d, pp); % percentage
    
    edgepoint(i,:) = round(ClosestNode + (Node-ClosestNode)*p); % interpolate along line between nodes
    
%     % plot node for debugging
%     bX = [-0.5,-0.5,0.5,0.5,-0.5];
%     bY = [-0.5,0.5,0.5,-0.5,-0.5];
%     temp = patch(edgepoint(i,1)+bX, edgepoint(i,2)+bY, 'y', 'FaceAlpha', 0.5, 'EdgeAlpha', 0.5);
    
    [crash] = EvalCrashBlock(edgepoint(i,:), max(res,1)); % check if in obstacle
    
%     delete(temp);
    
    if crash && i > 1
        % check how close it is to the ClosestNode
        dd = sqrt((edgepoint(i-1,1) - ClosestNode(1))^2 + ...
            (edgepoint(i-1,2) - ClosestNode(2))^2);

        if dd < res % if the obstalce is too close to be a new node
            Crash = 1;
        else % if the obstalce is far enough away to be a new node
            Node = edgepoint(i-1,:); % take previous point along line as the new node
            Crash  = 0;
        end

        d = round(dd);
        break; % stop checking edge
        
    elseif i > 1 && params(3) == 1
        % check how close it is to the ClosestNode
        dd = sqrt((edgepoint(i-1,1) - ClosestNode(1))^2 + ...
            (edgepoint(i-1,2) - ClosestNode(2))^2);
        if dd > limit % if the edge is too long
            Node = edgepoint(i-1,:); % take previous point along line as the new node
            Crash  = 0;
            d = round(dd);
            break; % stop checking edge
        end
    end

end


if ~crash && params(2) == 1 && params(3) == 0
    Node = edgepoint(i,:);
    
elseif ~crash && params(2) == 1 && params(3) == 1
    % check how close it is to the ClosestNode
    dd = sqrt((edgepoint(i,1) - ClosestNode(1))^2 + ...
        (edgepoint(i,2) - ClosestNode(2))^2);

    if dd < res % if the obstalce is too close to be a new node
        Crash = 1;
    else % if the obstalce is far enough away to be a new node
        Node = edgepoint(i,:); % take previous point along line as the new node
        Crash  = 0;
        d = round(dd);
    end
end

end

