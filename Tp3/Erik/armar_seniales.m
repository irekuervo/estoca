function [X,S,V,U] = armar_seniales(N, SNR)

a = 1;
bS = [1 0.9 0.5 0.45 0.35 0.25];
bU = [0.8 0.2 -0.1];
varianzaR = 5e-4;
mediaR = 0;

% S - señal de interes
R_S = normrnd(mediaR, sqrt(varianzaR), N, 1); %ruido para generar S
S = filter(bS, a, R_S);
varianzaS = var(S);

% V - señal de ruido blanco: debe cumplir SNR(S,V) = 20dB
varianzaV = varianzaS / (10^(SNR/10));
V = normrnd(mediaR, sqrt(varianzaV), N, 1);

% U - señal de ruido correlacionado
U = filter(bU, a, V);

% X
X = S + V;

end

