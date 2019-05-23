function [h] = buildstruct_globalheuristic(global_graph,idx)
%calculates the heuristic value by calculating the cost between the start
%surface and goal surface, heuristic is arbitrarily thelargest cost if the
%goal node is not a neighbor
[~,node_num] = size(global_graph); % get the number of nodes
max_heuristic = 0; % initialize the max heuristic value

% find the goal node and set the max heuristic to be the largest neighbor
% cost
for iNode = 1:node_num
   if global_graph(iNode).is_goal_node == 1
      goal_node = iNode;
   end
   largest_neighbor_cost = max(global_graph(iNode).neighbor_cost);
   if largest_neighbor_cost > max_heuristic
      max_heuristic = largest_neighbor_cost; 
   end
end

node_neighbors = global_graph(idx).neighbor_indices;
goal_location = find(node_neighbors == goal_node);

% if the goal location is a neighbor of the node, the neighbor cost is the
% heuristic, otherwise the max heuristic is the heuristic
if idx == goal_node
    h = 0;
elseif ~isempty(goal_location)
    h = global_graph(idx).neighbor_cost(goal_location);
else
    h = max_heuristic;
end

