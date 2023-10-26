function [LPC, G] = param_lpc(Xs,P)

VectorCorrelacion = CorrelacionInsesgada(Xs);

Simetria = linspace(P,1,P);

CorrelacionSimetrica = zeros(P*2-1,1);
CorrelacionSimetrica(P:end) = VectorCorrelacion(1:P);
CorrelacionSimetrica(1:P) = CorrelacionSimetrica(Simetria);

MatrizCorrelacion = zeros(P,P);

for i = 1:P
    MatrizCorrelacion(i,:) = CorrelacionSimetrica(P+1-i:P*2-i);
end

LPC = MatrizCorrelacion^(-1)*VectorCorrelacion(2:P+1);

G = sqrt(VectorCorrelacion(1) - LPC'*VectorCorrelacion(2:P+1));

if isreal(G) == 0
    %msgbox("La ganancia dio compleja");
    return;
end

end
