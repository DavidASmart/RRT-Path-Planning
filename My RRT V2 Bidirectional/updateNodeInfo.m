%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% David A Smart
% University of Maryland, College Park
% ENPM 661 - Planning for Autonomous Systems
% Project #2 - Path Planning
% 3/3/18
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function [NodeSet] = updateNodeInfo(idx1, idx2, Cost, NodeSet)
       
    % Parent node #
    NodeSet.NodesInfo(1, 2, idx2) = NodeSet.NodesInfo(1, 1, idx1);
    
    % node2 steps to come = node1 steps to come + 1
    NodeSet.NodesInfo(1, 3, idx2) = NodeSet.NodesInfo(1, 3, idx1) + 1;
    
    % node2 cost to come = node1 cost to come + distance between nodes 
    NodeSet.NodesInfo(1, 4, idx2) = Cost;
    
    
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%