function Resultado = PSDAnalitico(LPC,G,N)

Resultado = zeros(N,1);
W =  linspace(0,pi,N);
VectorK = 1:length(LPC);

for i = 1:N
    VectorTransformador = exp(-j*W(i)*VectorK);
    Resultado(i) = (G/(abs(1-VectorTransformador*LPC)))^2;
end

end