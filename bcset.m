function bc = bcset(vertex,world,memberlength)
%Sets the boundary condition of the given vertex in the world

%Boundary conditions on movement of vertex: 3 = no movement in x or y, 2 = no movement in y, 1 =
%no movement in x, 0 = no contraints

distance_check = memberlength/2; %this is the distance from the vertex being checked to see if the vertex is on the surface
[~,polygon_num] = size(world); % get the number of polygons to check

v_above = [vertex(1);vertex(2)+distance_check];
v_below = [vertex(1);vertex(2)-distance_check];
v_right = [vertex(1)+distance_check;vertex(2)];
v_left = [vertex(1)-distance_check;vertex(2)];

isCollision_ver = 0; % store whether the vertex is on a vertical edge
isCollision_hor = 0; % store whether the vertex is on a horizontal edge

       
% check whether there is a horizontal or vertical collision
for iPolygon = 1:polygon_num
   isCollision_ver = isCollision_ver+polygon_isCollision(world(iPolygon).vertices,v_above)+polygon_isCollision(world(iPolygon).vertices,v_below);
   isCollision_hor = isCollision_hor+polygon_isCollision(world(iPolygon).vertices,v_right)+polygon_isCollision(world(iPolygon).vertices,v_left);
end

% set the boundary condition
if isCollision_ver > 0 && isCollision_hor > 0
    bc = 3;
elseif isCollision_hor > 0
    bc = 1;
elseif isCollision_ver > 0
    bc = 2;
else
    bc = 0;
end

end

