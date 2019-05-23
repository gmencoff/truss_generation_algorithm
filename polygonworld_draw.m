%function polygonworld_draw(world,xGoal)
%Uses polygon_draw from Homework 1 to draw the polygonal obstacles together with
%a  * marker at the goal location.
function polygonworld_draw(world,xGoal)

[~,world_size] = size(world); % get the size of the world

% get the edges of the plot

xsize = [0 0];
ysize = [0 0];

for i = 1:length(world)
    xmax = max(world(i).vertices(1,:));
    ymax = max(world(i).vertices(2,:));
    xmin = min(world(i).vertices(1,:));
    ymin = min(world(i).vertices(2,:));
    if xmax > xsize(2)
       xsize(2) = xmax; 
    end
    if xmin < xsize(1)
       xsize(1) = xmin; 
    end
    if ymax > ysize(2)
       ysize(2) = ymax; 
    end
    if ymin < ysize(1)
       ysize(1) = ymin; 
    end
end

figure(1)
xlim(xsize)
ylim(ysize)
hold on


for iPolygon = 1:world_size % plot each polygon
   polygon_plot(world(iPolygon).vertices,'k')
end

scatter(xGoal(1),xGoal(2),'*') % plot end goal

