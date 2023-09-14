%%%%% TP1 EsperanzaBloque

function [Esperanza] = EsperanzaBloque (Bloque)

BloqueSize = size(Bloque);
Esperanza = zeros(BloqueSize(1),1);

for i = 1:BloqueSize(1)
    Esperanza(i) = mean(Bloque(i,:));
end