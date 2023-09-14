%%%%% TP1 AntiTransformada

function [Original] = AntiTransformada(Resultado,MatrTrans,VectMed)

%%% Para obtener los bloques ordenados originales (con pérdida de
%%% información porque se suprimieron autovalores) lo que se hace es
%%% multiplicar los bloques transformados por la matriz de transformación y
%%% luego le sumamos la media  X = h*Y + E[X]

Original = MatrTrans*Resultado;

for i = 1:size(VectMed)
    Original(i,:) = Original(i,:) + VectMed(i);
end
    
