%%%%% TP1 Transformada

function [Resultado,MatrTrans] = Transformada(Bloque,CR)

%%% Para obtener los bloques ordenados comprimidos lo que se hace primero
%%% es obterner la esperanza y matriz de covariaza. Lo segondo es
%%% descomponer la matriz de covarianza en matriz de autovalores y
%%% autovectores. De estas matrices nos quedamos con el CR*100 porciento de
%%% los autovalores y autovectores. Finalente, luego de restartarle la
%%% esperanza, utilizamos la utilizando una matriz formada por los 
%%% autovectores con los que nos quedamos para transformar los bloques
%%% ordenados en una matriz con menos componentes.

%%% Devolvemos la matriz transformada y la matriz de transformacion. No
%%% devolvemos la esperanza porque esa se puede calcular previamente fuera
%%% de la transformacion

EspeMatr = EsperanzaBloque(Bloque);
CovMatr = CovBloque(Bloque);

Dim = size(CovMatr);
CantAutoVal = floor(Dim(1)*CR);

[MatrTrans,AutoValReducidos] = eigs(CovMatr,CantAutoVal);


for i = 1:size(EspeMatr)
    Bloque(i,:) = Bloque(i,:) - EspeMatr(i);
end

Resultado = MatrTrans'*Bloque;



