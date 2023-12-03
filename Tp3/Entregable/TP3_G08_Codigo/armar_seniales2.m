function [X,S,G,Y] = armar_seniales2(N,fs)

a = 1;
bS = [1 0.9 0.5 0.45 0.35 0.25];
varianzaR = 5e-4;
mediaR = 0;

% S - señal de interes
R_S = normrnd(mediaR, sqrt(varianzaR), N, 1); %ruido para generar S
S = filter(bS, a, R_S);

% G - señal de interferencia
Amplitud = normrnd(0.1,sqrt(0.003),1);
Fase = unifrnd(0,2*pi);
G = Amplitud*sin(2*pi*500/fs*(1:N)+Fase)';

% Y - señal de referencia
Y = zeros(N,2);
Y(:,1) = sin(2*pi*500/fs*(0:N-1));
Y(:,2) = cos(2*pi*500/fs*(0:N-1));

%X - señal total
X = S + G;

end

