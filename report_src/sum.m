%============sum=========================================================
%
%%% Donats obj i una altre matriu dispersa de la mateixa mida;
%%%% retorna la suma de les dues matrius
%
function res = plus(obj, B)
  nRowsA = length(obj.Matrix.beginningRow)-1;
  nRowsB = length(B.Matrix.beginningRow)-1;
  assert(obj.Matrix.nColumns == B.Matrix.nColumns && nRowsA == nRowsB)
  res = CSRSparseMatrix([]);
  res.Matrix.nColumns = obj.Matrix.nColumns;      
  for i=1:nRowsB
    rowA = obj.getRow(i);
    rowB = B.getRow(i);
    res = res.addRow(rowA+rowB);
  end
end