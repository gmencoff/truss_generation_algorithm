function [is_stable,unstable_vertex] = buildstruct_stabilitytest(stability_matrix,truss,conditional_matrix,conditions,RobotWeight)
%Tests the stability if the weight of the robot is placed at each top
%vertex

[vertex_num,force_num] = size(stability_matrix);
vertex_num = vertex_num/2; % get the number of forces and vertices
error = RobotWeight/100; %allowable error

vertices =[]; % store vertices
top_vertices = []; % stores top vertex

%build a vertex matrix
for iVertex = 1:vertex_num
   vertices = [vertices truss(iVertex).vertex];
end

%check each vertex to see if it is the top vertex
for iVertex = 1:vertex_num
   x_conditional = vertices(1,:) == vertices(1,iVertex); % checks to see which vertices have the same x values
   y_vals = vertices(2,:).*x_conditional;
   if max(y_vals) == vertices(2,iVertex)
      top_vertices = [top_vertices iVertex]; 
   end
end

% for each top vertex, check to see if a viable solution exists to the
% matrix equations
for iTopVertex = 1:length(top_vertices)
    force_balance = zeros(vertex_num*2,1);
    force_balance(vertex_num+top_vertices(iTopVertex),1) = RobotWeight; % get the force balance solution matrix
    
    forces = lsqlin(stability_matrix,force_balance,conditional_matrix,conditions); % get a least squares solution for the forces

    solution_val = stability_matrix*forces - force_balance;
    
    % if there is a value that is greater than the allowable error, a valid
    % solution was not found and the system is not stable
    if max(abs(solution_val)) > error
        unstable_vertex = top_vertices(iTopVertex);
        is_stable = false;
        return
    end
end

is_stable = true;
unstable_vertex = [];

