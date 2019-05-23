function [trusses] = buildstruct_trussstabalizer(trusses,world,RobotWeight,YieldStress,Area,Youngs,member_length)
%This Function tests the trusses for stability and then adds members until
%the each truss is stable

[~,truss_num] = size(trusses);
new_trusses = struct('truss',[],'global_vertex_1',[],'global_vertex_2',[]); % initialize new truss struct

% for each truss, keep adding members until the truss is stable
for iTruss = 1:truss_num
    new_trusses(iTruss).global_vertex_1 = trusses(iTruss).global_vertex_1; % set the global vertices
    new_trusses(iTruss).global_vertex_2 = trusses(iTruss).global_vertex_2;
    
    truss = trusses(iTruss).truss;
    [is_stable] = buildstruct_truss_is_stable(truss,Youngs,Area,RobotWeight,YieldStress); % test stability
    
    % while unstable, add new members to the truss
    while is_stable ~= 1
       truss = buildstruct_trussaddmembers(truss,world,member_length);
       [is_stable] = buildstruct_truss_is_stable(truss,Youngs,Area,RobotWeight,YieldStress); % test stability % test truss stability
    end
    
    new_trusses(iTruss).truss = truss;
end

trusses = new_trusses;

end

