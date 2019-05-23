function [stability_matrix] = buildstruct_stabilitymatrixinit(truss)
%Initializes the stability matrix

[~,joint_num] = size(truss); % gets the number of joints in the stability matrix
edge_num = 0; % initialize edge_num

% for each joint, count the number of neighbors, this value is 2x the
% number of edges in the matrix
for iJoint = 1:joint_num
    edge_num = edge_num+length(truss(iJoint).neighbors);
end

edge_num = edge_num/2; %  the number of edges is the number counted divided by two

stability_matrix = zeros(2*joint_num,edge_num+2); % the stability matrix has 2 rows for each vertex and the number of edges+2 columns for the external forces

% add a 1 in the external force matrix in the first row for Fx and
% joint_num+1 row for Fy
stability_matrix(1,edge_num+1) = 1;
stability_matrix(joint_num+1,edge_num+2) = 1;


end

