function t = testing
  A = [[1,0,0,2],
  [0,1,0,0],
  [0,0,0,0],
  [3,0,-2,0]];
  C = [[1,0,0,2],
  [0,1,0,0],
  [0,0,0,0]];
  BRow = [3,0,-2,0];
  t = CSRSparseMatrix(C)
  t = t.addRow(BRow)
endfunction
