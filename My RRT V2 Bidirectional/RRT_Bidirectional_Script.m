%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% David A Smart
% University of Maryland, College Park
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% StartNode = [0,0];
% GoalNode = [250,150];
close all
clear
clc

mapno = 3;

global map
map = imread(strcat('map', num2str(mapno),'.bmp'));

res = round(sqrt((size(map,1)/100)^2 + (size(map,2)/100)^2)); % minimum distance between nodes

% % until both start and goal are initialized in free space
% inObs = 1;
% while inObs
% 
%     % generate random start and end points
%     StartNode = [randi(size(map,1)),randi(size(map,2))];
%     GoalNode = [randi(size(map,1)),randi(size(map,2))];
% 
%     % check if they are in an obstical
%     Crash_Start = EvalCrashBlock(StartNode, res);
%     Crash_Goal = EvalCrashBlock(GoalNode, res);
%     if ~Crash_Start && ~Crash_Goal
%         inObs = 0;
%     end
% 
% end
% 
% clear Crash_Start Crash_Goal inObs

if mapno == 0
    StartNode = round(res*floor([420,230-res]/res));
    GoalNode = round(res*floor([1285+res,840+res]/res));

elseif mapno == 1 || mapno == 2 || mapno == 3 || mapno == 4 || mapno == 5
    StartNode = round(res*floor([size(map,2)*0.1+res,size(map,1)*0.1+res]/res));
    GoalNode = round(res*floor([size(map,2)*0.99-res,size(map,1)*0.99-res]/res));

elseif mapno == 6
    StartNode = round(res*floor([80+res,20+res]/res));
    GoalNode = round(res*floor([1400-res,975-res]/res));
end

% % DIFFICULT
% StartNode = round(res*floor([60-res,120+res]/res));
% GoalNode = round(res*floor([180+res,30-res]/res));

params = [0, 0, 1, 1, 0, 2]; % when expanding...only nodeset#1 grows?
% params: 
% [(0)Rand/(1)Halton Psudo-Random Sequence, ...
% ... (0)Full-Area/(1)Expanding, ...
% ... (0)Full-Length/(1)Limited, ...
% ... (0)Just-Sampling/(1)Straight-Line-Attempts, ...
% ... (0)Original-Connections/(1)Rewiring-Optimal, ...
% ... (0)No-Smoothing/(1)Short-Connect/(2)+Randomized-Pointwise-Smoothing]

% Suggested params 
% #01112 (best)
% #00002 (also good)

% Other notes
% #00000 - highest cost
% #00100 - lostest runtime, but high cost
% #00010 - lowest cost, but highest runtime
% #11002 - low cost, but high run time

limit = res*10; % max distance between samples

nsmooth = 100; % number of random smoothing attempts

% plot generated nodes? (y1/n0) - shows final path regardless
dispRRT = 1; % 1

% set up display
InitDisplay(StartNode, GoalNode, res)

% search entire space for optimal path
[Path, Cost, Time] = RRT_Search_Bidirectional (StartNode, GoalNode, res, limit, nsmooth, params, dispRRT);

% fprintf('\n The Path found with RRT Search has a length %3.0f m', Cost)
% fprintf('\n The RRT Search took %3.3f s \n\n', Time)
% 
% % save
% params_str = num2str(params); params_str = params_str(find(~isspace(params_str)));
% save(strcat('RRT_',num2str(mapno),'_',params_str,'.mat'));
% saveas(gcf,strcat('RRT_',num2str(mapno),'_',params_str,'.jpg'));

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%