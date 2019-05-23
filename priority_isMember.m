%function [flag]=hw1_priority_isMember(pQueue,key)
%Check whether an element with a given key is in the queue or not.
function [flag]=priority_isMember(pQueue,key)
%Remember that the  key argument could be a number, a vector of numbers, a
%string, or any other arbitrary type. As such, you should use the Matlab function
%isequal to check for equality between keys (this function works for arbitrary
%types of variables, run  doc isequal on the Matlab prompt for details).
dataNum=length(pQueue);%get record number.
flag=false;%initialize the flag.

if dataNum==0%if the given queue is empty, return false.
    return;
end

for index=1:dataNum
    %search the target data
    if isequal(key,pQueue(index).key)
        flag=true;
    end
end
