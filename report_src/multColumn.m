%============multColumn=====================================================
%
%%% Donats obj i un vector de la mateixa mida que les files de obj
%%%% retorna el resultat de la multiplicació obj*b
% 
function res = multColumn(obj, b)
  m = length(obj.Matrix.beginningRow)-1;
  res=zeros(1, m);
  assert ( obj.Matrix.nColumns == length(b));
  for i = 1:m
    row = obj.getRow(i);
    res(i)= row * b;
  end
  res = transpose(res);    
end