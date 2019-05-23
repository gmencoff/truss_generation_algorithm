function [surface_path] = buildstruct_globalsearch(global_graph,start_surface_index)
%This outputs a truss_path structure laying out where the tops of trusses
%need to be constructed

[~,node_num] = size(global_graph);
pqOpen = priority_prepare(); % prepare priority queue
idxClosed = []; % prepare closed queue

% find the goal node
for iNode = 1:node_num
   if global_graph(iNode).is_goal_node == 1
      goal_node = iNode;
   end
end

pqOpen = priority_insert(pqOpen,start_surface_index,buildstruct_globalheuristic(global_graph,start_surface_index));% add first node to priority queue
global_graph(start_surface_index).g = 0; % set the g value for the first surface

while ~isempty(pqOpen)
   [pqOpen,key,cost] = priority_minExtract(pqOpen); % extract node from pqOpen
   idxClosed = [idxClosed key]; % add extracted value to idxClosed
   
   % check if this is the goal node
   if key == goal_node
       break
   end
   
   % get expand list
   expand_list_initial = global_graph(key).neighbor_indices;
   expand_list = [];
   
   %check that these are not in C
   for iExpandCheck = 1:length(expand_list_initial)
       if sum(idxClosed == expand_list_initial(iExpandCheck)) == 0
           expand_list = [expand_list expand_list_initial(iExpandCheck)];
       end
   end
   
   for iExpand = 1:length(expand_list)
       [global_graph,pqOpen] = buildstruct_globalexpandelement(global_graph,key,expand_list(iExpand),pqOpen);
   end

end

% follow the backpointers until you get to the start node
current_node = goal_node;
surface_path = [goal_node];
while current_node ~= start_surface_index
    current_node = global_graph(current_node).backpointer;
    surface_path = [current_node surface_path];
end

end

