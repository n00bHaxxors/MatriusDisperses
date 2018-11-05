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
