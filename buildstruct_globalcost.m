function [global_graph] = buildstruct_globalcost(global_graph,trusses)
%This function fills in the neighbor cost values in the global graph

[~,truss_num] = size(trusses);

for iTruss = 1:truss_num
   truss = trusses(iTruss).truss;
   truss_cost = trusscost(truss); % calculate the cost of the truss
      
   % insert the cost into the global graph
   global_start = trusses(iTruss).global_vertex_1;
   global_end = trusses(iTruss).global_vertex_2;
   
   start_neighbor_index = find(global_graph(global_start).neighbor_indices==global_end);
   end_neighbor_index = find(global_graph(global_end).neighbor_indices==global_start);
   
   global_graph(global_start).neighbor_cost(start_neighbor_index) = truss_cost;
   global_graph(global_end).neighbor_cost(end_neighbor_index) = truss_cost;
   
end

end

