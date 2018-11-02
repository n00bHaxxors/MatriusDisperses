 %============multColumn=====================================================
%
%%% Donats obj i un vector de la mateixa mida que les files de obj
%%%% retorna el resultat de la multiplicació obj*b
% 
function res = multColumn(obj, b)
  res=zeros(1, length(obj.Matrix.nColumns));
  m = length(obj.Matrix.beginningRow)-1;
  assert ( m == length(b));
  for i = 1:m
    row = obj.getRow(i);
    res(i)= row * b;
  end
  res = transpose(res);    
end