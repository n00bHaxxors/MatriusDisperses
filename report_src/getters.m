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
end