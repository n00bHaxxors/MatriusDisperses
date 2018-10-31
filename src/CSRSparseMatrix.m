%===============CSRSparseMatrix=================================================
% Classe que implementa el mètode d'emmagatzematge per files sobre matrius 
%%% disperses
%
% El constructor rep una matriu i hi aplica el metode, tornant un objecte
%%% de tipus CSRSparseMatrix.
%
classdef CSRSparseMatrix
  properties
    Matrix 
    %%% La matriu (estructura de quatre elements:
    %%%                  n: Matrix.nColumns, 
    %%%                  valors: Matrix.values, 
    %%%                  columnes: Matrix.columns, 
    %%%                  inici files: Matrix.beginningRow)
  end

  methods
    %==============Constructor==================================================
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
    %=============FI CONSTRUCTOR ===============================================
    
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
    
    %============getElem========================================================
    %
    %%% Donats obj, sent el objecte actual i (x,y) les coordenades del element 
    %%%% que volem obtenir;
    %%%% retorna l'element x,y de la matriu obj
    %
    function elem = getElem(obj, x, y)
      row = obj.getRow(x);
      elem = row(y);
    end
    
    %============getColumn======================================================
    %
    %%% Donats obj, sent el objecte actual, i y la columna que volem obtenir;
    %%%% retorna la columna y de la matriu obj
    %
    function column = getColumn(obj, y)
      column = 0;
      m=size(obj.Matrix.beginningRow,2)-1;
      for j=1:m
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
    end
        
    %============addRow=========================================================
    %
    %%% Donats obj, sent el objecte actual, i y la fila que volem afegir;
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
    
  end
end