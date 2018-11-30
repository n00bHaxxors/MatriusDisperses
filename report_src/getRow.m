%============getRow=========================================================
%
%%% Donats obj, sent el objecte actual, i x la fila que volem obtenir;
%%%% retorna la fila x de la matriu obj
%
function row = getRow(obj, x)
  row = 0;
  for i= 1:obj.Matrix.nColumns
    row(i)=0;
  end
  for i = obj.Matrix.beginningRow(x):obj.Matrix.beginningRow(x+1)-1
    row(obj.Matrix.columns(i)) = obj.Matrix.values(i);
  end
end