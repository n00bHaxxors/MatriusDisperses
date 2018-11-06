%==============Constructor==================================================
%
% El constructor rep una matriu i hi aplica el metode, tornant un objecte
%%% de tipus CSRSparseMatrix.
%
function obj = CSRSparseMatrix(A)
  [m,n] = size(A);
  obj.Matrix.nColumns = n;
  obj.Matrix.values = [];
  obj.Matrix.columns = [];
  obj.Matrix.beginningRow = [1];
  for i = 1:m
    nonZero=obj.Matrix.beginningRow(i);
    nonZeroThisRow=0;
    for j = 1:n
      if(A(i,j) ~= 0)
        obj.Matrix.values = [obj.Matrix.values, A(i,j)];
        obj.Matrix.columns = [obj.Matrix.columns, j];
        nonZeroThisRow=nonZeroThisRow+1;
      end
    end
    obj.Matrix.beginningRow = [obj.Matrix.beginningRow, nonZero+nonZeroThisRow];
  end
end