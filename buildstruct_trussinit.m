function [trusses] = buildstruct_trussinit(world,truss_path,memberlength)
%Makes an initial construction based on each path in trusspath

[~,truss_num] = size(truss_path); % get the number of trusses to build
[~,polygon_num] = size(world); % get the size of the world
trusses = struct('truss',[],'global_vertex_1',[],'global_vertex_2',[]);
trusses_inserted = 1;

for iTruss = 1:truss_num
   trusses(trusses_inserted).global_vertex_1 = truss_path(iTruss).start_index; % set the global vertices
   trusses(trusses_inserted).global_vertex_2 = truss_path(iTruss).end_index;
   truss = struct('vertex',[],'neighbors',[],'boundary_condition',[],'vertex_after_shift',[]);
   current_truss = truss_path(iTruss).xPath; % gets the current trusspath
   
   % checks to see if there is a path, then adds the truss if there is
   if ~isnan(current_truss)

       [~,trusspath_vertices] = size(current_truss); % gets the initial number of trusspath vertices

       % for each vertex, add the vertex below to current truss and the truss struct if there is no collision with
       % the world
       for iVertex = 1:trusspath_vertices
          if iVertex == 1
              truss(end).vertex = current_truss(:,1); % add vertex to truss struct
              truss(end).boundary_condition = 3; % first vertex is a pin joint
          elseif iVertex == trusspath_vertices
              truss(end+1).vertex = current_truss(:,iVertex); % add vertex to truss struct
              truss(end).boundary_condition = 3; % last vertex is a pin point
          else
              truss(end+1).vertex = current_truss(:,iVertex); % add vertex to truss struct
          end

          lower_vertex = current_truss(:,iVertex) - [0;memberlength]; % get the vertex below current one
          isCollision = 0; % store whether point is in collision with a polyogon

          % check whether any collisions occur between the lower vertex and the
          % world
          for iPolygon = 1:polygon_num
              isCollision = isCollision + polygon_isCollision(world(iPolygon).vertices,lower_vertex);
          end
          if isCollision ==  0
             current_truss = [current_truss lower_vertex]; % add to current_truss
             truss(end+1).vertex = lower_vertex; % add to the truss struct
          end
       end

       truss = buildstruct_addtrussedges(truss,memberlength);
       
       %add truss struct to trusses
       trusses(trusses_inserted).truss = truss;
       trusses_inserted = trusses_inserted+1;
   end
   
end

[trusses] = buildstruct_trussbc(world,trusses,memberlength); % generate truss bcs

end

