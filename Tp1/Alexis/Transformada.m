%%%%% TP1 Transformada

function [Resultado,MatrTrans] = Transformada(Bloque,CR)

%%% Para obtener los bloques ordenados comprimidos lo que se hace primero
%%% es obterner la esperanza y matriz de covariaza. Lo segundo es
%%% descomponer la matriz de covarianza en matriz de autovalores y
%%% autovectores. De estas matrices nos quedamos con el CR*100 porciento de
%%% los autovalores y autovectores. Finalmente, luego de restarle la
%%% esperanza, utilizamos la matriz formada por los 
%%% autovectores con los que nos quedamos para transformar los bloques
%%% ordenados en una matriz con menos componentes.

%%% Devolvemos la matriz transformada y la matriz de transformación. No
%%% devolvemos la esperanza porque esa se puede calcular previamente fuera
%%% de la transformación

EspeMatr = EsperanzaBloque(Bloque);
CovMatr = CovBloque(Bloque);

Dim = size(CovMatr);
CantAutoVal = floor(Dim(1)*CR);

[MatrTrans,AutoValReducidos] = eigs(CovMatr,CantAutoVal);


for i = 1:size(EspeMatr)
    Bloque(i,:) = Bloque(i,:) - EspeMatr(i);
end

Resultado = MatrTrans'*Bloque;



