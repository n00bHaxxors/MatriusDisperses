%============addRow=========================================================
%
%%% Donats obj, sent el objecte actual, i row la fila que volem afegir;
%%%% retorna obj amb la fila nova afegida
%
function obj = addRow(obj, row)
  i=size(obj.Matrix.beginningRow,2)
  nonZero=obj.Matrix.beginningRow(i)
  nonZeroThisRow=0;
  [_,n] = size(row);
  for j = 1:n
    if(row(j) ~= 0)
      obj.Matrix.values = [obj.Matrix.values, row(j)]
      obj.Matrix.columns = [obj.Matrix.columns, j]
      nonZeroThisRow=nonZeroThisRow+1
    end
  end
  obj.Matrix.beginningRow = [obj.Matrix.beginningRow, nonZero+nonZeroThisRow];
end