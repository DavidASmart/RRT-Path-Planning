function [Path] = getPath(NodeSet, dispRRT)


% the last node in the node set is the terminal node of the solution 
Path = NodeSet.Nodes(:,:,end);
PathInfo = NodeSet.NodesInfo(:,:,end); % start at the termpinal node

if dispRRT
    bX = [-0.5,-0.5,0.5,0.5,-0.5];
    bY = [-0.5,0.5,0.5,-0.5,-0.5];
    patch(Path(1)+bX,Path(2)+bY,'r');
end

% lets backtrack through the parent nodes to find the full path
pN = PathInfo(2); % get the parent node number
while pN > 0 % until we have arrived back at the start node

    Path = [NodeSet.Nodes(:,:,pN); Path]; % save parent node to the path
    PathInfo = NodeSet.NodesInfo(:,:,pN); % get the parent node's info
    pN = PathInfo(2); % get the next parent node number

    if dispRRT
        % plot edge
        xl = [Path(1,1), Path(2,1)];
        yl = [Path(1,2), Path(2,2)];
        plot(xl, yl, 'r', 'LineWidth', 2)

        % plot node
        patch(Path(1,1)+bX,Path(1,2)+bY,'r');
        pause(0.0001);
    end
end


end

