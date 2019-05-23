function [truss] = buildstruct_addtrussedges(truss,memberlength)
%Adds edges to the truss structure
[~,truss_size] = size(truss); % gets vertices in truss
vertices = []; % initialize vertices

% construct an array of vertices who indices will match truss indices
for iVertex = 1:truss_size
    vertices = [vertices truss(iVertex).vertex];
end

% look at each vertex, and find neighbors
for iVertex = 1:truss_size
    max_neighbor_distance = sqrt(2*memberlength^2); % get max distance
    neighbors = []; % initialize neighbors
    vertex = vertices(:,iVertex); % get current vertex
    
    %compare current vertex to each other vretex to see if it is a neighbor
    for iNeighbor = 1:truss_size
        difference = vertices(:,iNeighbor)-vertex;
        distance = norm(difference);
        
        %if distance is low enough, then this is a neighbor
        if distance == 0
            %do nothing, it is the current vertex
        elseif distance <= max_neighbor_distance
            neighbors = [neighbors iNeighbor];% add index to neighbors
        end
    end
    truss(iVertex).neighbors = neighbors; %add neighbors to truss struct
end

