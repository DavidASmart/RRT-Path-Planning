%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% David A Smart
% University of Maryland, College Park
% ENPM 661 - Planning for Autonomous Systems
% Project #2 - Path Planning
% 3/3/18
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function [NewNodeInfo] = getNewNodeInfo(idx, d, NodeSet) 
    
    % new Node # = number of existing nodes + 1
    NewNodeNo = size(NodeSet.Nodes, 3) + 1;
    
    % new node's Parent node # = current node
    ParentNodeNo = NodeSet.NodesInfo(1, 1, idx);
    
    % new node's steps to come = current node steps to come + 1
    Steps2Come = NodeSet.NodesInfo(1, 3, idx) + 1;
    
    % new node's cost to come = current node cost to come + distance between nodes 
    Cost2Come = NodeSet.NodesInfo(1, 4, idx) + d;
    
    % NodeInfo = [Node #, Parent node #, CostToCome]
    NewNodeInfo = [NewNodeNo, ParentNodeNo, Steps2Come, Cost2Come];
    
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%