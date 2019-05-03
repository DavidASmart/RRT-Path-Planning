% *** DYNAMIC ***
%
% Start search for the Goal
% Once a Path from the Start to the Goal has been found
% Move the Start along the Planned Path toward the first node 
% by the ammount limit
% Update the NodeSet costs according to the new position of the Start-Node
%
% Move the Goal randomly within an area of radius limit
% Continue the Search for the Goal
%
% Continue this loop until Start reaches Goal
%
% Output plot of actual Path taken by Goal Node
% Output plot of actual Path taken by Start Node
%
% *** DYNAMIC ***
%
% *FUTURE ADDITIONS*
%
% Dynamic-2.0 will have a continously moving goal according to
% some preset velocity with some gaussian noise added, thus the goal
% trying to be found by the RRT will be a prediction of the future position
% of the goal assuming no noise
%
% Dynamic-3.0 will involve measureing and tracking the goals position and velocity 
% using a standard Kalman Filter
%
% Dynamic-4.0 will require a clear line of sight for knowledge of obstacles 
% as well as for measurements of the goal to be made
%
% Dynamic 5.0 will have multiple targets/goals
%
% Dynamic-6.0 will have multiple agents searching for the Goal 
% which are all controled by a central source (which is physicaly located)
% that can see all measuremnts (from agents within a line of sight chain)
% and makes a single estimate of the Goals fututre position
% and cordonates trajectories of all agents to avoid collisions
%
% Dynamic-6.5 will have multiple agents searching for the Goal 
% which are all independently controled
% and which each make their own estimates of the Goals future position
% but can still share measurements with one another within line of sight
% and which share their own paths with one another within line of sight...
% so that they can avoid one another
%
% Dynamic-7.0/5 will be in 3D
%
% Dynamic-8.0/5 will require smooth-snap trajectories (quadcoptor)
%
% Dynamic-9.0/5 transfer from Matlab to C/C++ mex for real-time processing
%
% *** DYNAMIC ***