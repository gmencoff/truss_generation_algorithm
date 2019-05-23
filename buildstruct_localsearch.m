function [xPath] = buildstruct_localsearch(local_graph,surface_start,surface_goal)
%This function searches the shortest path on the local graph between 2
%surfaces, where no direction change is allowed if off the surface and the
%cost to travel along a surface is 0. A path is returned

% initialize a left graph and a right graph
local_graph_right = local_graph;
local_graph_left = local_graph;

% get all of the graph vertices on the start surface and end surface
start_vertices = buildstruct_surfacevertices(surface_start,local_graph);
goal_vertices = buildstruct_surfacevertices(surface_goal,local_graph);

% initialize pqOpenRight and pqOpen left
pqOpenRight = priority_prepare(); % initialize pqOpen
pqOpenLeft = priority_prepare(); % initialize pqOpen
idxClosedRight = []; % initialize qclosed
idxClosedLeft = []; % initialize qclosed

correct_dir = []; % initialize direction variable

% add all surface points to pqOpenRight and pqOpenLeft, and add the cost in
% local_graph_right and local_graph_left
for iSurfaceVertex = 1:length(start_vertices)
    vertex_index = buildstruct_getvertexindex(start_vertices(:,iSurfaceVertex),local_graph);
    local_graph_right(vertex_index).g = 0;
    local_graph_left(vertex_index).g = 0;
    pqOpenRight = priority_insert(pqOpenRight,vertex_index,buildstruct_graphheuristic(local_graph_right,vertex_index,goal_vertices,'R'));
    pqOpenLeft = priority_insert(pqOpenLeft,vertex_index,buildstruct_graphheuristic(local_graph_left,vertex_index,goal_vertices,'L'));
end

% run A* until you reach the goal surface or pqOpen is empty, expanding
% either the right or the left depending on which has a smaller cost
% function
while ~isempty(pqOpenRight) || ~isempty(pqOpenLeft)
     if ~isempty(pqOpenRight) && ~isempty(pqOpenLeft)
         [pqOpenRight,Rightkey,Rightcost] = priority_minExtract(pqOpenRight);
         [pqOpenLeft,Leftkey,Leftcost] = priority_minExtract(pqOpenLeft);
     elseif ~isempty(pqOpenRight)
         [pqOpenRight,Rightkey,Rightcost] = priority_minExtract(pqOpenRight);
     elseif ~isempty(pqOpenLeft)
         [pqOpenLeft,Leftkey,Leftcost] = priority_minExtract(pqOpenLeft);
     end
         
     
     % check which node had the lower cost, and repair the higher cost queue, then
     % expand the lower cost node
     if Rightcost == Inf && Leftcost == Inf
         xPath = NaN;
         return
     elseif (isempty(Leftcost) && ~isempty(Rightcost)) || Rightcost <= Leftcost
         
        % check whether this is a goal node
        if find((goal_vertices(1,:) == local_graph_right(Rightkey).vertex(1))+(goal_vertices(2,:) == local_graph_right(Rightkey).vertex(2))==2) > 0 % if the expanded point is on the goal surface, stop
            correct_dir = 'R';
            idxGoal = Rightkey;
            break
        end
        
        
        pqOpenLeft = priority_insert(pqOpenLeft,Leftkey,Leftcost); % repair pqOpenLeft
        idxClosedRight = [idxClosedRight Rightkey]; % add current_node to qClosed
        idxExpand = buildstruct_getexpandlist(local_graph_right,Rightkey,idxClosedRight,'R'); % get list of neighbors to the right

        for idx = 1:length(idxExpand) % expand each neighbor
            [local_graph_right,pqOpenRight] = buildstruct_graphexpandelement(local_graph_right,Rightkey,idxExpand(idx),goal_vertices,pqOpenRight,'R');
        end

        
     elseif (~isempty(Leftcost) && isempty(Rightcost)) || Leftcost < Rightcost
        % check whether this is a goal node 
        if find((goal_vertices(1,:) == local_graph_right(Leftkey).vertex(1))+(goal_vertices(2,:) == local_graph_right(Leftkey).vertex(2))==2)>0 % if the expanded point is on the goal surface, stop
            correct_dir = 'L';
            idxGoal = Leftkey;
            break
        end
        
        pqOpenRight = priority_insert(pqOpenRight,Rightkey,Rightcost); % repair pqOpenLeft
        idxClosedLeft = [idxClosedLeft Leftkey]; % add current_node to qClosed
        idxExpand = buildstruct_getexpandlist(local_graph_left,Leftkey,idxClosedLeft,'L'); % get list of neighbors to the right

        for idx = 1:length(idxExpand) % expand each neighbor
            [local_graph_left,pqOpenLeft] = buildstruct_graphexpandelement(local_graph_left,Leftkey,idxExpand(idx),goal_vertices,pqOpenLeft,'L');
        end

     end
     
end

% once a path is found, follow backpointers from the goal vertices to the
% start
if correct_dir == 'R'
    xPath = buildstruct_graphpath(local_graph_right,start_vertices,idxGoal);
elseif correct_dir == 'L'
    xPath = buildstruct_graphpath(local_graph_left,start_vertices,idxGoal);
else
    xPath = NaN;
end

