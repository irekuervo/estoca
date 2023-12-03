
%%

% CARGAR EN EL PATH LA CARPETA DEL EJ1 y EJ2

%%

clear all;
close all;

%% a)
N = 20000;
fs = 44100;
SNR = 20;
Repeticiones = 500;

for i = 1:Repeticiones
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

    % vemos los resultados
    J_est = zeros(N,1);
    Err_est = zeros(N,1);

    S_est = (X - G_est-V_est);
    Err_est = Err_est + (S_est - S).^2;
end
    
figure()
plot(G_est)
hold on
plot(G);
legend('G_est','G')

figure()
plot(S_est)
hold on
plot(S);
legend('S_est','S')

figure()
plot(Err_est)
figure()
plot(J_est)

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