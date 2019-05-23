function [truss] = buildstruct_trussaddmembers(truss,world,member_length)
%this function takes a truss, and adds a row of members beneath it to
%strengthen the structure

truss = buildstruct_addtrussrow(truss,world,member_length); %add vertices beneath current ones that are not in contact with a stucture

trusses(1).truss = truss;

trusses = buildstruct_trussbc(world,trusses,member_length); % set the boundary conditions for the newly created truss

truss = trusses(1).truss;

truss = buildstruct_addtrussedges(truss,member_length); % add edges to the truss

end

