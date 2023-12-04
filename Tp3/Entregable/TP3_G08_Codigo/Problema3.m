
%%

% CARGAR EN EL PATH LA CARPETA DEL EJ1 y EJ2

%%



%% a)
clear all;
close all;

N = 20000;
fs = 44100;
SNR = 20;
realizaciones = 500;
J_est = zeros(N,1);
Err_est = zeros(N,1);

for i = 1:realizaciones
    [X1,S,V,U] = armar_seniales(N, SNR);
    [X2,S2,G,Y] = armar_seniales2(N,fs);

    X = S + G + V;

    % filtramos primero el ruido
    mu = 50;
    w0 = [5 5 5]'; % valores iniciales del filtro
    [M,L] = size(w0);
    [W, V_est] = filtro_ruido(X, U, mu, w0);

    % filtramos la interferencia
    mu = 1e-3;
    w0 = [0 0]'; % valores iniciales del filtro
    [M,L] = size(w0);
    [W, G_est] = filtro_interferencia(X, Y, mu, w0);

    S_est = (X - G_est-V_est);
    Err_est = Err_est + (S_est - S).^2/realizaciones;
    J_est = J_est + (G_est - G).^2/realizaciones;
end
    
graf = figure;
plot(V_est)
hold on
plot(V);
grid on
title('Estimación de V')
legend('V_est','V')
xlabel('n') 
ylabel('Nivel') 
axis([18000 18100 -0.01 0.01])
saveas(graf,'b_1.png')

graf = figure;
plot(G_est)
hold on
plot(G);
grid on
title('Estimación de G')
legend('V_est','V')
xlabel('n') 
ylabel('Nivel') 
axis([18000 18500 -0.4 0.4])
saveas(graf,'b_2.png')

graf = figure;
plot(S_est)
hold on
title('Estimacion de S')
plot(S);
grid on
legend('S_est','S')
xlabel('n') 
ylabel('Nivel') 
axis([18000 18100 -0.1 0.1])
saveas(graf,'b_3.png')

graf = figure;
plot(Err_est)
grid on
title('Curva de Error (500 realizaciones)')
xlabel('n') 
ylabel('Err(n)') 
saveas(graf,'b_4.png')

%% b)

[audio, fs] = audioread('Pista_01.wav');
[N, filas] = size(audio);

N = 20000;
fs = 44100;
SNR = 20;
[X,S,V,U] = armar_audio(audio, SNR);
[X2,S2,G,Y] = armar_audio2(audio, fs);

X = S + G + V;

% escuchamos el audio
%sound(X, fs);

% filtramos primero el ruido
mu = 50;
w0 = [5 5 5]'; % valores iniciales del filtro
[M,L] = size(w0);
[W, V_est] = filtro_ruido(X, U, mu, w0);

% filtramos la interferencia
mu = 1e-3;
w0 = [0 0]'; % valores iniciales del filtro
[M,L] = size(w0);
[W, G_est] = filtro_interferencia(X, Y, mu, w0);

% escuchamos el audio filtrado
S_est = X- G_est-V_est;

%%
% Escuchamos el audio con ruido
sound(X, fs);
%%
% Escuchamos el audio filtrado
sound(S_est, fs);
%%
% Escuchamos el audio original
sound(S, fs);