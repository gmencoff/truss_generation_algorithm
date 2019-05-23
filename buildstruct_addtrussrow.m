function [truss] = buildstruct_addtrussrow(truss,world,member_length)
%This function adds another row to the truss beneath the current row,
%making sure that the vertex is not in collision with the world

[~,vertices_num] = size(truss); % gets number of vertices
[~,polygon_num] = size(world); % get the number of polygons in the world
new_truss = struct('vertex',[],'neighbors',[],'boundary_condition',[],'vertex_after_shift',[]); %initialize the new truss
vertices = []; %this stores all vertices
lower_vertices = []; % this stores all lower vertices

%build a matrix of all of the vertices
for iVertex = 1:vertices_num
    vertices = [vertices truss(iVertex).vertex];
end

% for each vertex - add to the new struct, check if it is the lowest
% vertex, if it is add a vertex beneath to the struct as well if that
% vertex is not in contact with the world
for iVertex = 1:vertices_num
   new_truss(iVertex).vertex = vertices(:,iVertex); % add to the new struct
   new_truss(iVertex).boundary_condition = truss(iVertex).boundary_condition; % keep all of the boundary conditions
   
   same_x_val = find(vertices(1,:) == vertices(1,iVertex)); % finds location of vertices with the same x val
   low_vertex = 0; %stores whehter current vertex is the low vertex
   
   for iSameX = 1:length(same_x_val)
      shared_x_vertex = same_x_val(iSameX); % gets the vertex number of the vertex with the same x val
      
      %if the y val if the other vertex is less than the y value of the
      %current vertex, add 1 to the low_vertex val for comparison
      if vertices(2,iVertex) > vertices(2,shared_x_vertex)
         low_vertex = low_vertex+1; 
      end
   end
   
   %if low vertex is 0, then the current vertex is the lowest and a vertex
   %should be add beneath if it does not interect with the world
   if low_vertex == 0
      beneath_vertex = vertices(:,iVertex) - [0;member_length];
      isCollision = 0; % store whether point is in collision with a polyogon

      % check whether any collisions occur between the lower vertex and the
      % world, if not add the lower vertex to the list of lower vertices
      for iPolygon = 1:polygon_num
          isCollision = isCollision + polygon_isCollision(world(iPolygon).vertices,beneath_vertex);
      end
      if isCollision ==  0
         lower_vertices = [lower_vertices beneath_vertex]; % add to the truss struct
      end
   end
end

% For each new vertex, add it to the truss struct
[~,newvertices_num] = size(lower_vertices);

for iNewVertex = 1:newvertices_num
   new_truss(vertices_num+iNewVertex).vertex = lower_vertices(:,iNewVertex);
end

truss = new_truss;

end

