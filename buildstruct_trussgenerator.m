function [path_trusses] = buildstruct_trussgenerator(world,xGoal,xStart,RobotWeight,YieldStress,Area,Youngs,member_length)
%This function combines all of the functions previously created functions
%to generate truss structures based on the world, the end goal, the robot
%weight, the breaking load of a truss member and the truss member length


% Get the global graph, all paths, and start point
[global_graph,xPaths,start_surface_index] = buildstruct_generatetrusspath(world,xGoal,xStart,member_length);

% Generate trusses for all possible xPaths
[trusses] = buildstruct_trussinit(world,xPaths,member_length);

% for each truss, check stability and add members to make the truss strong
% enough to support the robot
[trusses] = buildstruct_trussstabalizer(trusses,world,RobotWeight,YieldStress,Area,Youngs,member_length);

% for each truss, fill in the cost in the global_graph
[global_graph] = buildstruct_globalcost(global_graph,trusses);

% Generate optimal truss path based on global_graph
[global_path] = buildstruct_globalsearch(global_graph,start_surface_index);

% get the final trusses from this optimal truss path
path_trusses = buildstruct_pathtrusses(trusses,global_path);

end

