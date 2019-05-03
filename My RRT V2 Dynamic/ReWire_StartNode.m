function [NodeSet, h] = ReWire_StartNode(NodeSet, NewStart, h, res)
% update NodeSet with new Start
% updates connections of all child nodes
% updates costs of all nodes in nodeset

    % update NodeSet with new Start
    NodeSet.Nodes(:,:,2) = NewStart;

    % updates connections of all child nodes
    for i = 3:size(NodeSet.Nodes, 3) % for all nodes besides Goal and Start
        if NodeSet.NodesInfo(1, 2, i) == 2 % if a direct child of the Start Node
            
            % delete old connection
            delete(h(NodeSet.NodesInfo(1,1,i)));

            % draw new connection
            xl = [NewStart(1), NodeSet.Nodes(1, 1, i)];
            yl = [NewStart(2), NodeSet.Nodes(1, 2, i)];
            h(NodeSet.NodesInfo(1,1,i)) = plot(xl, yl, 'b');
            
            % update costs of child nodes in nodeset
            [Crash, ~] = EvalCrashEdge2(NodeSet.Nodes(1, :, i), NewStart, res);
            if Crash
                NodeSet.NodesInfo(1,4,i) = inf;
            end
            
        end
    end
    
end

