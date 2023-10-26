function [LPC, G] = param_lpc(Xs,P)

VectorCorrelacion = CorrelacionInsesgada(Xs);

Simetria = linspace(P,1,P);

r =  VectorCorrelacion(1:P);
r_espejado = [flip(r); r(2:end)];

MatrizCorrelacion = zeros(P,P);

for i = 1:P
    MatrizCorrelacion(i,:) = r_espejado(P+1-i:P*2-i);
end

LPC = inv(MatrizCorrelacion)*VectorCorrelacion(2:P+1);

G = sqrt(VectorCorrelacion(1) - LPC'*VectorCorrelacion(2:P+1));

end
