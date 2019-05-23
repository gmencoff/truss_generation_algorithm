function [] = buildstruct_plotworldandtruss(trusses,world,xGoal,xStart)
% Plot the world and the truss

[~,truss_num] = size(trusses);
polygonworld_draw(world,xGoal)
for iTruss = 1:truss_num
    buildstruct_trussdraw(trusses(iTruss).truss)
end

scatter(xStart(1),xStart(2),'g','filled')
scatter(xGoal(1),xGoal(2),'r','filled')
end

