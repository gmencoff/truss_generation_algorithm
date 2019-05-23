function [vertex_index] = buildstruct_getvertexindex(vertex,local_graph)
%This function finds the index of the vertex given

[~,num_vertices] = size(local_graph); % gives the number of vertices in the local graph
vertex_matrix = zeros(3,num_vertices); % will store each vertex and index
logical_array = zeros(3,num_vertices); % this array assits us locating the neighbors

% create a matrix containing each vertex coordinate and index
for iVertex = 1:num_vertices
    vertex_matrix(1:2,iVertex) = local_graph(iVertex).vertex;
    vertex_matrix(3,iVertex) = local_graph(iVertex).index;
end

% find the index of the first vertex
logical_array(1,:) = vertex_matrix(1,:) == vertex(1);
logical_array(2,:) = vertex_matrix(2,:) == vertex(2);
vertex_index = find((logical_array(1,:) + logical_array(2,:))==2);

end

