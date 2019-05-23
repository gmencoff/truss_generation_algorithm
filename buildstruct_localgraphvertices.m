function [local_graph] = buildstruct_localgraphvertices(local_graph,world,node_spacing)
%puts all viable vertices in to the local graph. The spacing is assumed to
%be .5, althoug this can be altered.

[~,polygon_num] = size(world); %gets the number of polygons in the world
world_vertices = []; % initialize world vertices
vertex_num = 0; % initialize the number of vertices
 
%put all world vertices in to an array
for iPolygon = 1:polygon_num
    world_vertices = [world_vertices world(iPolygon).vertices];
end

% find the outer edges of the polygon world
max_x_vertex = max(world_vertices(1,:));
min_x_vertex = min(world_vertices(1,:));
max_y_vertex = max(world_vertices(2,:));
min_y_vertex = min(world_vertices(2,:));

% loop from the min point to the max point, inserting into the local graph
% if it does not collide with any polygon
for xPoint = min_x_vertex:node_spacing:max_x_vertex
   for yPoint = min_y_vertex:node_spacing:max_y_vertex
       isCollision = 0; % store whether point is in collision with a polyogon
       point = [xPoint;yPoint]; % if y point is on the bottom surface it should not be counted
       abovepoint = [xPoint;yPoint+node_spacing]; % if y point is on the bottom surface it should not be counted
       
       % check whether any collisions occur with the point or above the
       % point
       for iPolygon = 1:polygon_num
           isCollision = isCollision + polygon_isCollision(world(iPolygon).vertices,point) + polygon_isCollision(world(iPolygon).vertices,abovepoint);
       end
       
       % if no collision, add the point to the local graph
       if isCollision == 0
           vertex_num = vertex_num+1; % add 1 to vertex counter
           local_graph(vertex_num).index = vertex_num;
           local_graph(vertex_num).vertex = point;
       end
   end
end

end

