clear all;
close all;

%% Punto b)
N = 20000;
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
varianzaV = varianzaS / (10^2);
V = normrnd(mediaR, sqrt(varianzaV), N, 1);

% U - señal de ruido correlacionado
U = filter(bU, a, V);

%% Punto c)
mu = 50;
w0 = [5 5 5 5 5]'; % valores iniciales del filtro
[M,L] = size(w0);

realizaciones = 1;
J_est = zeros(N,1);
Err_est = zeros(N,1);

for i = 1:realizaciones
    [W, V_est, J_est_i, Err_est_i] = noise_filtering(S, V, U, mu, w0);
    Err_est = Err_est + Err_est_i./realizaciones;
    J_est = J_est + J_est_i./realizaciones;
    
    figure()
    plot(V)
    hold on
    plot(V_est);
    
end

figure()
plot(Err_est)
figure()
plot(J_est)

figure()
hold on
for i = 1:M
    plot(W(i,:))
end