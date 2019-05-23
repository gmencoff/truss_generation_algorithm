function [truss_elements] = buildstruct_trusselements(truss)
% This function gets the shift of the vertices based on FEA Truss method,
% and puts it into the truss structure in vertex shift field

[~,vertex_num] = size(truss);
truss_elements = struct('vertex_index_1',[],'vertex_index_2',[],'vertex_1',[],'vertex_2',[],'vertex_1_bc',[],'vertex_2_bc',[],'length',[],'angle',[],'stress',[]);
elements = 1; % keep track of number of elements stored

for iVertex = 1:vertex_num
    element_num = length(truss(iVertex).neighbors); % get the number of neihbors
    
    % for each neighbor, add a truss element if it doesn't already exist
    for iElement = 1:element_num
       vertex = truss(iVertex).vertex;
       neighbor_vertex = truss(truss(iVertex).neighbors(iElement)).vertex;
       diff = neighbor_vertex-vertex;
       element_length = norm(diff);
       element_angle = atan(diff(2)/diff(1));
       
       % avoid duplicate entries
       if iVertex < truss(iVertex).neighbors(iElement)
           truss_elements(elements).vertex_index_1 = iVertex;
           truss_elements(elements).vertex_index_2 = truss(iVertex).neighbors(iElement);
           truss_elements(elements).vertex_1_bc = truss(iVertex).boundary_condition;
           truss_elements(elements).vertex_2_bc = truss(truss(iVertex).neighbors(iElement)).boundary_condition;
           truss_elements(elements).vertex_1 = vertex;
           truss_elements(elements).vertex_2 = neighbor_vertex;
           truss_elements(elements).length = element_length;
           truss_elements(elements).angle = element_angle;
           elements = elements+1;
       end
    end
end

