%============getColumn=========================================================
%
%%% Donats obj, sent el objecte actual, i y la columna que volem obtenir;
%%%% retorna la columna y de la matriu obj
%
function column = getColumn(obj, y)
  column = 0;
  nFiles=size(obj.Matrix.beginningRow,2)-1;
  for j=1:nFiles
    column(j)=0;
    for i=obj.Matrix.beginningRow(j):obj.Matrix.beginningRow(j+1)-1
      if obj.Matrix.columns(i)==y 
          column(j) = obj.Matrix.values(i);
          break
      elseif obj.Matrix.columns(i)> y 
          break
      end
    end
  end
  column = transpose(column);
end