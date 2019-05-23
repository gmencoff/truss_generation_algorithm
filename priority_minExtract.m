%function [pQueue,key,cost]=hw1_priority_minExtract(pQueue)
%Extract the element with minimum cost from the queue.
function [pQueue,key,cost]=priority_minExtract(pQueue)
if isempty(pQueue)
    key=[];
    cost=[];
else
    %get all costs in the same vector
    allCosts=[pQueue.cost];
    %get index of minimum (note that it is always a single index even in the
    %case of ties)
    [~,idxMin]=min(allCosts);

    %prepare output
    key=pQueue(idxMin).key;
    cost=pQueue(idxMin).cost;
    pQueue(idxMin)=[];
end
