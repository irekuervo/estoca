function [X,S,G,Y] = armar_audio2(audio, fs)

[N, filas] = size(audio);

% S - señal de interes
S = audio;

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

