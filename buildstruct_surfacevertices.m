function [surface_vertices] = buildstruct_surfacevertices(surface,local_graph)
%This function finds all of the surface vertices that are on the local graph

start_vertex = surface(:,1);
end_vertex = surface(:,2);
surface_vertices = start_vertex; % first point on the surface is added to surface vertices
current_vertex_index = buildstruct_getvertexindex(start_vertex,local_graph);
% keep adding neighbors to surface vertices until the surface endpoint is
% added
while ~isequal(surface_vertices(:,end),end_vertex)
    current_neighbors = local_graph(current_vertex_index).neighbor_indices; % get the current vertex neighbors
    
    % Check if each neighbor is on the surface, if it is add it to
    % surface_vertices and update the vertex_index
    for iNeighbor = 1:length(current_neighbors)
        neighbor_vertex = local_graph(current_neighbors(iNeighbor)).vertex;
        
        % checks if neighbor vertex is on the surface
        if (neighbor_vertex(2) == start_vertex(2)) && ((neighbor_vertex(1) >= start_vertex(1) && neighbor_vertex(1) <= end_vertex(1)) || (neighbor_vertex(1) <= start_vertex(1) && neighbor_vertex(1) >= end_vertex(1)))
            % checks that the neighbor vertex isn't already in
            % surface_vertices
            if isempty(find(((surface_vertices(1,:) == neighbor_vertex(1)) + (surface_vertices(2,:) == neighbor_vertex(2))==2)))
                surface_vertices = [surface_vertices neighbor_vertex];
                current_vertex_index = current_neighbors(iNeighbor);
            end
        end
    end
    % find the current vertex in the local graph
    % look through the neighbors until one on the surface is located
    % add  the neighbor on the surface to surface vertices

end

