%function [flagPoints]=hw2_polygon_isVisible(vertices,indexVertex,testPoints)
%Checks whether a point $p$ is visible from a vertex $v$ of a polygon. In order
%to be visible, two conditions need to be satisfied: enumerate  point $p$ should
%not be self-occluded with respect to the vertex $v$\\ (see
%hw2_polygon_isSelfOccluded).  segment $p$--$v$ should not collide with  any of the
%edges of the polygon (see hw2_edge_isCollision). enumerate

function [flagPoints]=hw2_polygon_isVisible(vertices,indexVertex,testPoints)
fill=hw2_polygon_isFilled(vertices);
vertices_temp=[vertices(:,size(vertices,2)),vertices,vertices(:,1)];
piso=zeros(1,size(testPoints,2));
eic=zeros(1,size(vertices,2));
flagPoints=zeros(1,size(testPoints,2));

for iPoint=1:size(testPoints,2)
    
    piso(iPoint)=hw2_polygon_isSelfOccluded(vertices_temp(:,indexVertex+1),vertices_temp(:,indexVertex),vertices_temp(:,indexVertex+2),testPoints(:,iPoint));
    for iVert=1:size(vertices,2)
        eic(iVert)=hw2_edge_isCollision([testPoints(:,iPoint),vertices(:,indexVertex)],[vertices_temp(:,iVert+1),vertices_temp(:,iVert+2)],fill);
    end
    
    
       

    %eic
    %piso(i),sum(eic)
    flagPoints(iPoint)=piso(iPoint)>0||sum(eic)>0;
end




%Note that, with the definitions of edge collision and self-occlusion given in
%the previous questions, a vertex should be visible from the previous and
%following vertices in the polygon.
