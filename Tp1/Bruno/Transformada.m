%%%%% TP1 Transformada

function [Resultado,MatrTrans] = Transformada(Bloque,CR)

EspeMatr = EsperanzaBloque(Bloque);
CovMatr = CovBloque(Bloque);

Dim = size(CovMatr);
CantAutoVal = floor(Dim(1)*CR);

[MatrTrans,AutoValReducidos] = eigs(CovMatr,CantAutoVal);


for i = 1:size(EspeMatr)
    Bloque(i,:) = Bloque(i,:) - EspeMatr(i);
end

Resultado = MatrTrans'*Bloque;



