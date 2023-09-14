%%%%% TP1 EsperanzaBloque

function [Esperanza] = EsperanzaBloque (Bloque)

%%% Calculo la esperanza de cada uno de los componentes. Lo hago de esta
%%% manera porque tengo una version vieja de matlab

BloqueSize = size(Bloque);
Esperanza = zeros(BloqueSize(1),1);

for i = 1:BloqueSize(1)
    Esperanza(i) = mean(Bloque(i,:));
end