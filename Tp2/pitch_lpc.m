function [LPC, G, pitchIndex, pitchMagnitud] = pitch_lpc(Xs,P, alfa)

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

%% buscamos el pitch
filter_coefs = [1];
filter_coefs = [filter_coefs -1*LPC'];
e = filter(filter_coefs, 1, Xs);

eCorr = CorrelacionInsesgada(e);
pitch_indexes = find(eCorr > alfa, 1,'last');

if isempty(pitch_indexes)
    pitchIndex = 0;
    pitchMagnitud = 0;
else
    pitchIndex = pitch_indexes(1);
    pitchMagnitud = eCorr(pitchIndex);
end

end