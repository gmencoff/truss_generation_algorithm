function [global_graph,xPaths] = buildstruct_globalgraphbuild(global_graph,local_graph,xGoal)
%This function finishes building the global graph with edges between every
%surface

[~,surface_num] = size(global_graph); % this is the number of global nodes
xPaths = struct('start_index',[],'end_index',[],'xPath',[],'path_cost',[]); % initialize xPath struct

% for each node, check if it is the goal node and add all other nodes as
% neighbors
for iNode = 1:surface_num
    
   %check if this is the goal surface
   endpoints = global_graph(iNode).endpoints;
   if (xGoal(2) == endpoints(2,1)) && (xGoal(1) == endpoints(1,1) || xGoal(1) == endpoints(1,2) || (xGoal(1) < endpoints(1,1) && xGoal(1) > endpoints(1,2)))
       global_graph(iNode).is_goal_node = 1;
   else
       global_graph(iNode).is_goal_node = 0;
   end
end

% for each possible path, calculate xPath, there is a max of (n-1)!
possible_paths = 0;
for i = 1:(surface_num-1)
    possible_paths = possible_paths+i;
end
start_index = 1; % initialize start and end indices
end_index = 2;

for iPath = 1:possible_paths
    surface_start = global_graph(start_index).endpoints;
    surface_goal = global_graph(end_index).endpoints;
    xPath = buildstruct_localsearch(local_graph,surface_start,surface_goal);
    xPaths(iPath).start_index = start_index;
    xPaths(iPath).end_index = end_index;
    xPaths(iPath).xPath = xPath;
    
    end_index = end_index+1; %go to next end index
    % if end index goes past the number of nodes, start index increases by
    % one and end index becomes one more than start index
    if end_index == surface_num+1
        start_index = start_index+1;
        end_index = start_index+1;
    end
    
    % for each xPath, get the cost by summing up the distance between each
    % points
    if isnan(xPath)
        xPaths(iPath).path_cost = inf; % if the path doesn't exist, cost is infinite
    else
        %calculate path cost by summing distance between all points,
        
        [~,point_num] = size(xPath);
        path_cost = 0;
        for iPoint = 1:point_num-1
            point1 = xPath(:,iPoint);
            point2 = xPath(:,iPoint+1);
            path_cost = path_cost + norm(point2-point1);
        end
        xPaths(iPath).path_cost = 2*path_cost; % multiply by 2 because the truss has a layer beneath the path
    end    
end

%for each surface, add neighbors and path cost
for iNode = 1:surface_num
    for iPath = 1:possible_paths
        % if the path start or path end is current node, it it to neighbors and add
        % cost of path
        if xPaths(iPath).start_index == iNode && ~isinf(xPaths(iPath).path_cost)
            global_graph(iNode).neighbor_indices = [global_graph(iNode).neighbor_indices xPaths(iPath).end_index];
            %global_graph(iNode).neighbor_cost = [global_graph(iNode).neighbor_cost xPaths(iPath).path_cost];
        elseif xPaths(iPath).end_index == iNode && ~isinf(xPaths(iPath).path_cost)
            global_graph(iNode).neighbor_indices = [global_graph(iNode).neighbor_indices xPaths(iPath).start_index];
            %global_graph(iNode).neighbor_cost = [global_graph(iNode).neighbor_cost xPaths(iPath).path_cost];
        end
    end 
end

