%============mtimes=========================================================
%
%%% Donats obj de mida m*n i una matriu dispersa B de mida n*o,
%%%% retorna el resultat de la multiplicació obj*B de mida m*o
% 
function res = mtimes(obj, B)
  nRowsA = length(obj.Matrix.beginningRow)-1;
  nRowsB = length(B.Matrix.beginningRow)-1;
  assert(obj.Matrix.nColumns == nRowsB)
  res = CSRSparseMatrix([]);
  res.Matrix.nColumns = B.Matrix.nColumns;      
  
  for i=1:nRowsB
    row = obj.getRow(i);
    res = res.addRow(B.multRow(row));
  end
end