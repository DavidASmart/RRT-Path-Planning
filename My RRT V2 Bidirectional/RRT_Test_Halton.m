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
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% params: 
% [(0)Rand/(1)Halton Psudo-Random Sequence, ...
% ... (0)Full-Area/(1)Expanding, ...
% ... (0)Full-Length/(1)Limited, ...
% ... (0)Just-Sampling/(1)Straight-Line-Attempts, ...
% ... (0)Original-Connections/(1)Rewiring-Optimal, ...
% ... (0)No-Smoothing/(1)Short-Connect/(2)+Randomized-Pointwise-Smoothing]
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

params = [1, 0, 0, 0, 0, 0]; % default
% search entire space for optimal path
[~, C100000, T100000] = RRT_Search (StartNode, GoalNode, res, limit, nsmooth, params, dispRRT);
fprintf('\n params = ');
params_str = num2str(params); params_str = params_str(find(~isspace(params_str)));
fprintf(params_str);
fprintf('\n Cost = %f', C100000);
fprintf('\n Time = %f', T100000);
fprintf('\n');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

params = [1, 1, 0, 0, 0, 0]; % expanding
% search entire space for optimal path
[~, C110000, T110000] = RRT_Search (StartNode, GoalNode, res, limit, nsmooth, params, dispRRT);
fprintf('\n params = ');
params_str = num2str(params); params_str = params_str(find(~isspace(params_str)));
fprintf(params_str);
fprintf('\n Cost = %f', C110000);
fprintf('\n Time = %f', T110000);
fprintf('\n');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

params = [1, 0, 1, 0, 0, 0]; % Limited
% search entire space for optimal path
[~, C101000, T101000] = RRT_Search (StartNode, GoalNode, res, limit, nsmooth, params, dispRRT);
fprintf('\n params = ');
params_str = num2str(params); params_str = params_str(find(~isspace(params_str)));
fprintf(params_str);
fprintf('\n Cost = %f', C101000);
fprintf('\n Time = %f', T101000);
fprintf('\n');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

params = [1, 0, 0, 1, 0, 0]; % Straight-Line-Attempts
% search entire space for optimal path
[~, C100100, T100100] = RRT_Search (StartNode, GoalNode, res, limit, nsmooth, params, dispRRT);
fprintf('\n params = ');
params_str = num2str(params); params_str = params_str(find(~isspace(params_str)));
fprintf(params_str);
fprintf('\n Cost = %f', C100100);
fprintf('\n Time = %f', T100100);
fprintf('\n');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

params = [1, 0, 0, 0, 1, 0]; % Re-Wireing
% search entire space for optimal path
[~, C100010, T100010] = RRT_Search (StartNode, GoalNode, res, limit, nsmooth, params, dispRRT);
fprintf('\n params = ');
params_str = num2str(params); params_str = params_str(find(~isspace(params_str)));
fprintf(params_str);
fprintf('\n Cost = %f', C100010);
fprintf('\n Time = %f', T100010);
fprintf('\n');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

params = [1, 0, 0, 0, 0, 1]; % Short-Connect
% search entire space for optimal path
[~, C100001, T100001] = RRT_Search (StartNode, GoalNode, res, limit, nsmooth, params, dispRRT);
fprintf('\n params = ');
params_str = num2str(params); params_str = params_str(find(~isspace(params_str)));
fprintf(params_str);
fprintf('\n Cost = %f', C100001);
fprintf('\n Time = %f', T100001);
fprintf('\n');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

params = [1, 0, 0, 0, 0, 2]; % Smoothing
% search entire space for optimal path
[~, C100002, T100002] = RRT_Search (StartNode, GoalNode, res, limit, nsmooth, params, dispRRT);
fprintf('\n params = ');
params_str = num2str(params); params_str = params_str(find(~isspace(params_str)));
fprintf(params_str);
fprintf('\n Cost = %f', C100002);
fprintf('\n Time = %f', T100002);
fprintf('\n');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

params = [1, 1, 0, 1, 0, 2]; % Expanding + Straight-Line-Attempts + Smoothing
% search entire space for optimal path
[~, C110102, T110102] = RRT_Search (StartNode, GoalNode, res, limit, nsmooth, params, dispRRT);
fprintf('\n params = ');
params_str = num2str(params); params_str = params_str(find(~isspace(params_str)));
fprintf(params_str);
fprintf('\n Cost = %f', C110102);
fprintf('\n Time = %f', T110102);
fprintf('\n');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

params = [1, 1, 1, 0, 0, 2]; % Expanding + Limited + Smoothing
% search entire space for optimal path
[~, C111002, T111002] = RRT_Search (StartNode, GoalNode, res, limit, nsmooth, params, dispRRT);
fprintf('\n params = ');
params_str = num2str(params); params_str = params_str(find(~isspace(params_str)));
fprintf(params_str);
fprintf('\n Cost = %f', C111002);
fprintf('\n Time = %f', T111002);
fprintf('\n');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

params = [1, 1, 1, 1, 0, 2]; % Expanding + Limited + Straight-Line-Attempts + Smoothing
% search entire space for optimal path
[~, C111102, T111102] = RRT_Search (StartNode, GoalNode, res, limit, nsmooth, params, dispRRT);
fprintf('\n params = ');
params_str = num2str(params); params_str = params_str(find(~isspace(params_str)));
fprintf(params_str);
fprintf('\n Cost = %f', C111102);
fprintf('\n Time = %f', T111102);
fprintf('\n');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

params = [1, 0, 1, 1, 1, 2]; % Limited + Straight-Line-Attempts + Re-Wireing + Smoothing
% search entire space for optimal path
[~, C101112, T101112] = RRT_Search (StartNode, GoalNode, res, limit, nsmooth, params, dispRRT);
fprintf('\n params = ');
params_str = num2str(params); params_str = params_str(find(~isspace(params_str)));
fprintf(params_str);
fprintf('\n Cost = %f', C101112);
fprintf('\n Time = %f', T101112);
fprintf('\n');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
clear params params_str

% save all variables
save('RRT_Test_Halton.mat');
