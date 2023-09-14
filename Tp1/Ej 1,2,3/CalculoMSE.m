%%%%% TP1

function Resultado = CalculoMSE(Original, Reconstruido)

aux = size(Original);

if length(aux) == 2
    Resultado = sum(sum((Original-Reconstruido).^2))/(aux(1)*aux(2));
else
    Resultado = sum(sum(sum((Original-Reconstruido).^2)))/ ...
        (aux(1)*aux(2)*aux(3));
end


