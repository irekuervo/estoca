function [X,S,V,U] = armar_audio(audio, SNR)
a = 1;
bS = [1 0.9 0.5 0.45 0.35 0.25];
bU = [0.8 0.2 -0.1];
varianzaS = 5e-4;
mediaR = 0;

[N, filas] = size(audio);

% S - señal de interes
varianzaAudio = var(audio);
% Llevamos la varianza del audio a varianzaS
S = audio./sqrt(varianzaAudio) .* sqrt(varianzaS);

% V - señal de ruido blanco: debe cumplir SNR(S,V) = 20dB
varianzaV = varianzaS / (10^(SNR/10));
V = normrnd(mediaR, sqrt(varianzaV), N, 1);

% U - señal de ruido correlacionado
U = filter(bU, a, V);

% X
X = S + V;
end

