function Visited = evalVisited(Node, ClosestNode, res)

dd = sqrt((Node(1) - ClosestNode(1))^2 + ...
        (Node(2) - ClosestNode(2))^2);

if dd < res % if too close
    Visited = 1; % same as a previous node
else
    Visited = 0;
end

end