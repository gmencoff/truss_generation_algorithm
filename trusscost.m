function truss_cost = trusscost(truss)
% Calculates the cost of the truss, in this case the cost of the truss is
% just the number of edges, which is the number of neighbors divided by 2

[~,truss_vertices] = size(truss);
edge_sum = 0;

for iVertex = 1:truss_vertices
    [~,neighbor_num] = size(truss(iVertex).neighbors);
    edge_sum = edge_sum+neighbor_num;
end

truss_cost = edge_sum/2;

end

