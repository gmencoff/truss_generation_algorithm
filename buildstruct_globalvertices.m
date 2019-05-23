function [global_graph] = buildstruct_globalvertices(world,global_graph)
%This function puts the vertices of each traversible surface in to the
%global graph and marks one as the goal node or creates a final vertex for
%the goal node
[~,polygon_num] = size(world); % get the number of polygons in the world
vertex_count = 0; %initialize a counter that will keep track of vertices

% iterate through each vertex pair in the polygon to see if it is a
% traversible surface, if it is add the endpoints to the global graph
for iPolygon = 1:polygon_num
    [~,vertices_num] = size(world(iPolygon).vertices); % get number of vertices in current polygon
    
    for iVertex = 1:vertices_num
       current_vertex = world(iPolygon).vertices(:,iVertex); % get the current vertex 
       %get the next vertex
       if iVertex == vertices_num
           next_vertex = world(iPolygon).vertices(:,1);
       else
           next_vertex = world(iPolygon).vertices(:,iVertex+1);
       end
       
       % if the current vertex y is equal to next vertex y, and current
       % vertex x is greater than next vertex x, this is a traversible
       % surface
       if and(current_vertex(2) == next_vertex(2),current_vertex(1) > next_vertex(1))
           vertex_count = vertex_count + 1;
           global_graph(vertex_count).index = vertex_count;
           global_graph(vertex_count).endpoints = [current_vertex next_vertex];
       end
    end
end

end

