function [global_graph] = buildstruct_globalinit()
%This function initializes a global graph
global_graph = struct('index',[],'endpoints',[],'neighbor_indices',[],'neighbor_cost',[],'is_goal_node',[],'g',[]);
end

