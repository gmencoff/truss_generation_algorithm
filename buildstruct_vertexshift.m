function [truss_elements] = buildstruct_trusselements(truss)
% This function gets the shift of the vertices based on FEA Truss method,
% and puts it into the truss structure in vertex shift field

[~,vertex_num] = size(truss);
truss_elements = struct('vertex_1',[],'vertex_2',[],'length',[],'angle',[]);
element_num = 1; % keep track of number of elements stored

for iVertex = 1:vertex_num
    element_num = length(truss(iVertex).neighbors); % get the number of neihbors
    
    % for each neighbor, add a truss element if it doesn't already exist
    for iElement = 1:element_num
       vertex = truss(iVertex).vertex;
       neighbor_vertex = truss(truss(iVertex).neighbors(iElement)).vertex;
       diff = neighbor_vertex-vertex;
       length = norm(diff);
       angle = atan(diff(2)/diff(1));
       
       % avoid duplicate entries
       if iVertex < truss(iVertex).neighbors(iElement)
           truss_elements(element_num).vertex_1 = vertex;
           truss_elements(element_num).vertex_2 = neighbor_vertex;
           truss_elements(element_num).length = length;
           truss_elements(element_num).angle = angle;
           element_num = element_num+1;
       end
    end
end

