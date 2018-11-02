function [t,t2] = testing
  A = [[1,0,0,2],
  [0,1,0,0],
  [0,0,0,0],
  [3,0,-2,0]];
  C = [[1,0,0,2],
  [0,1,0,0],
  [0,0,0,0],
  [1,0,1,2]];
  B = [3;0;-2;0];
  D= [3,0,-2,0];
  t1 = CSRSparseMatrix(A)
  t2 = t1*(CSRSparseMatrix(C))
  t=t1+(CSRSparseMatrix(C))
  %t.multColumn(B)
endfunction
