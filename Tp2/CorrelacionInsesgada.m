function Resultado = CorrelacionInsesgada(XVector)
N = length(XVector);
Resultado = zeros(N,1);
for i = 1:N
    acum = 0;
        for j = i:N-1
            acum = acum+XVector(j)*XVector(j-i+1);
        end
   Resultado(i) = acum/(N-i+1);
end

end