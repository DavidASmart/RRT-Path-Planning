function [NodeSet, h] = ReWire(NodeSet, res, limit, h, dispRRT)

% rewire region near last created node*************************************

NewNode = NodeSet.Nodes(:,:,end);

% find nearby nodes
[NearNodes, idx] = EvalNearNodes (NewNode, limit*2, NodeSet);

% evaluate if they are viable
for j = 1:size(NearNodes,3) % for all nearby nodes
    idx2 = idx(j); % index for 2nd node
    % initialize
    idx1 = 0;
    Cost = ones(size(NearNodes,3), 1)*1000; % intitialize costs to "inf"
    minCost = NodeSet.NodesInfo(1, 4, idx2); % current cost
    
    for i = 1:size(NearNodes,3) % try to connect back to all other nearby nodes
        if j ~= i % don't try connecting to self
            [Crash, d] = EvalCrashEdge2(NearNodes(:,:,j), NearNodes(:,:,i), res);

            if ~Crash
                % calculate the potential costs of those which are viable
                Cost(i) = NodeSet.NodesInfo(1, 4, idx(i)) + d;

                % select if less costly than current connection
                if Cost(i) < minCost
                    idx1 = idx(i); % index of new parent node
                    minCost = Cost(i);
                end
            end
        end
    end
    
    if idx1 ~= 0 % if a rewireing is benificial
        NodeSet = updateNodeInfo(idx1, idx2, minCost, NodeSet);

        if dispRRT
            % errase old edge
            delete(h(idx2));

            % plot new edge
            xl = [NodeSet.Nodes(1, 1, idx1), NodeSet.Nodes(1, 1, idx2)];
            yl = [NodeSet.Nodes(1, 2, idx1), NodeSet.Nodes(1, 2, idx2)];
            h(idx2) = plot(xl, yl, 'b');
        end
    end
      
end

% *********************************************************************

end

