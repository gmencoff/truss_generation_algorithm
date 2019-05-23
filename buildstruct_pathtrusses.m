function path_trusses = buildstruct_pathtrusses(trusses,global_path)
%Pull out the trusses needed to form the path for the robot

path_trusses = struct('truss',[]);
[~,total_trusses] = size(trusses);
truss_num = length(global_path);
truss_pairs = zeros(total_trusses,2);

% put start and end pairs into an array
for iTruss = 1:total_trusses
    truss_pairs(iTruss,1) = trusses(iTruss).global_vertex_1;
    truss_pairs(iTruss,2) = trusses(iTruss).global_vertex_2;
end

% find each truss that must be included
for iTruss = truss_num-1:-1:1
    start = global_path(iTruss);
    finish = global_path(iTruss+1);
    
    find_truss = (truss_pairs == start) + (truss_pairs == finish);
    find_truss = find_truss(:,1) + find_truss(:,2);
    truss_index = find(find_truss' == 2);
    
    path_trusses(iTruss).truss = trusses(truss_index).truss;
end

end

