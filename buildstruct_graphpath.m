%function [xPath]=graph_path(graphVector,idxStart,idxEnd)
%This function follows the backpointers from the node with index  idxEnd in 
%graphVector to the one with index  idxStart node, and returns the  coordinates
%(not indexes) of the sequence of traversed elements.
function [xPath]=buildstruct_graphpath(local_graph,start_vertices,idxGoal)

current_index = idxGoal; % keeps track of index
xPath = [];
start_indices = []; % stores start indices

%get the indices of the start_vertices
for iVertices = 1:length(start_vertices)
    start_indices = [start_indices buildstruct_getvertexindex(start_vertices(:,iVertices),local_graph)];
end

% loop until the current index is on the start surface
while isempty(find(start_indices == current_index,1))
    point = local_graph(current_index).vertex;
    xPath = [point xPath];
    current_index = local_graph(current_index).backpointer;
end

xPath = [local_graph(current_index).vertex xPath]; %add the start location to the beggining of the array
