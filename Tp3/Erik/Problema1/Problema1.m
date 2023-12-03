

%% Punto b)
clear all;
close all;
N = 20000;
SNR = 20;
[X,S,V,U] = armar_seniales(N, SNR);

figure()
hold on
plot(V);
plot(U);
legend('V','U')

figure()
plot(S);

figure()
plot(X);

%% Punto c)
clear all;
close all;

N = 20000;
SNR = 20;

mu = 50;
w0 = [5 5 5 5 5]'; % valores iniciales del filtro
[M,L] = size(w0);

realizaciones = 500;
J_est = zeros(N,1);
Err_est = zeros(N,1);

for i = 1:realizaciones
    
    [X,S,V,U] = armar_seniales(N, SNR);
    [W, V_est] = filtro1(S, V, U, mu, w0);
 
    S_est = (X - V_est);
    Err_est = Err_est + (S_est - S).^2/realizaciones;
    J_est = J_est + (V_est - V).^2/realizaciones;
    
    % Para debuggear
    if i == 1
        figure()
        plot(V_est)
        hold on
        plot(V);
        legend('V_est','V')
        
        figure()
        plot(S_est)
        hold on
        plot(S);
        legend('S_est','S')
        
        figure()
        plot(Err_est)
        figure()
        plot(J_est)
    end
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

%% d)
clear all;
close all;

M = 5;
N = 20000;
SNR = 20;

mu = 50;
w0 = [];
convergencia_err = 7000;
realizaciones = 500;
E = zeros(M, 1);

for m = 1:M
    J_est = zeros(N,1);
    Err_est = zeros(N,1);
    w0 = [w0 5]';
    for i = 1:realizaciones
        [X,S,V,U] = armar_seniales(N, SNR);
        [W, V_est] = filtro1(S, V, U, mu, w0);

        S_est = (X - V_est);
        Err_est = Err_est + (S_est - S).^2/realizaciones;
        J_est = J_est + (V_est - V).^2/realizaciones;
    end
    E(m) = mean(Err_est(convergencia_err:end));
end

plot(E);

%% e)
clear all;
close all;

MU = [30 40 50 60 70 80 90 100];
[filas, M] = size(MU);
N = 20000;
SNR = 20;

w0 = [5 5]';
convergencia_err = 7000;
realizaciones = 500;
E = zeros(M, 1);

figure()
hold on
lgd = cell(7,1);
for index = 1:M
    mu = MU(index);
    J_est = zeros(N,1);
    Err_est = zeros(N,1);
    for i = 1:realizaciones
        [X,S,V,U] = armar_seniales(N, SNR);
        [W, V_est] = filtro1(S, V, U, mu, w0);

        S_est = (X - V_est);
        Err_est = Err_est + (S_est - S).^2/realizaciones;
        J_est = J_est + (V_est - V).^2/realizaciones;
    end
    
    E(index) = mean(Err_est(convergencia_err:end));
    plot(Err_est);
    lgd{index} = strcat('mu=',num2str(mu));
end

legend(lgd);

figure()
plot(MU, E);

%% f)
clear all;
close all;

SNR = 20;
realizaciones = 1;
mu = 50;
w0 = [5 5 5]';
M = 3;

[audio, fs] = audioread('Pista_05.wav');
[N, filas] = size(audio);

%%% Prueba de armar_audio
%   [X,S,V,U] = armar_audio(audio, SNR);
%   Escuchamos que el audio tenga ruido
%   sound(X, fs);

J_est = zeros(N,1);
Err_est = zeros(N,1);
for i = 1:realizaciones
    [X,S,V,U] = armar_audio(audio, SNR);
    [W, V_est] = filtro1(S, V, U, mu, w0);

    S_est = (X - V_est);
    Err_est = Err_est + (S_est - S).^2/realizaciones;
    J_est = J_est + (V_est - V).^2/realizaciones;
end

% Escuchamos el audio filtrado
sound(S_est, fs);

figure()
plot(Err_est)
figure()
plot(J_est)

figure()
hold on
for i = 1:M
    plot(W(i,:))
end
