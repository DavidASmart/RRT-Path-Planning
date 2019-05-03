function [idxMC] = evalMaxCost(idx, cfn)

global NodeSet

% initialize all costs to 0
cost = zeros(1,length(idx));

for j = 1:length(idx) % for all nearby nodes
    cost(j) = NodeSet.NodesInfo(:,4,idx(j)); % get cost values
end

% initialize indecies
idxMC = zeros(1,cfn);

for j = 1:cfn
    [~, i] = max(cost); % get index from neigbor list
    idxMC(j) = idx(i); % get index in node record
    cost(i) = 0; % delete max cost
end

end
