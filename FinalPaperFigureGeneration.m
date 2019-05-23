%% Figure 1a: A Simple World Without a Solution

clear
load('polygonWorldSimple.mat')

polygonworld_draw(world,xGoal)
hold on
scatter(xStart(1),xStart(2),'g','filled')
scatter(xGoal(1),xGoal(2),'r','filled')

%% Figure 2: Illustration of the Different Paths That a Robot Could Take

clear
load('polygonWorldSimple.mat')
polygonworld_draw(world,xGoal)
plot([1 3],[2 0],'g')
plot([7 9],[0 2],'g')
plot([1 9],[2 2],'r')
scatter(xStart(1),xStart(2),'g','filled')
scatter(xGoal(1),xGoal(2),'r','filled')

%% Figure 3a: Visual Representation of the Global Graphs

clear
load('polygonWorldSimple.mat')
polygonworld_draw(world,xGoal)
scatter(.5,2,200,'b','filled')
scatter(5,0,200,'b','filled')
scatter(9.5,2,200,'b','filled')
plot([.5 5],[2 0],'b')
plot([.5 9.5],[2 2],'b')
plot([5 9.5],[0 2],'b')

%% Figure 3b: Visual Representation of the Local Graph

clear
load('polygonWorldSimple.mat')
local_graph = buildstruct_localinit();
local_graph = buildstruct_localgraphvertices(local_graph,world,member_length);
local_graph = buildstruct_localedgebuild(local_graph,member_length);

local_graph_len = local_graph(end).index;
points = [];

for iVertex = 1:local_graph_len
   points = [points local_graph(iVertex).vertex]; 
end

polygonworld_draw(world,xGoal)
hold on

%plot vertices
scatter(points(1,:),points(2,:),10,'b','filled')

%draw lines between vertices and neighbors
for iVertex = 1:local_graph_len
   current_vertex = local_graph(iVertex).vertex;
   vertex_neighbors = local_graph(iVertex).neighbor_indices;
   
   % for each neighbor, plot a line between vertex and neighbor
   for iNeighbor = 1:length(vertex_neighbors)
       neighbor_vertex = local_graph(vertex_neighbors(iNeighbor)).vertex;
       plot([current_vertex(1) neighbor_vertex(1)],[current_vertex(2) neighbor_vertex(2)],'b')  
   end
end

%% 4: Visual Representation of The Paths Between Surfaces on The Global Graph

clear
load('polygonWorldComplicated.mat')
local_graph = buildstruct_localinit();
local_graph = buildstruct_localgraphvertices(local_graph,world,member_length);
local_graph = buildstruct_localedgebuild(local_graph,member_length);

global_graph = buildstruct_globalinit();
global_graph = buildstruct_globalvertices(world,global_graph);
[global_graph,xPaths] = buildstruct_globalgraphbuild(global_graph,local_graph,xGoal);

polygonworld_draw(world,xGoal)
hold on
[~,paths] = size(xPaths);
for iPaths = 1:paths
    path = xPaths(iPaths).xPath;
    if ~isnan(path)
        plot(path(1,:),path(2,:),'b')
    end
end

%% Figure 5: Optimal Path in the Complicated World

clear
load('polygonWorldComplicated.mat')
local_graph = buildstruct_localinit();
local_graph = buildstruct_localgraphvertices(local_graph,world,member_length);
local_graph = buildstruct_localedgebuild(local_graph,member_length);

global_graph = buildstruct_globalinit();
global_graph = buildstruct_globalvertices(world,global_graph);
[global_graph,xPaths] = buildstruct_globalgraphbuild(global_graph,local_graph,xGoal);
[truss_path] = buildstruct_globalsearch(global_graph,xPaths,1);

[~,truss_num] = size(truss_path);

polygonworld_draw(world,xGoal)
hold on
for iTrussPath = 1:truss_num
    plot(truss_path(iTrussPath).xPath(1,:),truss_path(iTrussPath).xPath(2,:),'b')
end

scatter(xStart(1),xStart(2),'g','filled')
scatter(xGoal(1),xGoal(2),'r','filled')

%% Figure 6: Truss Generation

clear
load('polygonWorldTest1.mat')
[trusses] = buildstruct_trussgenerator(world,xGoal,xStart,RobotWeight,YieldStress,Area,Youngs,member_length);

[~,truss_num] = size(trusses);
polygonworld_draw(world,xGoal)
for iTruss = 1:truss_num
    buildstruct_trussdraw(trusses(iTruss).truss)
end

%% Figure 7: An illustrative truss

clear
load('trussSimple.mat')
polygonworld_draw(world,xGoal,[-.25 1.5],[-.25 1.5])
buildstruct_trussdraw(truss)

%% Figure 9a: Test environment 1 No Truss

clear
load('polygonWorldTest1.mat')
polygonworld_draw(world,xGoal)
scatter(xStart(1),xStart(2),'g','filled')
scatter(xGoal(1),xGoal(2),'r','filled')

%% Figure 10a: Test environment 1 Truss

clear
load('polygonWorldTest1.mat')
[trusses] = buildstruct_trussgenerator(world,xGoal,xStart,RobotWeight,YieldStress,Area,Youngs,member_length);
buildstruct_plotworldandtruss(trusses,world,xGoal,xStart)

%% Figure 9b: Test Environment 2 No Truss

clear
load('polygonWorldTest2.mat')
polygonworld_draw(world,xGoal)
scatter(xStart(1),xStart(2),'g','filled')
scatter(xGoal(1),xGoal(2),'r','filled')

%% Figure 10b: Test Environment 2 Truss

clear
load('polygonWorldTest2.mat')
[trusses] = buildstruct_trussgenerator(world,xGoal,xStart,RobotWeight,YieldStress,Area,Youngs,member_length);
buildstruct_plotworldandtruss(trusses,world,xGoal,xStart)

%% Figure 9c: Test Environment 3 No Truss
clear
load('polygonWorldTest3.mat')
polygonworld_draw(world,xGoal)
scatter(xStart(1),xStart(2),'g','filled')
scatter(xGoal(1),xGoal(2),'r','filled')

%% Figure 10c: Test Environment 3 Truss

clear
load('polygonWorldTest3.mat')
[trusses] = buildstruct_trussgenerator(world,xGoal,xStart,RobotWeight,YieldStress,Area,Youngs,member_length);
buildstruct_plotworldandtruss(trusses,world,xGoal,xStart)