close all
clear
clc

res = sqrt(8); % minimum distance between nodes

% DIFFICULT
StartNode = round(res*floor([60-res,120+res]/res));
GoalNode = round(res*floor([180+res,30-res]/res));

limit = 25; % max distance between samples
nsmooth = 100; % number of random smoothing attempts
dispRRT = 0; % plot generated nodes? (y1/n0) - shows final path regardless

% testing permutations of "params"
MC = 10; % number of MC trials
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% params: 
% [(0)Rand/(1)Halton Psudo-Random Sequence, ...
% ... (0)Full-Area/(1)Expanding, ...
% ... (0)Full-Length/(1)Limited, ...
% ... (0)Just-Sampling/(1)Straight-Line-Attempts, ...
% ... (0)Original-Connections/(1)Rewiring-Optimal, ...
% ... (0)No-Smoothing/(1)Short-Connect/(2)+Randomized-Pointwise-Smoothing]
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
for i = 1:MC
    params = [0, 0, 0, 0, 0, 0]; % default

%     % set up display
%     InitDisplay(StartNode, GoalNode, res)
    % search entire space for optimal path
    [~, Cost(i), Time(i)] = RRT_Search (StartNode, GoalNode, res, limit, nsmooth, params, dispRRT);
end
% remove outliers
mC = mean(Cost);
mT = mean(Time);
sC = std(Cost);
sT = std(Time);
for i = MC:-1:1
    if (abs(Cost(i) - mC) > sC*1.5) || (abs(Time(i) - mT) > sT*1.5)
        Cost(i) = [];
        Time(i) = [];
    end
end
% average over MC trials
C000000 = mean(Cost);
T000000 = mean(Time);
fprintf('\n params = ');
params_str = num2str(params); params_str = params_str(find(~isspace(params_str)));
fprintf(params_str);
fprintf('\n Cost = %f', mean(Cost));
fprintf('\n Time = %f', mean(Time))
fprintf('\n');
clear Cost Time
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
for i = 1:MC
    params = [0, 1, 0, 0, 0, 0]; % expanding

%     % set up display
%     InitDisplay(StartNode, GoalNode, res)
    % search entire space for optimal path
    [~, Cost(i), Time(i)] = RRT_Search (StartNode, GoalNode, res, limit, nsmooth, params, dispRRT);
end
% remove outliers
mC = mean(Cost);
mT = mean(Time);
sC = std(Cost);
sT = std(Time);
for i = MC:-1:1
    if (abs(Cost(i) - mC) > sC*1.5) || (abs(Time(i) - mT) > sT*1.5)
        Cost(i) = [];
        Time(i) = [];
    end
end
% average over MC trials
C010000 = mean(Cost);
T010000 = mean(Time);
fprintf('\n params = ');
params_str = num2str(params); params_str = params_str(find(~isspace(params_str)));
fprintf(params_str);
fprintf('\n Cost = %f', mean(Cost));
fprintf('\n Time = %f', mean(Time))
fprintf('\n');
clear Cost Time
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
for i = 1:MC
    params = [0, 0, 1, 0, 0, 0]; % Limited

%     % set up display
%     InitDisplay(StartNode, GoalNode, res)
    % search entire space for optimal path
    [~, Cost(i), Time(i)] = RRT_Search (StartNode, GoalNode, res, limit, nsmooth, params, dispRRT);
end
% remove outliers
mC = mean(Cost);
mT = mean(Time);
sC = std(Cost);
sT = std(Time);
for i = MC:-1:1
    if (abs(Cost(i) - mC) > sC*1.5) || (abs(Time(i) - mT) > sT*1.5)
        Cost(i) = [];
        Time(i) = [];
    end
end
% average over MC trials
C001000 = mean(Cost);
T001000 = mean(Time);
fprintf('\n params = ');
params_str = num2str(params); params_str = params_str(find(~isspace(params_str)));
fprintf(params_str);
fprintf('\n Cost = %f', mean(Cost));
fprintf('\n Time = %f', mean(Time))
fprintf('\n');
clear Cost Time
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
for i = 1:MC
    params = [0, 0, 0, 1, 0, 0]; % Straight-Line-Attempts

%     % set up display
%     InitDisplay(StartNode, GoalNode, res)
    % search entire space for optimal path
    [~, Cost(i), Time(i)] = RRT_Search (StartNode, GoalNode, res, limit, nsmooth, params, dispRRT);
end
% remove outliers
mC = mean(Cost);
mT = mean(Time);
sC = std(Cost);
sT = std(Time);
for i = MC:-1:1
    if (abs(Cost(i) - mC) > sC*1.5) || (abs(Time(i) - mT) > sT*1.5)
        Cost(i) = [];
        Time(i) = [];
    end
end
% average over MC trials
C000100 = mean(Cost);
T000100 = mean(Time);
fprintf('\n params = ');
params_str = num2str(params); params_str = params_str(find(~isspace(params_str)));
fprintf(params_str);
fprintf('\n Cost = %f', mean(Cost));
fprintf('\n Time = %f', mean(Time))
fprintf('\n');
clear Cost Time
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
for i = 1:MC
    params = [0, 0, 0, 0, 1, 0]; % Re-Wireing

%     % set up display
%     InitDisplay(StartNode, GoalNode, res)
    % search entire space for optimal path
    [~, Cost(i), Time(i)] = RRT_Search (StartNode, GoalNode, res, limit, nsmooth, params, dispRRT);
end
% remove outliers
mC = mean(Cost);
mT = mean(Time);
sC = std(Cost);
sT = std(Time);
for i = MC:-1:1
    if (abs(Cost(i) - mC) > sC*1.5) || (abs(Time(i) - mT) > sT*1.5)
        Cost(i) = [];
        Time(i) = [];
    end
end
% average over MC trials
C000010 = mean(Cost);
T000010 = mean(Time);
fprintf('\n params = ');
params_str = num2str(params); params_str = params_str(find(~isspace(params_str)));
fprintf(params_str);
fprintf('\n Cost = %f', mean(Cost));
fprintf('\n Time = %f', mean(Time))
fprintf('\n');
clear Cost Time
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
for i = 1:MC
    params = [0, 0, 0, 0, 0, 1]; % Short-Connect

%     % set up display
%     InitDisplay(StartNode, GoalNode, res)
    % search entire space for optimal path
    [~, Cost(i), Time(i)] = RRT_Search (StartNode, GoalNode, res, limit, nsmooth, params, dispRRT);
end
% remove outliers
mC = mean(Cost);
mT = mean(Time);
sC = std(Cost);
sT = std(Time);
for i = MC:-1:1
    if (abs(Cost(i) - mC) > sC*1.5) || (abs(Time(i) - mT) > sT*1.5)
        Cost(i) = [];
        Time(i) = [];
    end
end
% average over MC trials
C000001 = mean(Cost);
T000001 = mean(Time);
fprintf('\n params = ');
params_str = num2str(params); params_str = params_str(find(~isspace(params_str)));
fprintf(params_str);
fprintf('\n Cost = %f', mean(Cost));
fprintf('\n Time = %f', mean(Time))
fprintf('\n');
clear Cost Time
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
for i = 1:MC
    params = [0, 0, 0, 0, 0, 2]; % Smoothing

%     % set up display
%     InitDisplay(StartNode, GoalNode, res)
    % search entire space for optimal path
    [~, Cost(i), Time(i)] = RRT_Search (StartNode, GoalNode, res, limit, nsmooth, params, dispRRT);
end
% remove outliers
mC = mean(Cost);
mT = mean(Time);
sC = std(Cost);
sT = std(Time);
for i = MC:-1:1
    if (abs(Cost(i) - mC) > sC*1.5) || (abs(Time(i) - mT) > sT*1.5)
        Cost(i) = [];
        Time(i) = [];
    end
end
% average over MC trials
C000002 = mean(Cost);
T000002 = mean(Time);
fprintf('\n params = ');
params_str = num2str(params); params_str = params_str(find(~isspace(params_str)));
fprintf(params_str);
fprintf('\n Cost = %f', mean(Cost));
fprintf('\n Time = %f', mean(Time))
fprintf('\n');
clear Cost Time
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
for i = 1:MC
    params = [0, 1, 0, 1, 0, 2]; % Expanding + Straight-Line-Attempts + Smoothing

%     % set up display
%     InitDisplay(StartNode, GoalNode, res)
    % search entire space for optimal path
    [~, Cost(i), Time(i)] = RRT_Search (StartNode, GoalNode, res, limit, nsmooth, params, dispRRT);
end
% remove outliers
mC = mean(Cost);
mT = mean(Time);
sC = std(Cost);
sT = std(Time);
for i = MC:-1:1
    if (abs(Cost(i) - mC) > sC*1.5) || (abs(Time(i) - mT) > sT*1.5)
        Cost(i) = [];
        Time(i) = [];
    end
end
% average over MC trials
C010102 = mean(Cost);
T010102 = mean(Time);
fprintf('\n params = ');
params_str = num2str(params); params_str = params_str(find(~isspace(params_str)));
fprintf(params_str);
fprintf('\n Cost = %f', mean(Cost));
fprintf('\n Time = %f', mean(Time))
fprintf('\n');
clear Cost Time
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
for i = 1:MC
    params = [0, 1, 1, 0, 0, 2]; % Expanding + Limited + Smoothing

%     % set up display
%     InitDisplay(StartNode, GoalNode, res)
    % search entire space for optimal path
    [~, Cost(i), Time(i)] = RRT_Search (StartNode, GoalNode, res, limit, nsmooth, params, dispRRT);
end
% remove outliers
mC = mean(Cost);
mT = mean(Time);
sC = std(Cost);
sT = std(Time);
for i = MC:-1:1
    if (abs(Cost(i) - mC) > sC*1.5) || (abs(Time(i) - mT) > sT*1.5)
        Cost(i) = [];
        Time(i) = [];
    end
end
% average over MC trials
C011002 = mean(Cost);
T011002 = mean(Time);
fprintf('\n params = ');
params_str = num2str(params); params_str = params_str(find(~isspace(params_str)));
fprintf(params_str);
fprintf('\n Cost = %f', mean(Cost));
fprintf('\n Time = %f', mean(Time))
fprintf('\n');
clear Cost Time
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
for i = 1:MC
    params = [0, 1, 1, 1, 0, 2]; % Expanding + Limited + Straight-Line-Attempts + Smoothing

%     % set up display
%     InitDisplay(StartNode, GoalNode, res)
    % search entire space for optimal path
    [~, Cost(i), Time(i)] = RRT_Search (StartNode, GoalNode, res, limit, nsmooth, params, dispRRT);
end
% remove outliers
mC = mean(Cost);
mT = mean(Time);
sC = std(Cost);
sT = std(Time);
for i = MC:-1:1
    if (abs(Cost(i) - mC) > sC*1.5) || (abs(Time(i) - mT) > sT*1.5)
        Cost(i) = [];
        Time(i) = [];
    end
end
% average over MC trials
C011102 = mean(Cost);
T011102 = mean(Time);
fprintf('\n params = ');
params_str = num2str(params); params_str = params_str(find(~isspace(params_str)));
fprintf(params_str);
fprintf('\n Cost = %f', mean(Cost));
fprintf('\n Time = %f', mean(Time))
fprintf('\n');
clear Cost Time
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
for i = 1:MC
    params = [0, 0, 1, 1, 1, 2]; % Limited + Straight-Line-Attempts + Re-Wireing + Smoothing

%     % set up display
%     InitDisplay(StartNode, GoalNode, res)
    % search entire space for optimal path
    [~, Cost(i), Time(i)] = RRT_Search (StartNode, GoalNode, res, limit, nsmooth, params, dispRRT);
end
% remove outliers
mC = mean(Cost);
mT = mean(Time);
sC = std(Cost);
sT = std(Time);
for i = MC:-1:1
    if (abs(Cost(i) - mC) > sC*1.5) || (abs(Time(i) - mT) > sT*1.5)
        Cost(i) = [];
        Time(i) = [];
    end
end
% average over MC trials
C001112 = mean(Cost);
T001112 = mean(Time);
fprintf('\n params = ');
params_str = num2str(params); params_str = params_str(find(~isspace(params_str)));
fprintf(params_str);
fprintf('\n Cost = %f', mean(Cost));
fprintf('\n Time = %f', mean(Time))
fprintf('\n');
clear Cost Time
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
clear params params_str

% save all variables
save('MC_RRT_Test.mat');
