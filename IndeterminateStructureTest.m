 q = .707;

C = [1 q 0 0 0 0 0 1 0 0 0 0;
     0 q 0 0 0 0 0 0 1 0 0 0;
     -1 0 0 q 0 0 0 0 0 0 0 0;
     0 0 1 q 0 0 0 0 0 1 0 0;
     0 -q 0 0 1 q 0 0 0 0 0 0;
     0 -q -1 0 0 q 0 0 0 0 0 0;
     0 0 0 -q -1 0 0 0 0 0 1 0;
     0 0 0 -q 0 0 1 0 0 0 0 0;
     0 0 0 0 0 -q 0 0 0 0 0 1;
     0 0 0 0 0 -q -1 0 0 0 0 0];
     

d = [0;0;0;0;0;0;0;0;0;0];

A = [1 0 0 0 0 0 0 0 0 0 0 0;
     0 1 0 0 0 0 0 0 0 0 0 0;
     0 0 1 0 0 0 0 0 0 0 0 0;
     0 0 0 1 0 0 0 0 0 0 0 0;
     0 0 0 0 1 0 0 0 0 0 0 0;
     0 0 0 0 0 1 0 0 0 0 0 0;
     0 0 0 0 0 0 1 0 0 0 0 0;
     -1 0 0 0 0 0 0 0 0 0 0 0;
     0 -1 0 0 0 0 0 0 0 0 0 0;
     0 0 -1 0 0 0 0 0 0 0 0 0;
     0 0 0 -1 0 0 0 0 0 0 0 0;
     0 0 0 0 -1 0 0 0 0 0 0 0;
     0 0 0 0 0 -1 0 0 0 0 0 0;
     0 0 0 0 0 0 -1 0 0 0 0 0;
     0 0 0 0 0 0 0 0 0 0 0 0;
     0 0 0 0 0 0 0 0 0 0 0 0;
     0 0 0 0 0 0 0 0 0 1 0 0;
     0 0 0 0 0 0 0 0 0 0 1 0;
     0 0 0 0 0 0 0 0 0 0 0 1];
     
 
 b = [10;10;10;10;10;10;10;10;10;10;10;10;10;10;0;0;0;0;0];
 
 lsqlin(C,d,A,b)