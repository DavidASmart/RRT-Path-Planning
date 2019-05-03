function [Path] = getPath(dispRRT, TargetReached, j)

% get the two paths individualy and then merge the two

global NodeSet1
global NodeSet2

% current nodeset and the other node set are determined by j
if j == 1
    CurrentNodeSet = NodeSet1;
    OtherNodeSet = NodeSet2;
elseif j == 2 
    CurrentNodeSet = NodeSet2;
    OtherNodeSet = NodeSet1;
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% the last node in the current nodeset is the current nodeset's connecting node
CurrentPath = CurrentNodeSet.Nodes(:,:,end);
CurrentPathInfo = CurrentNodeSet.NodesInfo(:,:,end); % start at the termpinal node

if dispRRT
    bX = [-0.5,-0.5,0.5,0.5,-0.5];
    bY = [-0.5,0.5,0.5,-0.5,-0.5];
    patch(CurrentPath(1)+bX,CurrentPath(2)+bY,'r');
end

% lets backtrack through the parent nodes to find the full path
pN = CurrentPathInfo(2); % get the parent node number
while pN > 0 % until we have arrived back at the start node

    CurrentPath = [CurrentNodeSet.Nodes(:,:,pN); CurrentPath]; % save parent node to the path
    CurrentPathInfo = CurrentNodeSet.NodesInfo(:,:,pN); % get the parent node's info
    pN = CurrentPathInfo(2); % get the next parent node number

    if dispRRT
        % plot edge
        xl = [CurrentPath(1,1), CurrentPath(2,1)];
        yl = [CurrentPath(1,2), CurrentPath(2,2)];
        plot(xl, yl, 'r', 'LineWidth', 2)

        % plot node
        patch(CurrentPath(1,1)+bX,CurrentPath(1,2)+bY,'r');
        pause(0.0001);
    end
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% the TargetReached is the other nodeset's connecting node
OtherPath = OtherNodeSet.Nodes(:,:,TargetReached);
OtherPathInfo = OtherNodeSet.NodesInfo(:,:,TargetReached); % start at the termpinal node

if dispRRT
    bX = [-0.5,-0.5,0.5,0.5,-0.5];
    bY = [-0.5,0.5,0.5,-0.5,-0.5];
    patch(OtherPath(1)+bX,OtherPath(2)+bY,'r');
end

% lets backtrack through the parent nodes to find the full path
pN = OtherPathInfo(2); % get the parent node number
while pN > 0 % until we have arrived back at the start node

    OtherPath = [OtherNodeSet.Nodes(:,:,pN); OtherPath]; % save parent node to the path
    OtherPathInfo = OtherNodeSet.NodesInfo(:,:,pN); % get the parent node's info
    pN = OtherPathInfo(2); % get the next parent node number

    if dispRRT
        % plot edge
        xl = [OtherPath(1,1), OtherPath(2,1)];
        yl = [OtherPath(1,2), OtherPath(2,2)];
        plot(xl, yl, 'r', 'LineWidth', 2)

        % plot node
        patch(OtherPath(1,1)+bX,OtherPath(1,2)+bY,'r');
        pause(0.0001);
    end
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% merge the two

% current nodeset and the other node set are determined by j
if j == 1
    OtherPath = flip(OtherPath,1);
    Path = [CurrentPath; OtherPath];
elseif j == 2
    CurrentPath = flip(CurrentPath,1);
    Path = [OtherPath; CurrentPath];
end





end

