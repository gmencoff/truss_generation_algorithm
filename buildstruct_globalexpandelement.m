function [global_graph,pqOpen] = buildstruct_globalexpandelement(global_graph,idxNbest,idxExpand,pqOpen)
%Expands the input node

neighbor_index = global_graph(idxExpand).neighbor_indices == idxNbest;

cost_nbest_x = global_graph(idxExpand).neighbor_cost(neighbor_index); % cost from NBest to expand
g_nbest_x = cost_nbest_x+global_graph(idxNbest).g; % g is cost from nbest to x + g(nbest)

if ~priority_isMember(pqOpen,idxExpand) % if x is not already in the priority queue, add it
    global_graph(idxExpand).backpointer = idxNbest; % set the backpointer to xnbest
    global_graph(idxExpand).g = g_nbest_x; % set value of g
    f_x = global_graph(idxExpand).g + buildstruct_globalheuristic(global_graph,idxExpand); % compute f
    pqOpen = priority_insert(pqOpen,idxExpand,f_x); % add x to the priority queue
elseif g_nbest_x < global_graph(idxExpand).g % if new g is lower than current g, update g and backpointer
    global_graph(idxExpand).g = g_nbest_x;
    global_graph(idxExpand).backpointer = idxNbest;
end

end

