function [] = InitDisplay(StartNode, GoalNode, res)

    global map

    r = round(res/2);

    close all
    figure(1);
    imshow(map);
    set(gcf, 'Position', [1536*0.2 864*0.2 1536*0.6 864*0.6]);
    grid on;
    grid minor;
    hold on;

    % establish block
    bX = [-r,-r,r,r,-r];
    bY = [-r,r,r,-r,-r];
    % add in start and goal nodes
    patch(StartNode(1)+bX,StartNode(2)+bY,'g');
    patch(GoalNode(1)+bX,GoalNode(2)+bY,'r');

%     % add in obstacles
%     for x = 1:size(map,2)
%         for y = 1:size(map,1)
%         c = EvalCrashBlock([x,y], r);
%             if c
%                 patch(x+bX, y+bY,'k');
%             end
%         end
%     end

    pause(0.001); % to allow user to see the display

end

