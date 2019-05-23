function [truss_elements] = buildstruct_trussstress(truss,truss_elements,stiffness_matrix,external_force,Youngs)
% This function calculates the stress on each truss element

[~,vertex_num] = size(truss);
[~,stiffness_size] = size(stiffness_matrix);
[~,element_num] = size(truss_elements);
remaining_row_column = [];

%for each element vertex, remove the rows and columns from the force matrix
%and the 
for iVertex = 1:vertex_num
    boundary_condition = truss(iVertex).boundary_condition;
    
    if boundary_condition == 3
        remaining_row_column = [remaining_row_column];
    elseif boundary_condition == 2
        remaining_row_column = [remaining_row_column iVertex*2-1];
    elseif boundary_condition == 1
        remaining_row_column = [remaining_row_column iVertex*2];
    elseif boundary_condition == 0
        remaining_row_column = [remaining_row_column iVertex*2-1 iVertex*2];
    end
end

remaining_vertices_length = (length(remaining_row_column));
stiffness_matrix_new = zeros(remaining_vertices_length);
force_vector_new = zeros(remaining_vertices_length,1);

for iRow = 1:remaining_vertices_length
   stiffness_row = remaining_row_column(iRow);
   for iColumn = 1:remaining_vertices_length
       stiffness_column = remaining_row_column(iColumn);
       stiffness_matrix_new(iRow,iColumn) = stiffness_matrix(stiffness_row,stiffness_column);
   end
   force_vector_new(iRow) = external_force(stiffness_row);
end


% calculate the deflection of each remaining point
deflection = stiffness_matrix_new\force_vector_new;

overall_deflection = zeros(stiffness_size,1);

% put the deflection values into the over deflection vector
for iDeflection=1:remaining_vertices_length
    overall_deflection(remaining_row_column(iDeflection)) = deflection(iDeflection);
end

% put the new vertex locations into the truss structure
for iVertex = 1:vertex_num
   deflection_x = overall_deflection(iVertex*2-1);
   deflection_y = overall_deflection(iVertex*2);
   truss(iVertex).vertex_after_shift = [truss(iVertex).vertex(1)+deflection_x;truss(iVertex).vertex(2)+deflection_y];
end

%for each element, calculate the stress
for iElement = 1:element_num
    vertex_1_index = truss_elements(iElement).vertex_index_1;
    vertex_2_index = truss_elements(iElement).vertex_index_2;
    vertex_1_shift = truss(vertex_1_index).vertex_after_shift;
    vertex_2_shift = truss(vertex_2_index).vertex_after_shift;
    old_length = truss_elements(iElement).length;
    new_length = norm(vertex_2_shift-vertex_1_shift);
    truss_elements(iElement).stress = Youngs*(new_length-old_length)/old_length;
end

end

