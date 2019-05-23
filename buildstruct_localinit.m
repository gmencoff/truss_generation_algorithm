function [local_graph] = buildstruct_localinit()
%Initializes the local_graph structure

local_graph = struct('index',[],'vertex',[],'neighbor_indices',[],'neighbor_cost',[],'backpointer',[],'g',[]);

end

