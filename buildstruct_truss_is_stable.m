function [truss_is_stable] = buildstruct_truss_is_stable(truss,Youngs,Area,RobotWeight,yield_stress)
% Figures whether a given truss is stable based on FEA method and if not generates
% a new truss until it is stable, test when the weight of the robot is on
% each vertex

[~,vertex_num] = size(truss);

[truss_elements] = buildstruct_trusselements(truss); % generate the truss elements
[stiffness_matrix] = buildstruct_trussstiffness(truss,truss_elements,Youngs,Area); % get a stiffness matrix

% test robot weight on each vertex
for iVertex = 1:vertex_num
    Force = zeros(2*vertex_num,1);
    Force(2*iVertex) = -RobotWeight;
    
    [truss_elements] = buildstruct_trussstress(truss,truss_elements,stiffness_matrix,Force,Youngs); % get stress on each element
    [truss_is_stable] = buildstruct_trussstability(truss_elements,yield_stress); % determine whether truss is stable
    
    if ~truss_is_stable
       return 
    end
end

end

