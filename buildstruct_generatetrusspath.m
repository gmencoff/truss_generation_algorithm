function [global_graph,xPaths,start_surface_index] = buildstruct_generatetrusspath(world,xGoal,xStart,member_length)
%This function takes the world, start and end points and member length as
%inputs and generates the optimal truss path


% initialize the global graph
global_graph = buildstruct_globalinit();
global_graph = buildstruct_globalvertices(world,global_graph);

% initialize the local graph
local_graph = buildstruct_localinit();
local_graph = buildstruct_localgraphvertices(local_graph,world,member_length);
local_graph = buildstruct_localedgebuild(local_graph,member_length);

% Generate paths and global neighbor costs by searching the local graph
[global_graph,xPaths] = buildstruct_globalgraphbuild(global_graph,local_graph,xGoal);

% generate the start surface index
[~,surface_num] = size(global_graph);
xStartx = xStart(1); %start x coordinate
xStarty = xStart(2); %start y coordinate
start_surface_index = [];
for iSurface = 1:surface_num
    surfacey = global_graph(iSurface).endpoints(2,1);
    surfacex1 = global_graph(iSurface).endpoints(1,1);
    surfacex2 = global_graph(iSurface).endpoints(1,2);
    if (xStarty == surfacey) && (xStartx <= surfacex1 && xStartx >=surfacex2)
       start_surface_index = iSurface; 
    end
end

% if no start surface is assigned, throw an error
if isempty(start_surface_index)
   error('The start location must be on one of the traversible surfaces')
end

end

