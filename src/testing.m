function [t,t2] = testing
  A = [[1,0,0,2],
  [0,1,0,0],
  [0,0,0,0],
  [3,0,-2,0]];
  C = [[1,0,0,2],
  [0,1,0,0],
  [0,0,0,0]];
  BRow = [3,0,-2,0];
  t = CSRSparseMatrix(A)
  t2 = t.multColumn(BRow)
endfunction
