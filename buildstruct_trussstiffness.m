function [stiffness_matrix] = buildstruct_trussstiffness(truss,truss_elements,Youngs,Area)
% This function generates a stiffness matrix for the truss

[~,vertex_num] = size(truss); % number of vertices
[~,element_num] = size(truss_elements); % number of elements

% initialize the stiffness matrix
stiffness_matrix = zeros(2*vertex_num,2*vertex_num);

% for each element, build a local stiffness matrix
for iElement = 1:element_num
    element_length = truss_elements(iElement).length;
    ang = truss_elements(iElement).angle;
    vertex_1_index = truss_elements(iElement).vertex_index_1;
    vertex_2_index = truss_elements(iElement).vertex_index_2;
    global_vertex_indices = [2*vertex_1_index-1 2*vertex_1_index 2*vertex_2_index-1 2*vertex_2_index];
    local_stiffness = Area*Youngs/element_length*...
        [cos(ang)^2         cos(ang)*sin(ang)  -cos(ang)^2        -cos(ang)*sin(ang);
         cos(ang)*sin(ang)  sin(ang)^2         -cos(ang)*sin(ang) -sin(ang)^2       ;
         -cos(ang)^2        -cos(ang)*sin(ang) cos(ang)^2         cos(ang)*sin(ang) ;
         -cos(ang)*sin(ang) -sin(ang)^2        cos(ang)*sin(ang)  sin(ang)^2];
 
    %add the local stiffness matrix to the global stiffness matrix    
    for iRow = 1:4
       for iColumn = 1:4
           global_row = global_vertex_indices(iRow);
           global_column = global_vertex_indices(iColumn);
           stiffness_matrix(global_row,global_column) = stiffness_matrix(global_row,global_column) + local_stiffness(iRow,iColumn);
       end
    end
end

end

