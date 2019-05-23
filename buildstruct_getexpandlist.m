%function [idxExpand]=graph_getExpandList(graphVector,idxNBest,idxClosed)
%Finds the neighbors of element  idxNBest that are not in  idxClosed (line 
%it:expansion in Algorithm  alg:astar).
function [idxExpand]=buildstruct_getexpandlist(local_graph,key,idxClosed,Dir)

neighbors = local_graph(key).neighbor_indices; % get the list of neighbors
idxExpand = []; % initialize idxExpand

for iNeighbor = 1:length(neighbors) % look at each neighbor
    if sum(idxClosed == neighbors(iNeighbor)) == 0 % see if current neighbor is is in idxClosed
        
        % check to see if the neighbor is in the correct direction
        if Dir == 'R' && (local_graph(neighbors(iNeighbor)).vertex(1)-local_graph(key).vertex(1)) > 0
            idxExpand = [idxExpand neighbors(iNeighbor)];
        elseif Dir == 'L' && (local_graph(neighbors(iNeighbor)).vertex(1)-local_graph(key).vertex(1)) < 0
            idxExpand = [idxExpand neighbors(iNeighbor)];
        end
    end
end
%Ensure that the vector  idxBest is not included in the list of neighbors (i.e.,
%avoid self-loop edges in the graph).
