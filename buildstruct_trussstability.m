function [truss_is_stable] = buildstruct_trussstability(truss_elements,yield_stress)
% Determines whether truss is stable, returns true or false
[~,element_num] = size(truss_elements);

% if the stress on an element is greater than the yield stress, the truss
% is not stable
for iElement = 1:element_num
    if truss_elements(iElement).stress < -yield_stress
       truss_is_stable = false;
       return
    end
end

truss_is_stable = true;

end

