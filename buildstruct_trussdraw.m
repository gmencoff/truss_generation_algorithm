function [] = buildstruct_trussdraw(truss)
%Draws a truss struct

hold on
[~,vertices_num] = size(truss);
for iVertices = 1:vertices_num
    vertex = truss(iVertices).vertex;
    neighbor_num = length(truss(iVertices).neighbors);

    % plot the pin of the truss
   scatter(vertex(1),vertex(2),5,'k')

   % plot each member
   for iNeighbor = 1:neighbor_num
      neighbor_index = truss(iVertices).neighbors(iNeighbor);
      neighbor_vertex = truss(neighbor_index).vertex;
      plot([vertex(1) neighbor_vertex(1)],[vertex(2) neighbor_vertex(2)],'k')
   end
end
end

