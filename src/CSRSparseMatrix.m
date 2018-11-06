%===============CSRSparseMatrix=================================================
% Classe que implementa el mètode d'emmagatzematge per files sobre matrius 
%%% disperses
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
    %=============FI CONSTRUCTOR ===============================================
    
    %============getRow=========================================================
    %
    %%% Donats obj, sent el objecte actual, i x la fila que volem obtenir;
    %%%% retorna la fila x de la matriu obj
    %
    function row = getRow(obj, x)
      %row = 0;
      %for i= 1:obj.Matrix.nColumns
       % row(i)=0;
      %end
      row = zeros(1,obj.Matrix.nColumns);
      for i = obj.Matrix.beginningRow(x):obj.Matrix.beginningRow(x+1)-1
        row(obj.Matrix.columns(i)) = obj.Matrix.values(i);
      end
    end
    
    %============getElem=========================================================
    %
    %%% Donats obj, sent el objecte actual i (x,y) les coordenades del element 
    %%%% que volem obtenir;
    %%%% retorna l'element x,y de la matriu obj
    %
    function elem = getElem(obj, x, y)
      row = obj.getRow(x);
      elem = row(y);
    end
    
    %============getColumn=========================================================
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
      column = transpose(column);
    end
    %============addRow=========================================================
    %
    %%% Donats obj, sent el objecte actual, i row la fila que volem afegir;
    %%%% retorna obj amb la fila nova afegida
    %
    function obj = addRow(obj, row)
      i=size(obj.Matrix.beginningRow,2);
      nonZero=obj.Matrix.beginningRow(i);
      nonZeroThisRow=0;
      [_,n] = size(row);
      for j = 1:n
        if(row(j) ~= 0)
          obj.Matrix.values = [obj.Matrix.values, row(j)];
          obj.Matrix.columns = [obj.Matrix.columns, j];
          nonZeroThisRow=nonZeroThisRow+1;
        end
      end
      obj.Matrix.beginningRow = [obj.Matrix.beginningRow, nonZero+nonZeroThisRow];
    end
    
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
    
    %============multRow=====================================================
    %
    %%% Donats obj i un vector de la mateixa mida que les columnes de obj
    %%%% retorna el resultat de la multiplicació b*obj
    %
    function res = multRow(obj,b)
      res = zeros(1, length(obj.Matrix.beginningRow)-1);
      assert(obj.Matrix.nColumns == length(b));
      for i=1:obj.Matrix.nColumns
        bi = b(i);
        for ii = obj.Matrix.beginningRow(i):obj.Matrix.beginningRow(i+1)-1
          j = obj.Matrix.columns(ii);
          res(j) = res(j) + obj.Matrix.values(ii)*bi;
        end
      end
    end
    
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
    
  end
end