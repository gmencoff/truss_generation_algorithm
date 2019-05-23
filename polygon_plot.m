%function hw1_polygon_plot(vertices,style)
%Draws a closed polygon described by  vertices using the style (e.g., color)
%given by  style.
function polygon_plot(vertices,style,indexes)
c_num=size(vertices,2);%memory allocation to store the row number and column number of input vertices.
destVertices=zeros(size(vertices));%memory allocation to store subsequent vertices.

destVertices(:,c_num)=vertices(:,1);%assign the first column vector of vertices to the last column of tempVM.
destVertices(:,1:c_num-1)=vertices(:,2:c_num);%assign the values from the 2nd column to the last column of vertices
                                        %to the values from the first
                                        %column to the second last column of tempVM .
distVec=destVertices-vertices;%calculate the displacement vectors.

figure(1)
quiver(vertices(1,:),vertices(2,:),distVec(1,:),distVec(2,:),0,style);%plot the polygon with indicating output direction.

if polygon_isFilled(vertices)
    patch(vertices(1,:),vertices(2,:),[.6 .6 .6]);
else
    set(gca,'color',[.6 .6 .6]);
    patch(vertices(1,:),vertices(2,:),[1 1 1])
end

%if passed, add indexes corresponding to each vertex
if exist('indexes','var')
    for iVertex=1:c_num
        text(vertices(1,iVertex),vertices(2,iVertex),num2str(indexes(iVertex)),'EdgeColor','k')
    end
end
