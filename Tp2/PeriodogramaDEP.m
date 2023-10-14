function Resultado = PeriodogramaDEP(LPC,G)

Resultado = zeros(1000,1);
W =  linspace(0,pi,1000);
VectorK = 1:length(LPC);

for i = 1:1000
    VectorTransformador = exp(-j*W(i)*VectorK);
    Resultado(i) = (G/(abs(1-VectorTransformador*LPC)))^2;
end

end