%function [pQueue]=hw1_priority_insert(pQueue,key,cost)
%Add an element to the queue.
function [pQueue]=priority_insert(pQueue,key,cost)
pQueue=[pQueue;struct('key',key,'cost',cost)];
