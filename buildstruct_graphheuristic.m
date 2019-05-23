%function [h]=graph_heuristic(graphVector,idxX,idxGoal)
%Computes the heuristic  h given by the Euclidean distance between the
%vertex and the shortest distance goal vertex with an angle <45
function [h] = buildstruct_graphheuristic(local_graph,idx,goal_vertices,Dir)
xX = local_graph(idx).vertex; % get current vertex

% get the goal vertices to the right and left of the point
right_goal_location = find(goal_vertices(1,:) >= xX(1));
left_goal_location = find(goal_vertices(1,:) <= xX(1));

if Dir == 'R'
    goal_points = zeros(2,length(right_goal_location));
    for iGoalPoint = 1:length(right_goal_location)
        goal_points(:,iGoalPoint) = goal_vertices(:,right_goal_location(iGoalPoint));
    end
elseif Dir == 'L'
    goal_points = zeros(2,length(left_goal_location));
    for iGoalPoint = 1:length(left_goal_location)
        goal_points(:,iGoalPoint) = goal_vertices(:,left_goal_location(iGoalPoint));
    end
end

% look at each goal vertex, add a magnitude and angle to the heuristic
% matrix

h = [];
[~,num_goal_points] = size(goal_points);% get number of goal points
nearest_goal = []; % store the best goal point
greatest_angle = 0;

% look through goal points, find the goal point with the max allowable angle
for iGoalVertex = 1:num_goal_points
   difference_vector = goal_points(:,iGoalVertex)-xX;
   angle = abs(atan(difference_vector(2)/difference_vector(1))/2/pi*360); % angle between point and goal point

   % check if this is the best allowable angle, set nearest goal to current
   % point if so
   if angle >= greatest_angle && angle <= 45
       greatest_angle = angle;
       nearest_goal = goal_points(:,iGoalVertex);
   end
end

% if nearest_goal is empty, set value to infinity, else calculate the value
% of h
if isempty(nearest_goal)
   h = Inf; 
else
   difference_vector = nearest_goal-xX;
   dy = abs(difference_vector(2));
   dx = abs(difference_vector(1));
   h = sqrt(2*dy^2)+dx-dy;
end


end