

%% Punto b)
clear all;
close all;
N = 20000;
SNR = 20;
[X,S,V,U] = armar_seniales(N, SNR);

graf = figure;
hold on
plot(V);
plot(U);
grid on
legend('V','U')
title('Ruidos V y U')
xlabel('n') 
ylabel('Nivel') 
axis([18000 18100 -0.015 0.015])
saveas(graf,'b_1.png')

graf = figure;
plot(S);
grid on
title('S - Señal de interés')
xlabel('n') 
ylabel('Nivel') 
saveas(graf,'b_2.png')

graf = figure;
plot(X);
grid on
title('X - Señal con ruido')
xlabel('n') 
ylabel('Nivel') 
saveas(graf,'b_3.png')

%% Punto c)
clear all;
close all;

N = 20000;
SNR = 20;

mu = 50;
w0 = [5 5 5]'; % valores iniciales del filtro
[M,L] = size(w0);

realizaciones = 500;
J_est = zeros(N,1);
Err_est = zeros(N,1);

for i = 1:realizaciones
    
    [X,S,V,U] = armar_seniales(N, SNR);
    [W, V_est] = filtro_ruido(X, U, mu, w0);
 
    S_est = (X - V_est);
    Err_est = Err_est + (S_est - S).^2/realizaciones;
    J_est = J_est + (V_est - V).^2/realizaciones;
    
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
saveas(graf,'c_1.png')

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
saveas(graf,'c_2.png')

graf = figure;
title('Coeficientes de W')
lgd = cell(M,1);
hold on
for i = 1:M
    plot(W(i,:))
    lgd{i} = strcat('w_',num2str(i-1));
end
grid on
legend(lgd);
xlabel('n') 
ylabel('W(n)') 
saveas(graf,'c_3.png')

graf = figure;
plot(Err_est)
grid on
title('Curva de Error (500 realizaciones)')
xlabel('n') 
ylabel('Err(n)') 
saveas(graf,'c_4.png')

graf = figure;
plot(J_est)
grid on
title('Curva de aprendizaje J (500 realizaciones)')
xlabel('n') 
ylabel('J(n)') 
saveas(graf,'c_5.png')

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
    w0 = [w0; 5;];
    for i = 1:realizaciones
        [X,S,V,U] = armar_seniales(N, SNR);
        [W, V_est] = filtro_ruido(X, U, mu, w0);

        S_est = (X - V_est);
        Err_est = Err_est + (S_est - S).^2/realizaciones;
        J_est = J_est + (V_est - V).^2/realizaciones;
    end
    E(m) = mean(Err_est(convergencia_err:end));
end

graf = figure;
plot(E);
title('Error vs M')
grid on
xlabel('M') 
ylabel('Error(M)') 
saveas(graf,'d_1.png')

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

graf = figure;
title('Curvas de aprendizaje para valores de MU')
xlabel('n') 
ylabel('J(n)') 
grid on
hold on
lgd = cell(7,1);
for index = 1:M
    mu = MU(index);
    J_est = zeros(N,1);
    Err_est = zeros(N,1);
    for i = 1:realizaciones
        [X,S,V,U] = armar_seniales(N, SNR);
        [W, V_est] = filtro_ruido(X, U, mu, w0);

        S_est = (X - V_est);
        Err_est = Err_est + (S_est - S).^2/realizaciones;
        J_est = J_est + (V_est - V).^2/realizaciones;
    end
    
    E(index) = mean(Err_est(convergencia_err:end));
    plot(Err_est);
    lgd{index} = strcat('mu=',num2str(mu));
end
axis([0 2e4 0 5e-4])
legend(lgd);
saveas(graf,'e_1.png')

graf = figure;
plot(MU, E);
title('Error vs MU')
grid on
xlabel('MU') 
ylabel('Error(MU)') 
saveas(graf,'e_2.png')

%% f)
clear all;
close all;

SNR = 20;
realizaciones = 50;
mu = 40;
w0 = [5 5]';
M = 2;

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
    [W, V_est] = filtro_ruido(X, U, mu, w0);

    S_est = (X - V_est);
    Err_est = Err_est + (S_est - S).^2/realizaciones;
    J_est = J_est + (V_est - V).^2/realizaciones;
end

% graficos

graf = figure;
plot(S_est)
hold on
title('Estimacion de S')
plot(S);
grid on
legend('S_est','S')
xlabel('n') 
ylabel('Nivel') 
axis([310000 310200 -0.1 0.1])
saveas(graf,'f_1.png')

graf = figure;
title('Coeficientes de W')
lgd = cell(M,1);
hold on
for i = 1:M
    plot(W(i,:))
    lgd{i} = strcat('w_',num2str(i-1));
end
grid on
legend(lgd);
xlabel('n') 
ylabel('W(n)') 
saveas(graf,'f_2.png')

graf = figure;
plot(Err_est)
grid on
title('Curva de Error (50 realizaciones)')
xlabel('n') 
ylabel('Err(n)') 
axis([0 30000 0 3.5e-4])
saveas(graf,'f_3.png')

graf = figure;
plot(J_est)
grid on
title('Curva de aprendizaje J (50 realizaciones)')
xlabel('n') 
ylabel('J(n)') 
axis([0 30000 0 3.5e-4])
saveas(graf,'f_4.png')

%%
% Escuchamos el audio con ruido
sound(X, fs);
%%
% Escuchamos el audio filtrado
sound(S_est, fs);
%%
% Escuchamos el audio original
sound(S, fs);
