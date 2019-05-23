function [conditional_matrix,conditions] = buildstruct_stabilityconditions(stability_matrix,BreakingLoad)
%Generates stability conditions to test whether the truss structure is
%stable with the robot on it

[~,force_num] = size(stability_matrix); % get the number of forces

force_sum = sum(stability_matrix); % sum the forces along the columns
external_force_num = length(find(force_sum)); % by finding the forces which do not sum to 0 we can determine the number of external forces
edge_force_num = force_num-external_force_num; % determine the number of edge forces

conditional_matrix = zeros(2*edge_force_num+external_force_num-2,force_num);
conditions = zeros(2*edge_force_num+external_force_num-2,1);
conditions(1:2*edge_force_num) = BreakingLoad;

% fill in conditional matrix for edges
for iEdge = 1:edge_force_num
   conditional_matrix((iEdge-1)*2+1,iEdge) = 1;
   conditional_matrix((iEdge-1)*2+2,iEdge) = -1;
end

% fill in conditional matrix for external forces
for iExternal = 1:external_force_num-2
   conditional_matrix(2*edge_force_num+iExternal,edge_force_num+2+iExternal) = -1; 
end
end

