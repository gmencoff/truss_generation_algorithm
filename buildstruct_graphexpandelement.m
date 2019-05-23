%function [graphVector,pqOpen]=graph_expandElement(graphVector,idxNBest,idxX,idxGoal,pqOpen)
%This function expands the vertex with index  idxX (which is a neighbor of the
%one with index  idxNBest) and returns the updated versions of  graphVector and 
%pqOpen.
function [local_graph,pqOpen] = buildstruct_graphexpandelement(local_graph,idxNbest,idxExpand,goal_vertices,pqOpen,Dir)


cost_nbest_x = norm(local_graph(idxExpand).vertex-local_graph(idxNbest).vertex); % cost from NBest to xX
g_nbest_x = cost_nbest_x+local_graph(idxNbest).g; % g is cost from nbest to x + g(nbest)


if ~priority_isMember(pqOpen,idxExpand) % if x is not already in the priority queue, add it
    local_graph(idxExpand).backpointer = idxNbest; % set the backpointer to xnbest
    local_graph(idxExpand).g = g_nbest_x; % set value of g
    f_x = local_graph(idxExpand).g + buildstruct_graphheuristic(local_graph,idxExpand,goal_vertices,Dir); % compute f
    pqOpen = priority_insert(pqOpen,idxExpand,f_x); % add x to the priority queue
elseif g_nbest_x < local_graph(idxExpand).g % if new g is lower than current g, update g and backpointer
    local_graph(idxExpand).g = g_nbest_x;
    local_graph(idxExpand).backpointer = idxNbest;
end


%This function corresponds to lines  it:expansion-start-- it:expansion-end in
%Algorithm  alg:astar.
