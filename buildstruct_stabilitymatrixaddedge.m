function [stability_matrix] = buildstruct_stabilitymatrixaddedge(stability_matrix,truss)
%Fills out the stability matrix with the edges decomposed in to x and y
%forces

[~,truss_vertices] = size(truss); % gets the number of vertices to iterate through
completed_edges = []; % this will store edges that have already been added to the matrix so they are not duplicated

for iVertex = 1:truss_vertices
    neighbors = truss(iVertex).neighbors; % get vertex neighbors from truss struct
    current_vertex = truss(iVertex).vertex; % get the vertex from the truss struct
    %loop through each neighbor, add to the stability matrix if not already
    %in it
    for iNeighbor = 1:length(neighbors)
       neighbor_vertex = truss(neighbors(iNeighbor)).vertex; % get the neighbor vertex
       completion_check = sum(sum(((completed_edges == iVertex) + (completed_edges == iNeighbor)),2) == 2); % check whether the joint indices have already been added to completed_edges
       if completion_check == 0
          completed_edges = [completed_edges;iVertex neighbors(iNeighbor)]; % add pair to completed edges
          [edge_number,~] = size(completed_edges); % see what edge number we are on
          difference = (neighbor_vertex-current_vertex); % get the difference vector
          force_decomposition = difference/norm(difference); % get the force decomposition
          
          % add the x and y components to the stability_matrix for the
          % current vertex and the negative values for the neighbor
          stability_matrix(iVertex,edge_number) = force_decomposition(1);
          stability_matrix(truss_vertices+iVertex,edge_number) = force_decomposition(2);
          stability_matrix(neighbors(iNeighbor),edge_number) = -force_decomposition(1);
          stability_matrix(truss_vertices+neighbors(iNeighbor),edge_number) = -force_decomposition(2);
       end
    end
    
end

end

