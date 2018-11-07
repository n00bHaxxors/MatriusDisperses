%============multRow=====================================================
%
%%% Donats obj i un vector de la mateixa mida que les columnes de obj
%%%% retorna el resultat de la multiplicació b*obj
%
function res = multRow(obj,b)
  res = zeros(1, length(obj.Matrix.beginningRow)-1);
  nFiles=size(obj.Matrix.beginningRow,2)-1;
  assert(nFiles == length(b));
  for i=1:obj.Matrix.nColumns
    bi = b(i);
    for ii = obj.Matrix.beginningRow(i):obj.Matrix.beginningRow(i+1)-1
      j = obj.Matrix.columns(ii);
      res(j) = res(j) + obj.Matrix.values(ii)*bi;
    end
  end
end