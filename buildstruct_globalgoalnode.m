function [global_graph] = buildstruct_globalgoalnode(global_graph,xGoal)
%Check each vertex to see if the xGoal is on it, if it is make this the
%goal node, and make everything else a non goal node, if none are a goal
%node add a final node with the only endpoint being xGoal

surface_num = global_graph(end).index; % number of surfaces in the global_graph
goal_on_surface = 0; % this will be changed to 1 if the goal is found on a surface

% loop through each surface, if the goal node is on the surface put a 1 in
% is_goal_node, otherwise put a 0
for iGlobalVertex = 1:surface_num
   surface_vertices = global_graph(iGlobalVertex).endpoints;
   if xGoal(2) == surface_vertices(2,1) && xGoal(1) <= surface_vertices(1,1) && xGoal(1) >= surface_vertices(1,2)
       global_graph(iGlobalVertex).is_goal_node = 1;
       goal_on_surface = 1;
   else
       global_graph(iGlobalVertex).is_goal_node = 0;
   end
end

% if the goal was not on any of the surafaces, make the final node in the
% graph the goal node
if goal_on_surface == 0
    global_graph(surface_num+1).index = surface_num+1;
    global_graph(surface_num+1).endpoints = xGoal;
    global_graph(surface_num+1).is_goal_node = 1; 
end

end

