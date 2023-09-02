%%%%% TP1 AntiTransformada

function [Original] = AntiTransformada(Resultado,MatrTrans,VectMed)

Original = MatrTrans*Resultado;

for i = 1:size(VectMed)
    Original(i,:) = Original(i,:) + VectMed(i);
end
    
