function [stability_matrix] = buildstruct_stabilitymatrixexternalforces(stability_matrix,world,truss);
%Adds additional external forces to the stability matrix if the vertex is
%on a surface

[~,polygon_num] = size(world); % get the number of stuctures in the world
[~,truss_vertices] = size(truss); % get the number of vertices in the truss

% for each truss vertex (other than the first), check if it is on a polygon surface. If it is, add
% an external force to the stability matrix
for iTrussVertex = 2:truss_vertices
    TrussVertexX = truss(iTrussVertex).vertex(1);
    TrussVertexY = truss(iTrussVertex).vertex(2);
    % loop through each polygon
    for iPolygon = 1:polygon_num
       [~,vertices_num] = size(world(iPolygon).vertices); % get the number of vertices in the world
       
       % for each polygon, loop through each vertex to look at every
       % surface
       for iPolygonVertex = 1:vertices_num
           % add an external force to the stability matrix if a point is on
           % the surface
           
           % get both surface vertex coordinates
           if iPolygonVertex == vertices_num
               PolygonVertex1X = world(iPolygon).vertices(1,iPolygonVertex);
               PolygonVertex2X = world(iPolygon).vertices(1,1);
               PolygonVertex1Y = world(iPolygon).vertices(2,iPolygonVertex);
               PolygonVertex2Y = world(iPolygon).vertices(2,1);
           else
               PolygonVertex1X = world(iPolygon).vertices(1,iPolygonVertex);
               PolygonVertex2X = world(iPolygon).vertices(1,iPolygonVertex+1);
               PolygonVertex1Y = world(iPolygon).vertices(2,iPolygonVertex);
               PolygonVertex2Y = world(iPolygon).vertices(2,iPolygonVertex+1);
           end
           
           
           % check whether the truss vertex is on the surface, add an
           % appropriately signed force to the stability matrix
           if (TrussVertexX == PolygonVertex1X && TrussVertexX == PolygonVertex2X) && (TrussVertexY <= PolygonVertex1Y && TrussVertexY >= PolygonVertex2Y)
           % if truss vertex x is equal to both surface x vertices and
           % truss vertex y is less then truss vertex 1y greater than truss
           % vertex 2 y, add a negative x external force
           
               stability_matrix(:,end+1) = 0; % add an external force to the stability matrix
               stability_matrix(iTrussVertex,end) = -1; % add negative external x force to correct vertex
           end
           
           if (TrussVertexX == PolygonVertex1X && TrussVertexX == PolygonVertex2X) && (TrussVertexY >= PolygonVertex1Y && TrussVertexY <= PolygonVertex2Y)
           % if truss vertex x is equal to both surface x vertices and
           % truss vertex y is less then truss vertex 2y greater than truss
           % vertex 1y, add a positive x external force         
           
               stability_matrix(:,end+1) = 0; % add an external force to the stability matrix
               stability_matrix(iTrussVertex,end) = 1; % add positive external x force to correct vertex
           end
           
           if (TrussVertexY == PolygonVertex1Y && TrussVertexY == PolygonVertex2Y) && (TrussVertexX >= PolygonVertex1X && TrussVertexX <= PolygonVertex2X)
           % if truss vertex y is equal to both surface y vertices and
           % truss vertex x is less then truss vertex 2x greater than truss
           % vertex 1x, add a negative y external force  
              
               stability_matrix(:,end+1) = 0; % add an external force to the stability matrix
               stability_matrix(truss_vertices+iTrussVertex,end) = -1; % add positive external x force to correct vertex
           
           end
           
           if (TrussVertexY == PolygonVertex1Y && TrussVertexY == PolygonVertex2Y) && (TrussVertexX <= PolygonVertex1X && TrussVertexX >= PolygonVertex2X)
           % if truss vertex y is equal to both surface y vertices and
           % truss vertex x is less then truss vertex 1x greater than truss
           % vertex 2x, add a positive x external force 
               
               stability_matrix(:,end+1) = 0; % add an external force to the stability matrix
               stability_matrix(truss_vertices+iTrussVertex,end) = 1; % add positive external x force to correct vertex
               
           end
       end
    end
end

end

