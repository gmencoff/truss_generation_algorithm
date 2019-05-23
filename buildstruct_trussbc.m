function trusses = buildstruct_trussbc(world,trusses,memberlength)
%This function fills in the boundary condition field for each truss in
%trusses

%Boundary conditions on movement of vertex: 3 = no movement in x or y, 2 = no movement in y, 1 =
%no movement in x, 0 = no contraints

[~,truss_num] = size(trusses); % get the number of trusses
[~,polygon_num] = size(world); % get the size of the world

% For each truss, set boundary conditions of the vertices
for iTruss = 1:truss_num
    [~,vertex_num] = size(trusses(iTruss).truss); % get the number of vertices
    
    %For each vertex, check if it is on the edge of a polygon to determine
    %the boundary condition
    for iVertex = 1:vertex_num
        % if there is not already a boundary condition in place, set it
        if isempty(trusses(iTruss).truss(iVertex).boundary_condition)
            trusses(iTruss).truss(iVertex).boundary_condition = bcset(trusses(iTruss).truss(iVertex).vertex,world,memberlength);
        end
    end    
end

end

