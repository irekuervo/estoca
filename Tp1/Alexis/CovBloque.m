%%%%% TP1

function [MatCovBloque] = CovBloque (Bloque)



BloqueSize = size(Bloque);
aux = zeros(BloqueSize(1),BloqueSize(1));

EspBloque = EsperanzaBloque(Bloque);

for i = 1:BloqueSize(2)
    aux = aux + (Bloque(:,i)-EspBloque)*(Bloque(:,i)-EspBloque)';
end

MatCovBloque = aux/BloqueSize(2);