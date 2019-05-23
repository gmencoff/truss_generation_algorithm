function [local_graph] = buildstruct_localedgebuild(local_graph,node_spacing)
%This function adds the edges to the local graph stored in the
%neighbor_indices field

[~,num_vertices] = size(local_graph); % gives the number of vertices in the local graph
vertex_matrix = zeros(3,num_vertices); % will store each vertex and index
logical_array = zeros(3,num_vertices); % this array assits us locating the neighbors
neighbors = struct('index',[],'vertex',[]);

% create a matrix containing each vertex coordinate and index
for iVertex = 1:num_vertices
    vertex_matrix(1:2,iVertex) = local_graph(iVertex).vertex;
    vertex_matrix(3,iVertex) = local_graph(iVertex).index;
end


% for each vertex, calculate each possible neighbor, search vertex_matrix
% for it, and add the index to the graph if it exists
for iVertex = 1:num_vertices
    
    % get the vertex for each right neighbor
    neighbors(1).vertex = local_graph(iVertex).vertex + [node_spacing;0];
    neighbors(2).vertex = local_graph(iVertex).vertex + [node_spacing;node_spacing];
    neighbors(3).vertex = local_graph(iVertex).vertex + [node_spacing;-node_spacing];
    
    % get the vertex for each left neighbor
    neighbors(4).vertex = local_graph(iVertex).vertex - [node_spacing;0];
    neighbors(5).vertex = local_graph(iVertex).vertex - [node_spacing;node_spacing];
    neighbors(6).vertex = local_graph(iVertex).vertex - [node_spacing;-node_spacing];
    
    % get the vertex above and below each neighbor for checking whether
    % diagnols should be included
    neighbors(7).vertex = local_graph(iVertex).vertex + [0;node_spacing];
    neighbors(8).vertex = local_graph(iVertex).vertex - [0;node_spacing];
    
    % search vertex_matrix for each point
    for iNeighbor = 1:8
        
        % get the x and y coordinate of the neighbors
        neighbor_x = neighbors(iNeighbor).vertex(1);
        neighbor_y = neighbors(iNeighbor).vertex(2);
        
        % checks if the neighbor is in the graph
        logical_array(1,:) = vertex_matrix(1,:) == neighbor_x; % checks to see if neighbor x coordinate exists
        logical_array(2,:) = vertex_matrix(2,:) == neighbor_y; % checks to see if neighbor y coordinate exists
        neighbor_index = find((logical_array(1,:)+logical_array(2,:)) == 2); % finds index of neighbor if it exists in the vertex_matrix
        
        % store neighbor index
        neighbors(iNeighbor).index = neighbor_index;   
    end
    
    % if the right horizontal exists, add it to indices, as well as right
    % upper and lower diagnols if they exist
    if ~isempty(neighbors(1).index)
        
        local_graph(iVertex).neighbor_indices = [local_graph(iVertex).neighbor_indices neighbors(1).index];
        
        if ~isempty(neighbors(2).index) && ~isempty(neighbors(7).index)
            local_graph(iVertex).neighbor_indices = [local_graph(iVertex).neighbor_indices neighbors(2).index];
        end
        if ~isempty(neighbors(3).index) && ~isempty(neighbors(8).index)
            local_graph(iVertex).neighbor_indices = [local_graph(iVertex).neighbor_indices neighbors(3).index];
        end
    end
    % if the left horizontal exists, add it to indices, as well as right
    % upper and lower diagnols if they exist
    if ~isempty(neighbors(4).index)
        
        local_graph(iVertex).neighbor_indices = [local_graph(iVertex).neighbor_indices neighbors(4).index];
        
        if ~isempty(neighbors(5).index) && ~isempty(neighbors(8).index)
            local_graph(iVertex).neighbor_indices = [local_graph(iVertex).neighbor_indices neighbors(5).index];
        end
        if ~isempty(neighbors(6).index) && ~isempty(neighbors(7).index)
            local_graph(iVertex).neighbor_indices = [local_graph(iVertex).neighbor_indices neighbors(6).index];
        end
    end
    
end


