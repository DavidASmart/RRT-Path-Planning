function [SPath, H] = ShortConnect(Path, res, params, H)

% starting with the start node
% try to connect to the terminal node
% if it does not work, keep backtracking through the nodes until one
% can be connected to the start node
% then, try to connect that node to the terminal node and so forth
% until the terminal node is reached

% initialize, start with start node
j = 1;
SPath = Path(j,:);

steps = size(Path,1); % number of nodes between start and terminal node

while j < steps-1
    for i = steps:-1:j+1 % backtrack through the nodes
        
        Node1 = Path(j,:); % current point in path
        Node2 = Path(i,:); % potential next node in path

        % check if Node1 and Node2 can be connected
        [Crash] = EvalCrashEdge2(Node1, Node2, res);

        if ~Crash % if they can
            SPath = [SPath; Node2]; % Update Path
            j = i; % update the start point
            break;
        end
    end
    
    % if it gets through all of them...then it must be able to connect to
    % the next one, cuz that is what it is connected to now...
    SPath = [SPath; Node2]; % Update Path
    j = i; % update the start point
end

% complete, add terminal node
SPath = [SPath; Path(end,:)]; % Update Path

if params(end) ~= 2
    % plot the smoothed path
    H(end+1) = plot(SPath(:,1),SPath(:,2),'g', 'LineWidth',2);
end

end

