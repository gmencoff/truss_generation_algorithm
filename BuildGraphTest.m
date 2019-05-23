%% Global Graph Build Test

global_graph = buildstruct_globalinit();
global_graph = buildstruct_globalvertices(world,global_graph);


%% Local Graph Build Test

node_spacing = .5; % specifies how far apart graph vertices are
local_graph = buildstruct_localinit();
local_graph = buildstruct_localgraphvertices(local_graph,world,node_spacing);
local_graph = buildstruct_localedgebuild(local_graph,node_spacing);

local_graph_len = local_graph(end).index;
points = [];

for iVertex = 1:local_graph_len
   points = [points local_graph(iVertex).vertex]; 
end

polygonworld_draw(world,xGoal)
hold on

%plot vertices
scatter(points(1,:),points(2,:))

%draw lines between vertices and neighbors
for iVertex = 1:local_graph_len
   current_vertex = local_graph(iVertex).vertex;
   vertex_neighbors = local_graph(iVertex).neighbor_indices;
   
   % for each neighbor, plot a line between vertex and neighbor
   for iNeighbor = 1:length(vertex_neighbors)
       neighbor_vertex = local_graph(vertex_neighbors(iNeighbor)).vertex;
       plot([current_vertex(1) neighbor_vertex(1)],[current_vertex(2) neighbor_vertex(2)],'k')  
   end
end

%% Local Graph Search Test

surface_goal = global_graph(2).endpoints;
surface_start = global_graph(1).endpoints;
start_vertices = buildstruct_surfacevertices(surface_start,local_graph);
goal_vertices = buildstruct_surfacevertices(surface_goal,local_graph);

xPath = buildstruct_localsearch(local_graph,surface_start,surface_goal);

polygonworld_draw(world,xGoal)
hold on
plot(xPath(1,:),xPath(2,:))

%% Global Graph Build Test

[global_graph,xPaths] = buildstruct_globalgraphbuild(global_graph,local_graph,xGoal);

%% Global Search Test

start_surface_index = 1;

[truss_path] = buildstruct_globalsearch(global_graph,xPaths,start_surface_index);

[~,truss_num] = size(truss_path);

polygonworld_draw(world,xGoal)
hold on
for iTrussPath = 1:truss_num
    plot(truss_path(iTrussPath).xPath(1,:),truss_path(iTrussPath).xPath(2,:))
end

%% Generate Truss Path Test

member_length = .5;
xStart = [0;2];

[truss_path] = buildstruct_generatetrusspath(world,xGoal,xStart,member_length);

[~,truss_num] = size(truss_path);
polygonworld_draw(world,xGoal)
hold on
for iTrussPath = 1:truss_num
    plot(truss_path(iTrussPath).xPath(1,:),truss_path(iTrussPath).xPath(2,:),'k')
end

%% Build Truss Data Structure

xStart = [0;2];
member_length = .5;
[truss_path] = buildstruct_generatetrusspath(world,xGoal,xStart,member_length);

%% Build Truss Init
memberlength = .5;
[trusses] = buildstruct_trussinit(world,truss_path,member_length);

%% Build Truss Set BCs
[trusses] = buildstruct_trussbc(world,trusses,memberlength);

%% Build Truss Get New Joint Positions

[truss_elements] = buildstruct_trusselements(truss);
[stiffness_matrix] = buildstruct_trussstiffness(truss,truss_elements,Youngs,Area);
[truss_elements,truss] = buildstruct_trussstress(truss,truss_elements,stiffness_matrix,Force,Youngs);
[truss_is_stable] = buildstruct_trussstability(truss_elements,yield_stress);


%% Test Truss Stability Function

[truss_is_stable] = buildstruct_truss_is_stable(truss,Youngs,Area,RobotWeight,yield_stress);

%% Truss Stabalizer Test

[trusses] = buildstruct_trussstabalizer(trusses,world,robot_weight,yield_stress,Area,Youngs,memberlength);

%%

[0 0 0;
 1 1 1;
 3 3 3]

%% Test Truss Stability Function

RobotWeight = 1;
BreakingLoad = 1;

% Tis function tests whether the truss is stable
[is_stable,unstable_vertex] = buildstruct_trussstability(world,truss,RobotWeight,BreakingLoad);

polygonworld_draw(world,xGoal,[-2 3],[-1 3])
trusses.truss = truss;
buildstruct_trussdraw(trusses)

%% Test Truss Stability From Complicated World

xStart = [0;0];
member_length = .5;
[truss_path] = buildstruct_generatetrusspath(world,xGoal,xStart,member_length);
[trusses] = buildstruct_trussinit(world,truss_path,member_length);
RobotWeight = 1;
BreakingLoad = 1;

polygonworld_draw(world,xGoal,[-2 22],[-2 22])
buildstruct_trussdraw(trusses)

[~,truss_num] = size(trusses);
truss_stability = [];

for iTruss = 1:truss_num
   [is_stable,unstable_vertex] = buildstruct_trussstability(world,trusses(iTruss).truss,RobotWeight,BreakingLoad);
   truss_stability = [truss_stability is_stable];
end

%% Truss Add Members

%this function takes a truss, and adds a row of members beneath it to
%strengthen the structure


member_length = .5;
[truss] = buildstruct_trussaddmembers(trusses(3).truss,world,member_length);

polygonworld_draw(world,xGoal,[-2 22],[-2 22])
buildstruct_trussdraw(truss)

%% Truss Stabalizer

trusses = buildstruct_trussstabalizer(trusses,world,RobotWeight,BreakingLoad,member_length);

[~,truss_num] = size(trusses);

polygonworld_draw(world,xGoal,[-2 22],[-2 22])
for iTruss = 1:truss_num
    buildstruct_trussdraw(trusses(iTruss).truss)
end

%% Final Algorithm Implementation

trusses = buildstruct_trussgenerator(world,xGoal,xStart,RobotWeight,BreakingLoad,member_length);

[~,truss_num] = size(trusses);
polygonworld_draw(world,xGoal,[-2 22],[-2 22])
for iTruss = 1:truss_num
    buildstruct_trussdraw(trusses(iTruss).truss)
end